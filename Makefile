APP_NAME := acme-app-ecommerce
BUILD_DIR := runtime/bin
VERSION := $(shell git describe --tags --always --dirty 2>/dev/null || echo "dev")
BUILD_TIME := $(shell date -u +"%Y-%m-%dT%H:%M:%SZ")
LDFLAGS := -X 'main.Version=$(VERSION)' -X 'main.BuildTime=$(BUILD_TIME)'

.PHONY: all build run start validate clean update

all: build

build:
	@echo "Building $(APP_NAME)..."
	kue update
	go build -ldflags "$(LDFLAGS)" -o $(BUILD_DIR)/$(APP_NAME) ./cmd/cli

run: build
	./$(BUILD_DIR)/$(APP_NAME) solutions/ecommerce/startup

start: build
	./$(BUILD_DIR)/$(APP_NAME) solutions/ecommerce/startup -port 9997

validate:
	./runner.sh validate

update:
	kue update

clean:
	rm -f modules/di.go modules/meta.go modules/modules.json
	rm -rf $(BUILD_DIR)
