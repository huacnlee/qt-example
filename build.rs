use cxx_qt_build::CxxQtBuilder;

fn main() {
    CxxQtBuilder::new()
        .qt_module("Network")
        .file("src/cxxqt_object.rs")
        .qrc("qml/qml.qrc")
        .setup_linker()
        .build();
}
