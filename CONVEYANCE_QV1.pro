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
    Adress/adresssqlquerymodel.cpp \
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
    ElementsWidgets/comboboxdrivers.cpp \
    ElementsWidgets/comboboxfunctionworker.cpp \
    ElementsWidgets/comboboxpaymentperiod.cpp \
    ElementsWidgets/comboboxperiodsendmail.cpp \
    ElementsWidgets/comboboxshippers.cpp \
    ElementsWidgets/comboboxtypeadress.cpp \
    Emploee/addemploeedialog.cpp \
    Emploee/addfunctionemploeedialog.cpp \
    Emploee/emploeesqltablemodel.cpp \
    Emploee/emploeetableview.cpp \
    MainWindow/mainwindow.cpp \
    MyTests/testqsqltableformform.cpp \
    Orders/createorderdialog.cpp \
    Orders/ordersqlquerymodel.cpp \
    Orders/ordertableview.cpp \
    Orders/orderwidget.cpp \
    Orders/testform.cpp \
    Shippers/addshipperdialog.cpp \
    main.cpp

HEADERS += \
	Adress/addadress.h \
	Adress/adress.h \
	Adress/adresscountrydelegate.h \
	Adress/adressdialog.h \
	Adress/adresssqlquerymodel.h \
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
	ElementsWidgets/comboboxdrivers.h \
	ElementsWidgets/comboboxfunctionworker.h \
	ElementsWidgets/comboboxpaymentperiod.h \
	ElementsWidgets/comboboxperiodsendmail.h \
	ElementsWidgets/comboboxshippers.h \
	ElementsWidgets/comboboxtypeadress.h \
	Emploee/addemploeedialog.h \
	Emploee/addfunctionemploeedialog.h \
	Emploee/emploeesqltablemodel.h \
	Emploee/emploeetableview.h \
	MainWindow/mainwindow.h \
	MyTests/testqsqltableformform.h \
	Orders/createorderdialog.h \
	Orders/ordersqlquerymodel.h \
	Orders/ordertableview.h \
	Orders/orderwidget.h \
	Orders/testform.h \
	Shippers/addshipperdialog.h

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
	Emploee/addemploeedialog.ui \
	Emploee/addfunctionemploeedialog.ui \
	Emploee/emploeetableview.ui \
	MainWindow/mainwindow.ui \
	MyTests/testqsqltableformform.ui \
	Orders/createorderdialog.ui \
	Orders/orderwidget.ui \
	Orders/testform.ui \
	Shippers/addshipperdialog.ui

TRANSLATIONS += \
    CONVEYANCE_QV1_pl_PL.ts

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

DISTFILES += \
	.gitignore \
    DBTables/Adress.sql \
    DBTables/Cars.sql \
    DBTables/Contracts.sql \
    DBTables/CreateDb.sql \
	DBTables/Documents.sql \
    DBTables/Emploee.sql \
    DBTables/Orders.sql \
    DBTables/Payment.sql \
    DBTables/Routes.sql \
    DBTables/Shippers.sql \
    DBTables/VATs.sql \
	Dump/dump.sql \
	Dump/dump1.sql \
	IshodnyDanny/Adresses.ods \
	IshodnyDanny/Adresses.xls \
	doc/BaseTable.txt \
	doc/Contracts.txt \
    doc/DB.sql \
	doc/DB_demo_t1.mwb \
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

INCLUDEPATH += $$PWD/ElementsWidgets
INCLUDEPATH += $$PWD/Adress
INCLUDEPATH += $$PWD/Orders
