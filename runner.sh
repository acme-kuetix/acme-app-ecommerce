#!/bin/bash
# Runner script for acme-app-ecommerce
set -e

GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

print_info()    { echo -e "${BLUE}[INFO]${NC} $1"; }
print_success() { echo -e "${GREEN}[OK]${NC} $1"; }
print_warn()    { echo -e "${YELLOW}[WARN]${NC} $1"; }
print_error()   { echo -e "${RED}[ERROR]${NC} $1"; }

COMMAND=${1:-"help"}

case "$COMMAND" in
    run)
        if [ -z "$2" ]; then
            print_warn "Usage: ./runner.sh run <workflow> [args...]"
            echo "Example: ./runner.sh run solutions/ecommerce/startup"
            exit 1
        fi
        print_info "Regenerating module cache..."
        kue update
        print_info "Running workflow: $2"
        go run ./cmd/cli "$2" "${@:3}"
        ;;
    start)
        PORT=${3:-9997}
        print_info "Starting Ecommerce API server on port $PORT..."
        kue update
        go run ./cmd/cli solutions/ecommerce/startup -port "$PORT"
        ;;
    validate)
        print_info "Validating all workflows..."
        if [ ! -f runtime/bin/acme-app-ecommerce ]; then
            print_info "Building validator binary..."
            GOWORK=off go build -o runtime/bin/acme-app-ecommerce ./cmd/cli 2>&1 | tail -5
        fi
        FAIL=0
        while IFS= read -r -d '' wf; do
            wf_rel="${wf#./}"
            err=$(timeout 3 runtime/bin/acme-app-ecommerce "$wf_rel" 2>&1 || true)
            if echo "$err" | grep -q "WSL parse error\|Can't load workflow"; then
                print_warn "  ✗ $wf_rel"
                echo "$err" | head -3 | sed 's/^/    /'
                ((FAIL++)) || true
            else
                print_success "  ✓ $wf_rel"
            fi
        done < <(find workflows -type f \( -name "*.wsl" -o -name "*.swsl" \) -print0)
        if [ "$FAIL" -gt 0 ]; then print_error "$FAIL workflow(s) failed validation"; exit 1; fi
        print_success "All workflows valid"
        ;;
    build)
        print_info "Building..."
        kue update
        go build -o runtime/bin/acme-app-ecommerce ./cmd/cli
        print_success "Built runtime/bin/acme-app-ecommerce"
        ;;
    clean)
        rm -f modules/di.go modules/meta.go modules/modules.json
        rm -rf runtime/bin/*
        print_success "Cleaned"
        ;;
    help|--help|-h)
        echo "Runner for acme-app-ecommerce"
        echo ""
        echo "Commands:"
        echo "  run <workflow> [args]    Run a workflow (regenerates module cache first)"
        echo "  start [port]             Start the API server (default 9997)"
        echo "  validate                 Validate all .wsl/.swsl files"
        echo "  build                    Build runtime/bin/acme-app-ecommerce"
        echo "  clean                    Remove generated files"
        ;;
    *)
        print_warn "Unknown command: $COMMAND"
        ./runner.sh help
        exit 1
        ;;
esac
