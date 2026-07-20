package modules

import (
	"log"

	sequenceTransitions "github.com/acme-kuetix/acme-std-sequence/modules/sequence/transitions"
)

// defaultSeeds describes the document sequences acme-app-ecommerce expects to
// find at startup. Each is created (idempotently) if missing. Codes match the
// codes WSL workflows pass to sequence/sequence.NextByCode.
//
// Superset of acme-app-invoicing: adds cart, sales-order, sales-order-line,
// stock-move, stock-move-line, stock-location — the ecommerce app needs cart
// CRUD + checkout composition that chains cart → sales order → invoice →
// payment → stock move.
var defaultSeeds = []struct {
	code, name, prefix, suffix string
	padding, step              int
}{
	{"invoice", "Invoices", "INV/", "", 4, 1},
	{"payment", "Payments", "PAY-", "", 4, 1},
	// Counter-only packages: formatted == integer string
	{"invoice-line", "Invoice Lines", "", "", 0, 1},
	{"account", "Accounts", "", "", 0, 1},
	{"partner", "Partners", "", "", 0, 1},
	{"address", "Addresses", "", "", 0, 1},
	{"contact", "Contacts", "", "", 0, 1},
	{"product", "Products", "", "", 0, 1},
	{"tax-template", "Tax Templates", "", "", 0, 1},
	{"currency", "Currencies", "", "", 0, 1},
	{"currency-rate", "Currency Rates", "", "", 0, 1},
	{"company", "Companies", "", "", 0, 1},
	{"fiscal-year", "Fiscal Years", "", "", 0, 1},
	{"fiscal-period", "Fiscal Periods", "", "", 0, 1},
	{"journal", "Journals", "", "", 0, 1},
	{"move", "Moves", "", "", 0, 1},
	{"move-line", "Move Lines", "", "", 0, 1},
	{"user", "Users", "", "", 0, 1},
	{"group", "Groups", "", "", 0, 1},
	{"permission", "Permissions", "", "", 0, 1},
	{"audit-entry", "Audit Entries", "", "", 20, 1},
	// Ecommerce extensions: cart + sales + stock
	{"cart", "Carts", "", "", 0, 1},
	{"sales-order", "Sales Orders", "SO-", "", 4, 1},
	{"sales-order-line", "Sales Order Lines", "", "", 0, 1},
	{"stock-move", "Stock Moves", "SM-", "", 4, 1},
	{"stock-move-line", "Stock Move Lines", "", "", 0, 1},
	{"stock-location", "Stock Locations", "", "", 0, 1},
}

// init seeds the default document sequences at startup. Must run before any
// workflow that calls sequence/sequence.NextByCode. Cannot use engine.RunWorkflow
// here because the engine isn't initialized yet — init() runs at package load.
func init() {
	seedDefaultSequences()
}

// seedDefaultSequences creates each default sequence if it doesn't already
// exist. Idempotent — safe to call on every startup. Called from init() and
// by tests that reset the store.
func seedDefaultSequences() {
	for _, s := range defaultSeeds {
		if sequenceTransitions.SequenceExists(s.code) {
			continue
		}
		if err := sequenceTransitions.CreateSequence(s.code, s.name, s.prefix, s.suffix, s.padding, s.step, false, true); err != nil {
			log.Printf("[wiring] failed to seed sequence %q: %v", s.code, err)
			continue
		}
		log.Printf("[wiring] seeded sequence %q → prefix=%q padding=%d", s.code, s.prefix, s.padding)
	}
}
