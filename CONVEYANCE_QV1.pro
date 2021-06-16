QT += core gui sql
#QT += axcontainer

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

CONFIG += c++11

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
    Adress/addadress.cpp \
    Adress/adress.cpp \
    MainWindow/mainwindow.cpp \
    main.cpp

HEADERS += \
	Adress/addadress.h \
	Adress/adress.h \
	MainWindow/mainwindow.h

FORMS += \
	Adress/addadress.ui \
	Adress/adress.ui \
	MainWindow/mainwindow.ui

TRANSLATIONS += \
    CONVEYANCE_QV1_pl_PL.ts

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

DISTFILES += \
	Dump/dump.sql \
	IshodnyDanny/Adresses.ods \
	IshodnyDanny/Adresses.xls \
	doc/DB.txt \
	doc/DB_v1.mwb \
	doc/DB_v1.mwb.bak \
	doc/DBcommands.txt \
	doc/Zadachi \
	doc/db_model_tables.mwb.bak \
	doc/plans.txt \
	img/adress.png \
	img/icon24.png \
	img/icon48.png \
	img/icon96.png \
	img/splash.jpg \

RESOURCES += \
	source.qrc
