# Multi-stage build for the Acme Ecommerce backend.
#
# The build context MUST be the metarepo root (..) — NOT the acme-app-ecommerce/ directory.
# acme-app-ecommerce/go.mod contains `replace` directives pointing at sibling modules
# (../acme-*, ../engine, ../std-*, ../container, ../logger, ../helpers,
# ../uuid, ../components, ../cryptor), so the Docker build needs all of them
# in scope. Use `docker build -f acme-app-ecommerce/Dockerfile .` from the metarepo root.

FROM golang:1.26-alpine AS builder

WORKDIR /src

# Copy every module the replace graph references.
# Keep this list in sync with the `replace` block in acme-app-ecommerce/go.mod.
COPY acme-app-ecommerce/ acme-app-ecommerce/
COPY engine/         engine/
COPY container/      container/
COPY logger/         logger/
COPY helpers/        helpers/
COPY uuid/           uuid/
COPY cryptor/        cryptor/
COPY components/     components/
COPY std-core/       std-core/
COPY std-http/       std-http/
COPY std-auth/       std-auth/
COPY std-cli/        std-cli/
COPY acme-account/   acme-account/
COPY acme-audit/     acme-audit/
COPY acme-auth/      acme-auth/
COPY acme-cart/      acme-cart/
COPY acme-company/   acme-company/
COPY acme-currency/  acme-currency/
COPY acme-fiscal/    acme-fiscal/
COPY acme-invoice/   acme-invoice/
COPY acme-ledger/    acme-ledger/
COPY acme-partner/   acme-partner/
COPY acme-payment/   acme-payment/
COPY acme-payment-manual/ acme-payment-manual/
COPY acme-product/   acme-product/
COPY acme-sales/     acme-sales/
COPY acme-stock/     acme-stock/
COPY acme-tax/       acme-tax/
COPY acme-uom/       acme-uom/
COPY acme-std-collections/ acme-std-collections/
COPY acme-std-core/       acme-std-core/
COPY acme-std-crypto/     acme-std-crypto/
COPY acme-std-datetime/   acme-std-datetime/
COPY acme-std-http-client/ acme-std-http-client/
COPY acme-std-math/       acme-std-math/
COPY acme-std-money/      acme-std-money/
COPY acme-std-persistence/ acme-std-persistence/
COPY acme-std-sequence/   acme-std-sequence/
COPY acme-std-strings/    acme-std-strings/

# Build acme-app-ecommerce. GOFLAGS=-mod=mod lets go resolve the replace directives
# from the local copies above. The modules/di.go, meta.go, modules.go
# generated files are checked in, so no `kue update` step is needed.
WORKDIR /src/acme-app-ecommerce
RUN GOFLAGS=-mod=mod CGO_ENABLED=0 go build -o /acme-app-ecommerce-cli ./cmd/cli

FROM alpine:3.20
RUN apk add --no-cache ca-certificates wget
WORKDIR /src/acme-app-ecommerce
COPY --from=builder /acme-app-ecommerce-cli       /src/acme-app-ecommerce/acme-app-ecommerce-cli
COPY --from=builder /src/acme-app-ecommerce/workflows  /src/acme-app-ecommerce/workflows
COPY --from=builder /src/acme-app-ecommerce/modules    /src/acme-app-ecommerce/modules
COPY --from=builder /src/acme-app-ecommerce/runtime     /src/acme-app-ecommerce/runtime
# Copy sibling acme-* + acme-std-* workflows so WorkflowsPathList relative
# paths (../acme-ledger/workflows etc.) resolve inside the container.
COPY --from=builder /src/acme-account/workflows    /src/acme-account/workflows
COPY --from=builder /src/acme-audit/workflows      /src/acme-audit/workflows
COPY --from=builder /src/acme-auth/workflows       /src/acme-auth/workflows
COPY --from=builder /src/acme-cart/workflows       /src/acme-cart/workflows
COPY --from=builder /src/acme-company/workflows    /src/acme-company/workflows
COPY --from=builder /src/acme-currency/workflows   /src/acme-currency/workflows
COPY --from=builder /src/acme-fiscal/workflows      /src/acme-fiscal/workflows
COPY --from=builder /src/acme-invoice/workflows     /src/acme-invoice/workflows
COPY --from=builder /src/acme-ledger/workflows      /src/acme-ledger/workflows
COPY --from=builder /src/acme-partner/workflows     /src/acme-partner/workflows
COPY --from=builder /src/acme-payment/workflows     /src/acme-payment/workflows
COPY --from=builder /src/acme-product/workflows     /src/acme-product/workflows
COPY --from=builder /src/acme-sales/workflows      /src/acme-sales/workflows
COPY --from=builder /src/acme-stock/workflows      /src/acme-stock/workflows
COPY --from=builder /src/acme-tax/workflows        /src/acme-tax/workflows
COPY --from=builder /src/acme-uom/workflows        /src/acme-uom/workflows
COPY --from=builder /src/acme-std-collections/workflows /src/acme-std-collections/workflows
COPY --from=builder /src/acme-std-datetime/workflows   /src/acme-std-datetime/workflows
COPY --from=builder /src/acme-std-sequence/workflows   /src/acme-std-sequence/workflows

EXPOSE 9997
CMD ["/src/acme-app-ecommerce/acme-app-ecommerce-cli", "solutions/ecommerce/startup", "-port", "9997"]
