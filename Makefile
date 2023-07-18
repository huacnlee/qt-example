PROJECT_NAME=example


.PHONY: build
run:
	RUST_LOG=debug cargo run

bundle:
	# cargo install cargo-bundle
	cargo bundle