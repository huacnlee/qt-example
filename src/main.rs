use cstr::cstr;
use qmetaobject::prelude::*;
use qmetaobject::webengine;

mod model;

static MAIN_QML: &str = "qml/main.qml";

fn main() {
    std::env::set_var("RUST_LOG", "warn");

    env_logger::init();
    qmetaobject::log::init_qt_to_rust();

    webengine::initialize();

    qml_register_type::<model::SimpleModel>(cstr!("QtExample"), 1, 0, cstr!("SimpleModel"));

    let mut engine: QmlEngine = QmlEngine::new();
    engine.load_file(MAIN_QML.into());
    engine.exec();
}
