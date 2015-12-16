//#include <QtGui/QGuiApplication>
//#include "qtquick2applicationviewer.h"

//int main(int argc, char *argv[])
//{
//    QGuiApplication app(argc, argv);

//    QtQuick2ApplicationViewer viewer;
//    viewer.registerTypes();
//    viewer.setMainQmlFile(QStringLiteral("qml/pharm/main.qml"));
//    viewer.showExpanded();

//    return app.exec();
//}


#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickWindow>
#include <QtQuick>
#include <QImage>
#include <QPainter>
#include <QQuickImageProvider>
#include <QDebug>
//#include "setting.h"

#include "pharmdata.h"
#include "pharmimage.h"
#include "pharmitem.h"

static QObject *singleDataProvider(QQmlEngine *engine, QJSEngine *scriptEngine)
{
    Q_UNUSED(engine)
    Q_UNUSED(scriptEngine)

    PharmData *data = new PharmData();
    return data;
}


int main (int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;
//    Settings settings("Pharmacs", "settings");
    qmlRegisterType<PharmItem>("PharmItem", 1, 0, "PharmItem");
    qmlRegisterType<PharmBill>("PharmBill", 1, 0, "PharmBill");
//    qmlRegisterType<PharmData>("PharmData", 1, 0, "PharmData");
    qmlRegisterSingletonType<PharmData>("PharmAcS.DataEngine", 1, 0, "PharmData", singleDataProvider);
    //qmlRegisterType<PharmImage>("PharmImage", 1, 0, "PharmImage");
    engine.addImageProvider("PharmImages", new PharmImage);
//    engine.rootContext()->setContextProperty("settings", &settings);
    engine.load(QUrl("qml/pharm/main.qml"));
    QObject *topLevel = engine.rootObjects().value(0);
    QQuickWindow *window = qobject_cast<QQuickWindow *>(topLevel);
    window->showMaximized();
    return app.exec();
}
