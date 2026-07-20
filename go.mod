module github.com/acme-kuetix/acme-app-ecommerce

go 1.26.4

require (
	github.com/acme-kuetix/acme-account v0.1.2
	github.com/acme-kuetix/acme-audit v0.1.2
	github.com/acme-kuetix/acme-auth v0.1.2
	github.com/acme-kuetix/acme-cart v0.1.2
	github.com/acme-kuetix/acme-company v0.1.2
	github.com/acme-kuetix/acme-currency v0.1.2
	github.com/acme-kuetix/acme-fiscal v0.1.2
	github.com/acme-kuetix/acme-invoice v0.1.2
	github.com/acme-kuetix/acme-ledger v0.1.2
	github.com/acme-kuetix/acme-partner v0.1.2
	github.com/acme-kuetix/acme-payment v0.1.2
	github.com/acme-kuetix/acme-payment-manual v0.1.2
	github.com/acme-kuetix/acme-product v0.1.2
	github.com/acme-kuetix/acme-sales v0.1.2
	github.com/acme-kuetix/acme-std-collections v0.1.2
	github.com/acme-kuetix/acme-std-core v0.1.2
	github.com/acme-kuetix/acme-std-crypto v0.1.2
	github.com/acme-kuetix/acme-std-datetime v0.1.2
	github.com/acme-kuetix/acme-std-http-client v0.1.2
	github.com/acme-kuetix/acme-std-math v0.1.2
	github.com/acme-kuetix/acme-std-money v0.1.2
	github.com/acme-kuetix/acme-std-persistence v0.1.2
	github.com/acme-kuetix/acme-std-sequence v0.1.2
	github.com/acme-kuetix/acme-std-strings v0.1.2
	github.com/acme-kuetix/acme-stock v0.1.2
	github.com/acme-kuetix/acme-tax v0.1.2
	github.com/acme-kuetix/acme-uom v0.1.2
	github.com/kuetix/container v0.1.0
	github.com/kuetix/engine v1.0.0
	github.com/kuetix/std-auth v1.0.0
	github.com/kuetix/std-core v1.0.0
	github.com/kuetix/std-http v1.0.0
)

require (
	github.com/asaskevich/EventBus v0.0.0-20200907212545-49d423059eef // indirect
	github.com/fsnotify/fsnotify v1.9.0 // indirect
	github.com/go-viper/mapstructure/v2 v2.4.0 // indirect
	github.com/golang-jwt/jwt/v5 v5.3.1 // indirect
	github.com/google/uuid v1.6.0 // indirect
	github.com/kuetix/helpers v1.0.0 // indirect
	github.com/kuetix/logger v1.0.0 // indirect
	github.com/kuetix/uuid v0.1.0 // indirect
	github.com/mitchellh/mapstructure v1.5.0 // indirect
	github.com/pelletier/go-toml/v2 v2.2.4 // indirect
	github.com/rs/cors v1.11.1 // indirect
	github.com/sagikazarmark/locafero v0.12.0 // indirect
	github.com/spf13/afero v1.15.0 // indirect
	github.com/spf13/cast v1.10.0 // indirect
	github.com/spf13/pflag v1.0.10 // indirect
	github.com/spf13/viper v1.21.0 // indirect
	github.com/subosito/gotenv v1.6.0 // indirect
	go.yaml.in/yaml/v3 v3.0.4 // indirect
	golang.org/x/crypto v0.45.0 // indirect
	golang.org/x/sys v0.42.0 // indirect
	golang.org/x/text v0.35.0 // indirect
	gopkg.in/ini.v1 v1.67.0 // indirect
)

replace (
	github.com/acme-kuetix/acme-account => ../acme-account
	github.com/acme-kuetix/acme-audit => ../acme-audit
	github.com/acme-kuetix/acme-auth => ../acme-auth
	github.com/acme-kuetix/acme-cart => ../acme-cart
	github.com/acme-kuetix/acme-company => ../acme-company
	github.com/acme-kuetix/acme-currency => ../acme-currency
	github.com/acme-kuetix/acme-fiscal => ../acme-fiscal
	github.com/acme-kuetix/acme-invoice => ../acme-invoice
	github.com/acme-kuetix/acme-ledger => ../acme-ledger
	github.com/acme-kuetix/acme-partner => ../acme-partner
	github.com/acme-kuetix/acme-payment => ../acme-payment
	github.com/acme-kuetix/acme-payment-manual => ../acme-payment-manual
	github.com/acme-kuetix/acme-product => ../acme-product
	github.com/acme-kuetix/acme-sales => ../acme-sales
	github.com/acme-kuetix/acme-std-collections => ../acme-std-collections
	github.com/acme-kuetix/acme-std-core => ../acme-std-core
	github.com/acme-kuetix/acme-std-crypto => ../acme-std-crypto
	github.com/acme-kuetix/acme-std-datetime => ../acme-std-datetime
	github.com/acme-kuetix/acme-std-http-client => ../acme-std-http-client
	github.com/acme-kuetix/acme-std-math => ../acme-std-math
	github.com/acme-kuetix/acme-std-money => ../acme-std-money
	github.com/acme-kuetix/acme-std-persistence => ../acme-std-persistence
	github.com/acme-kuetix/acme-std-sequence => ../acme-std-sequence
	github.com/acme-kuetix/acme-std-strings => ../acme-std-strings
	github.com/acme-kuetix/acme-stock => ../acme-stock
	github.com/acme-kuetix/acme-tax => ../acme-tax
	github.com/acme-kuetix/acme-uom => ../acme-uom
	github.com/kuetix/components => ../components
	github.com/kuetix/container => ../container
	github.com/kuetix/cryptor => ../cryptor
	github.com/kuetix/engine => ../engine
	github.com/kuetix/helpers => ../helpers
	github.com/kuetix/logger => ../logger
	github.com/kuetix/std-auth => ../std-auth
	github.com/kuetix/std-cli => ../std-cli
	github.com/kuetix/std-core => ../std-core
	github.com/kuetix/std-http => ../std-http
	github.com/kuetix/uuid => ../uuid
)
