PROJECT_NAME=example

.PHONY: build
prepare:
	cmake -S . -B build
build: prepare
	cmake --build build
run: build
	./build/$(PROJECT_NAME)