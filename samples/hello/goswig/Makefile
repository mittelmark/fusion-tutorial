# Variables
BINARY_NAME=hello_app
MODULE_NAME=dev.local/testproject
SDK_DIR=sdk

.PHONY: all build run clean help

# Default target: builds and runs
all: build run

# Build the application
build:
	@echo "==> Cleaning cache and building..."
	go clean -cache
	export CGO_ENABLED=1; go build -o $(BINARY_NAME) main.go

# Run the compiled binary
run:
	@echo "==> Running $(BINARY_NAME):"
	./$(BINARY_NAME)

# Remove the binary and any SWIG-generated artifacts
clean:

