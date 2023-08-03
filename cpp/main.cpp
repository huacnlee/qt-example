#include <QtGui/QGuiApplication>
#include <QtQml/QQmlApplicationEngine>

#include <QtWebEngineQuick>
#include <QDockWidget>

void createDockWindow(QWidget *parent)
{
  QDockWidget *dock = new QDockWidget("Customers", parent);
  dock->setAllowedAreas(Qt::LeftDockWidgetArea | Qt::RightDockWidgetArea);
}

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

  QQuickWindow *qmlwindow = qobject_cast<QQuickWindow *>(engine.rootObjects().first());
  QWidget *rootWidget = qobject_cast<QWidget *>(qmlwindow->children().first());
  // createDockWindow(rootWidget);

  return app.exec();
}
