package modules

import (
	"fmt"

	_ "github.com/acme-kuetix/acme-account/modules"
	_ "github.com/acme-kuetix/acme-audit/modules"
	_ "github.com/acme-kuetix/acme-auth/modules"
	_ "github.com/acme-kuetix/acme-cart/modules"
	_ "github.com/acme-kuetix/acme-company/modules"
	_ "github.com/acme-kuetix/acme-currency/modules"
	_ "github.com/acme-kuetix/acme-fiscal/modules"
	_ "github.com/acme-kuetix/acme-invoice/modules"
	_ "github.com/acme-kuetix/acme-ledger/modules"
	_ "github.com/acme-kuetix/acme-partner/modules"
	_ "github.com/acme-kuetix/acme-payment/modules"
	_ "github.com/acme-kuetix/acme-product/modules"
	_ "github.com/acme-kuetix/acme-sales/modules"
	_ "github.com/acme-kuetix/acme-stock/modules"
	_ "github.com/acme-kuetix/acme-tax/modules"
	_ "github.com/acme-kuetix/acme-uom/modules"

	acmestdcollections "github.com/acme-kuetix/acme-std-collections/modules"
	acmestdcore "github.com/acme-kuetix/acme-std-core/modules"
	acmestdcrypto "github.com/acme-kuetix/acme-std-crypto/modules"
	acmestddatetime "github.com/acme-kuetix/acme-std-datetime/modules"
	acmestdhttpclient "github.com/acme-kuetix/acme-std-http-client/modules"
	acmestdmath "github.com/acme-kuetix/acme-std-math/modules"
	acmestdmoney "github.com/acme-kuetix/acme-std-money/modules"
	acmestdpersistence "github.com/acme-kuetix/acme-std-persistence/modules"
	acmestdsequence "github.com/acme-kuetix/acme-std-sequence/modules"
	acmestdstrings "github.com/acme-kuetix/acme-std-strings/modules"

	_ "github.com/acme-kuetix/acme-payment-manual/modules/payment-manual/transitions"

	"github.com/kuetix/engine/boot"
	di "github.com/kuetix/container"
	stdAuthModules "github.com/kuetix/std-auth/modules"
	stdHttpModules "github.com/kuetix/std-http/modules"
)

func init() {
	di.Boot()
}

func Enable() error {
	stdAuthModules.Enable()
	stdHttpModules.Enable()

	var errs []error

	if err := verifyMetaCache(); err != nil {
		errs = append(errs, err)
	}
	if err := acmestdcollections.Register(); err != nil {
		errs = append(errs, err)
	}
	if err := acmestdcore.Register(); err != nil {
		errs = append(errs, err)
	}
	if err := acmestdcrypto.Register(); err != nil {
		errs = append(errs, err)
	}
	if err := acmestddatetime.Register(); err != nil {
		errs = append(errs, err)
	}
	if err := acmestdhttpclient.Register(); err != nil {
		errs = append(errs, err)
	}
	if err := acmestdmath.Register(); err != nil {
		errs = append(errs, err)
	}
	if err := acmestdmoney.Register(); err != nil {
		errs = append(errs, err)
	}
	if err := acmestdpersistence.Register(); err != nil {
		errs = append(errs, err)
	}
	if err := acmestdsequence.Register(); err != nil {
		errs = append(errs, err)
	}
	if err := acmestdstrings.Register(); err != nil {
		errs = append(errs, err)
	}

	if len(errs) > 0 {
		return fmt.Errorf("acme-app-ecommerce/modules: %d package(s) failed Register(): %v", len(errs), errs)
	}
	return nil
}

var requiredMetaKeys = []string{
	"account", "audit", "iam", "cart", "company", "currency", "fiscal", "invoice",
	"ledger", "partner", "payment", "product", "sales", "stock", "tax", "uom",
}

func verifyMetaCache() error {
	var missing []string
	for _, key := range requiredMetaKeys {
		if _, ok := boot.MetaFunctionCache[key]; !ok {
			missing = append(missing, key)
		}
	}
	if len(missing) > 0 {
		return fmt.Errorf("acme-app-ecommerce/modules: boot.MetaFunctionCache missing keys %v — "+
			"meta.go init() did not run for these packages; WSL actions will fail at runtime", missing)
	}
	return nil
}
