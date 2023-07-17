# QT on Rust example

This is an example for write QT UI by Rust.

## Requirement

- QT 6
- Cmake 3.24+

## Installation

Install Rust 1.70 or later, Homebrew and XCode command line tools.

```bash
$ brew install qt
$ brew install cmake
```

## Start development

```bash
cargo run
```

## Troubleshooting

### error: 'shared_mutex' is unavailable: introduced in macOS 10.12

```
MACOSX_DEPLOYMENT_TARGET=10.15 cargo build
```
