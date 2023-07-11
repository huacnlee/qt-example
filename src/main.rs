pub mod cxxqt_object;

use cxx_qt_lib::{QGuiApplication, QQmlApplicationEngine, QString, QUrl};
// use engine::app::Env;
// use engine::app::{AppID, AppInfo, DeviceInfo, PlatformInfo};

rust_i18n::i18n!(fallback = "en");

#[tokio::main]
async fn main() {
    // Create the application and engine
    let mut app = QGuiApplication::new();
    let mut engine = QQmlApplicationEngine::new();

    // Load the QML path into the engine
    if let Some(engine) = engine.as_mut() {
        engine.load(&QUrl::from_local_file(&QString::from("qml/main.qml")));
    }

    // Start the app
    if let Some(app) = app.as_mut() {
        app.exec();
    }
}
