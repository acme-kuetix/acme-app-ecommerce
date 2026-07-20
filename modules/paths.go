package modules

// WorkflowPathList is the ordered list of workflow directories walked by the
// engine. acme-app-ecommerce's own workflows/ directory is first (app overrides
// win); each acme-* package follows, providing the workflows that the ecommerce
// app inherits without copying. Exercises the engine's workflow path overlay.
//
// Superset of acme-app-invoicing: adds acme-cart (new), acme-sales, acme-stock,
// acme-uom — the ecommerce app needs cart CRUD + checkout composition that
// chains cart → sales order → invoice → payment → stock move.
var WorkflowPathList = []string{
	"workflows",
	"../acme-account/workflows",
	"../acme-audit/workflows",
	"../acme-auth/workflows",
	"../acme-cart/workflows",
	"../acme-company/workflows",
	"../acme-currency/workflows",
	"../acme-fiscal/workflows",
	"../acme-invoice/workflows",
	"../acme-ledger/workflows",
	"../acme-partner/workflows",
	"../acme-payment/workflows",
	"../acme-product/workflows",
	"../acme-sales/workflows",
	"../acme-stock/workflows",
	"../acme-tax/workflows",
	"../acme-uom/workflows",
	"../acme-std-collections/workflows",
	"../acme-std-datetime/workflows",
	"../acme-std-sequence/workflows",
}
