#include <QtGui/QGuiApplication>
#include <QApplication>
#include <QtQml/QQmlApplicationEngine>

#include <QtWebEngineQuick>
#include <QDockWidget>

int main(int argc, char *argv[])
{
  QCoreApplication::setAttribute(Qt::AA_ShareOpenGLContexts);
  QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

  QtWebEngineQuick::initialize();
  QApplication app(argc, argv);

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

  QQuickWindow *qmlwindow = qobject_cast<QQuickWindow *>(engine.rootObjects().first());
  QWidget *rootWidget = qobject_cast<QWidget *>(qmlwindow->children().first());

  return app.exec();
}
