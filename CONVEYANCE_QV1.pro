QT += core gui sql

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

CONFIG += c++11

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
    Adress/addadress.cpp \
    Adress/adress.cpp \
    Adress/adresscountrydelegate.cpp \
    Adress/adressdialog.cpp \
    Adress/adresstableview.cpp \
    Adress/adressview.cpp \
    Adress/citydialog.cpp \
    ElementsWidgets/comboboxcity.cpp \
    ElementsWidgets/comboboxcountrys.cpp \
    MainWindow/mainwindow.cpp \
    main.cpp

HEADERS += \
	Adress/addadress.h \
	Adress/adress.h \
	Adress/adresscountrydelegate.h \
	Adress/adressdialog.h \
	Adress/adresstableview.h \
	Adress/adressview.h \
	Adress/citydialog.h \
	Constants.h \
	ElementsWidgets/comboboxcity.h \
	ElementsWidgets/comboboxcountrys.h \
	MainWindow/mainwindow.h

FORMS += \
	Adress/addadress.ui \
	Adress/adress.ui \
	Adress/adressdialog.ui \
	Adress/adressview.ui \
	Adress/citydialog.ui \
	MainWindow/mainwindow.ui

TRANSLATIONS += \
    CONVEYANCE_QV1_pl_PL.ts

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

DISTFILES += \
	.gitignore \
	Dump/dump.sql \
	IshodnyDanny/Adresses.ods \
	IshodnyDanny/Adresses.xls \
	doc/ConstantTableData.txt \
	doc/DB.txt \
	doc/DB_v1.mwb \
	doc/DB_v1.mwb.bak \
	doc/DBcommands.txt \
	doc/Zadachi \
	doc/db_model_tables.mwb.bak \
	doc/plans.txt \
	doc/vat_stavki.ods \
	img/adress.png \
	img/flagCountrys/austria.png \
	img/flagCountrys/belarus.png \
	img/flagCountrys/belgium.png \
	img/flagCountrys/czech_republic.png \
	img/flagCountrys/denmark.png \
	img/flagCountrys/estonia.png \
	img/flagCountrys/finland.png \
	img/flagCountrys/france.png \
	img/flagCountrys/germany.png \
	img/flagCountrys/greece.png \
	img/flagCountrys/hungary.png \
	img/flagCountrys/iceland.png \
	img/flagCountrys/italy.png \
	img/flagCountrys/latvia.png \
	img/flagCountrys/luxembourg.png \
	img/flagCountrys/malta.png \
	img/flagCountrys/netherlands.png \
	img/flagCountrys/norway.png \
	img/flagCountrys/poland.png \
	img/flagCountrys/portugal.png \
	img/flagCountrys/russia.png \
	img/flagCountrys/slovakia.png \
	img/flagCountrys/slovenia.png \
	img/flagCountrys/spain.png \
	img/flagCountrys/sweden.png \
	img/flagCountrys/switzerland.png \
	img/icon24.png \
	img/icon48.png \
	img/icon96.png \
	img/splash.jpg \

RESOURCES += \
	source.qrc

INCLUDEPATH += $$PWD\ElementsWidgets
