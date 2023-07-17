#include <QtGui/QGuiApplication>
#include <QtQml/QQmlApplicationEngine>

#include <QtWebEngineQuick>

int main(int argc, char *argv[])
{
  QCoreApplication::setAttribute(Qt::AA_ShareOpenGLContexts);
  QtWebEngineQuick::initialize();
  QGuiApplication app(argc, argv);

  QQmlApplicationEngine engine;

  // ANCHOR: book_qml_url
  const QUrl url(QStringLiteral("qml/main.qml"));
  // ANCHOR_END: book_qml_url
  QObject::connect(
      &engine,
      &QQmlApplicationEngine::objectCreated,
      &app,
      [url](QObject *obj, const QUrl &objUrl)
      {
        if (!obj && url == objUrl)
          QCoreApplication::exit(-1);
      },
      Qt::QueuedConnection);

  engine.load(url);

  return app.exec();
}