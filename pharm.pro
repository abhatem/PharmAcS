# Add more folders to ship with the application, here
folder_01.source = qml/pharm
folder_01.target = qml
DEPLOYMENTFOLDERS = folder_01

# Additional import path used to resolve QML modules in Creator's code model
#QML_IMPORT_PATH =

# If your application uses the Qt Mobility libraries, uncomment the following
# lines and add the respective components to the MOBILITY variable.
# CONFIG += mobility
# MOBILITY +=

QT       += sql
QT_CONFIG -= no-pkg-config
CONFIG += link_pkgconfig
#PKGCONFIG += opencv

# The .cpp file which was generated for your project. Feel free to hack it.
SOURCES += main.cpp \
    pharmitem.cpp \
    simplecrypt.cpp \
    pharmdata.cpp \
    pharmimage.cpp \
#    setting.cpp
    pharmbill.cpp \
    billitem.cpp

# Installation path
# target.path =


# Please do not modify the following two lines. Required for deployment.
include(qtquick2applicationviewer/qtquick2applicationviewer.pri)
qtcAddDeployment()
# Please do not modify the following two lines. Required for deployment.
#include(qtquick2controlsapplicationviewer/qtquick2controlsapplicationviewer.pri)
#qtcAddDeployment()


OTHER_FILES += \
    qml/pharm/PlaceForm.qml \
    qml/pharm/ViewTab.qml \
    qml/pharm/viewTab_script.js

HEADERS += \
    pharmitem.h \
    simplecrypt.h \
    pharmdata.h \
    pharmimage.h \
#    setting.h
    pharmbill.h \
    billitem.h \
    app.h

QMAKE_CXXFLAGS += -Wall
