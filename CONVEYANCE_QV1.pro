QT += core gui
#QT += axcontainer

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

CONFIG += c++11

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
    MainWindow/mainwindow.cpp \
    main.cpp

HEADERS += \
	MainWindow/mainwindow.h

FORMS += \
	MainWindow/mainwindow.ui

TRANSLATIONS += \
    CONVEYANCE_QV1_pl_PL.ts

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

DISTFILES += \
	DB.txt \
	DB_v1.mwb \
	DBcommands.txt \
	IshodnyDanny/Adresses.ods \
	IshodnyDanny/Adresses.xls \
	Zadachi \
	img/icon24.png \
	img/icon48.png \
	img/icon96.png \
	img/splash.jpg \
	plans.txt

RESOURCES += \
	source.qrc
