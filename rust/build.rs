use cxx_qt_build::CxxQtBuilder;

fn main() {
    CxxQtBuilder::new()
        .qt_module("Network")
        .file("src/model.rs")
        // .setup_linker()
        .build();
}
