.PHONY: help build check run
.DEFAULT_GOAL := help

BIN_NAME := proxy-x

# cargo build
build:
	@cargo build

# cargo check
check: fmt clippy test
	@cargo check

# cargo clippy
clippy:
	@cargo clippy --all-targets --all-features --workspace -- -D warnings

# clean cargo cache
clean:
	@cargo clean

# fmt
fmt:
	@cargo fmt --all --check

# cargo build --release
release:
	@cargo build --release

# cargo run
run:
	@cargo run

# run binary generated by cargo build
run-bin:
	@./target/debug/$(BIN_NAME)

# test
test:
	@cargo test --all-features --workspace

# Show help
help:
	@echo ""
	@echo "Usage:"
	@echo "    make [target]"
	@echo ""
	@echo "Targets:"
	@awk '/^[a-zA-Z\-_0-9]+:/ \
	{ \
		helpMessage = match(lastLine, /^# (.*)/); \
		if (helpMessage) { \
			helpCommand = substr($$1, 0, index($$1, ":")-1); \
			helpMessage = substr(lastLine, RSTART + 2, RLENGTH); \
			printf "\033[36m%-22s\033[0m %s\n", helpCommand,helpMessage; \
		} \
	} { lastLine = $$0 }' $(MAKEFILE_LIST)
