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
    Adress/adresssqltablemodel.cpp \
    Adress/adresstableview.cpp \
    Adress/adressview.cpp \
    Adress/citydialog.cpp \
    Adress/updateadressdialog.cpp \
    Adress/updatecitydialog.cpp \
    Cars/addbrandcardialog.cpp \
    Cars/addcarmodeldialog.cpp \
    Contract/createcontractdialog.cpp \
    ElementsWidgets/comboboxcarbrand.cpp \
    ElementsWidgets/comboboxcarcategories.cpp \
    ElementsWidgets/comboboxcarmodel.cpp \
    ElementsWidgets/comboboxcity.cpp \
    ElementsWidgets/comboboxcountrys.cpp \
    ElementsWidgets/comboboxcurrency.cpp \
    ElementsWidgets/comboboxpaymentperiod.cpp \
    ElementsWidgets/comboboxperiodsendmail.cpp \
    ElementsWidgets/comboboxtypeadress.cpp \
    MainWindow/mainwindow.cpp \
    Orders/createorderdialog.cpp \
    main.cpp

HEADERS += \
	Adress/addadress.h \
	Adress/adress.h \
	Adress/adresscountrydelegate.h \
	Adress/adressdialog.h \
	Adress/adresssqltablemodel.h \
	Adress/adresstableview.h \
	Adress/adressview.h \
	Adress/citydialog.h \
	Adress/updateadressdialog.h \
	Adress/updatecitydialog.h \
	Cars/addbrandcardialog.h \
	Cars/addcarmodeldialog.h \
	Constants.h \
	Contract/createcontractdialog.h \
	ElementsWidgets/comboboxcarbrand.h \
	ElementsWidgets/comboboxcarcategories.h \
	ElementsWidgets/comboboxcarmodel.h \
	ElementsWidgets/comboboxcity.h \
	ElementsWidgets/comboboxcountrys.h \
	ElementsWidgets/comboboxcurrency.h \
	ElementsWidgets/comboboxpaymentperiod.h \
	ElementsWidgets/comboboxperiodsendmail.h \
	ElementsWidgets/comboboxtypeadress.h \
	MainWindow/mainwindow.h \
	Orders/createorderdialog.h

FORMS += \
	Adress/addadress.ui \
	Adress/adress.ui \
	Adress/adressdialog.ui \
	Adress/adressview.ui \
	Adress/citydialog.ui \
	Adress/updateadressdialog.ui \
	Adress/updatecitydialog.ui \
	Cars/addbrandcardialog.ui \
	Cars/addcarmodeldialog.ui \
	Contract/createcontractdialog.ui \
	MainWindow/mainwindow.ui \
	Orders/createorderdialog.ui

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
	doc/Adres.txt \
	doc/BaseTable.txt \
	doc/Cars.txt \
	doc/ConstantTableData.txt \
	doc/Contracts.txt \
	doc/DB.txt \
	doc/DB_demo_t1.mwb \
	doc/DB_v1.mwb \
	doc/DB_v1.mwb.bak \
	doc/DBcommands.txt \
	doc/Emploee.txt \
	doc/Orders.txt \
	doc/Payment.txt \
	doc/Routes.txt \
	doc/Shippers.txt \
	doc/TablesDoc/Adress.txt \
	doc/TablesDoc/AdressView.txt \
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
