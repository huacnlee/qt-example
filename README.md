# QT on Rust example

This is an example for write QT UI by Rust.

## Installation

Install Rust 1.70 or later, Homebrew and XCode command line tools.

```bash
$ brew install qt
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

### How to use FluentUI in this project?

https://github.com/zhuzichu520/FluentUI/issues/156

```bash
open /opt/homebrew/share/qt/qml
```

1. Download FluentUI example app
2. Show package contents
3. Copy `Contents/Resources/qml/FluentUI` folder to `/opt/homebrew/share/qt/qml` folder.
4. Copy `Frameworks/libfluentuiplugin.dylib` to `/opt/homebrew/lib/qt/qml/FluentUI` folder.
