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
    Autorization/autorizationdialog.cpp \
    Cars/addcardialog.cpp \
    Cars/allcarswiewform.cpp \
    Cars/carsqltablemodel.cpp \
    Cars/carsstyleditemdelegate.cpp \
    Cars/tablewiewcars.cpp \
    Contract/createcontractdialog.cpp \
    DataBase/databasecreator.cpp \
    ElementsWidgets/actionpushbutton.cpp \
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
    Emploee/adddriverdialog.cpp \
    Emploee/addemploeedialog.cpp \
    Emploee/addfunctionemploeedialog.cpp \
    Emploee/emploeesqltablemodel.cpp \
    Emploee/emploeetableview.cpp \
    Emploee/tableviewemploee.cpp \
    MainWindow/mainwindow.cpp \
    MainWindow/mainwindowtabwidget.cpp \
    MyTests/testqsqltableformform.cpp \
    Orders/commonorderform.cpp \
    Orders/createorderdialog.cpp \
    Orders/ordersqlquerymodel.cpp \
    Orders/ordersqltablemodel.cpp \
    Orders/ordertableview.cpp \
    Orders/orderwidget.cpp \
    Orders/updateorderdialog.cpp \
    Shippers/addshipperdialog.cpp \
    Wagons/addpullingdialog.cpp \
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
	Autorization/autorizationdialog.h \
	Cars/addcardialog.h \
	Cars/allcarswiewform.h \
	Cars/carsqltablemodel.h \
	Cars/carsstyleditemdelegate.h \
	Cars/tablewiewcars.h \
	Constants.h \
	Contract/createcontractdialog.h \
	DataBase/databasecreator.h \
	ElementsWidgets/actionpushbutton.h \
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
	Emploee/adddriverdialog.h \
	Emploee/addemploeedialog.h \
	Emploee/addfunctionemploeedialog.h \
	Emploee/emploeesqltablemodel.h \
	Emploee/emploeetableview.h \
	Emploee/tableviewemploee.h \
	MainWindow/mainwindow.h \
	MainWindow/mainwindowtabwidget.h \
	MyTests/testqsqltableformform.h \
	Orders/commonorderform.h \
	Orders/createorderdialog.h \
	Orders/ordersqlquerymodel.h \
	Orders/ordersqltablemodel.h \
	Orders/ordertableview.h \
	Orders/orderwidget.h \
	Orders/updateorderdialog.h \
	Shippers/addshipperdialog.h \
	Wagons/addpullingdialog.h

FORMS += \
	Adress/addadress.ui \
	Adress/adress.ui \
	Adress/adressdialog.ui \
	Adress/adressview.ui \
	Adress/citydialog.ui \
	Adress/updateadressdialog.ui \
	Adress/updatecitydialog.ui \
	Autorization/autorizationdialog.ui \
	Cars/addcardialog.ui \
	Cars/allcarswiewform.ui \
	Contract/createcontractdialog.ui \
	Emploee/addemploeedialog.ui \
	Emploee/addfunctionemploeedialog.ui \
	Emploee/emploeetableview.ui \
	MainWindow/mainwindow.ui \
	MyTests/testqsqltableformform.ui \
	Orders/commonorderform.ui \
	Orders/orderwidget.ui \
	Shippers/addshipperdialog.ui \
	Wagons/addpullingdialog.ui

TRANSLATIONS += \
    CONVEYANCE_QV1_pl_PL.ts

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

DISTFILES += \
	.gitignore \
    DBTables/Adress.sql \
	DBTables/CarsOld---.sql \
    DBTables/Contracts.sql \
    DBTables/CreateDb.sql \
	DBTables/Documents.sql \
    DBTables/Emploee.sql \
    DBTables/Orders.sql \
    DBTables/Payment.sql \
    DBTables/Routes.sql \
    DBTables/Shippers.sql \
    DBTables/VATs.sql \
	DBTables/Wagons---.sql \
	DBTables/Wagons.sql \
	Dump/dump.sql \
	Dump/dump1.sql \
	Dump/dump_conveyance_db.sql \
	DumpStructureDatabase/InsertConstatsDataInTable.sql \
	DumpStructureDatabase/currentDump.sql \
	DumpStructureDatabase/currentDumpSchema.sql \
	DumpStructureDatabase/testDump.sql \
	ErrorsFound \
	IshodnyDanny/Adresses.ods \
	IshodnyDanny/Adresses.xls \
	MyBin/CONVEYANCE_QV1.exe \
	MyBin/PostgreSQL_13.1_64bit_Setup.exe \
	MyBin/Qt6Core.dll \
	MyBin/Qt6Gui.dll \
	MyBin/Qt6Sql.dll \
	MyBin/Qt6Svg.dll \
	MyBin/Qt6Widgets.dll \
	MyBin/d3dcompiler_47.dll \
	MyBin/iconengines/qsvgicon.dll \
	MyBin/imageformats/qgif.dll \
	MyBin/imageformats/qicns.dll \
	MyBin/imageformats/qico.dll \
	MyBin/imageformats/qjpeg.dll \
	MyBin/imageformats/qsvg.dll \
	MyBin/imageformats/qtga.dll \
	MyBin/imageformats/qtiff.dll \
	MyBin/imageformats/qwbmp.dll \
	MyBin/imageformats/qwebp.dll \
	MyBin/opengl32sw.dll \
	MyBin/platforms/qwindows.dll \
	MyBin/scriptPacckage1.iss \
	MyBin/sqldrivers/qsqlite.dll \
	MyBin/sqldrivers/qsqlodbc.dll \
	MyBin/sqldrivers/qsqlpsql.dll \
	MyBin/styles/qwindowsvistastyle.dll \
	MyBin/translations/qt_ar.qm \
	MyBin/translations/qt_bg.qm \
	MyBin/translations/qt_ca.qm \
	MyBin/translations/qt_cs.qm \
	MyBin/translations/qt_da.qm \
	MyBin/translations/qt_de.qm \
	MyBin/translations/qt_en.qm \
	MyBin/translations/qt_es.qm \
	MyBin/translations/qt_fa.qm \
	MyBin/translations/qt_fi.qm \
	MyBin/translations/qt_fr.qm \
	MyBin/translations/qt_gd.qm \
	MyBin/translations/qt_he.qm \
	MyBin/translations/qt_hr.qm \
	MyBin/translations/qt_hu.qm \
	MyBin/translations/qt_it.qm \
	MyBin/translations/qt_ja.qm \
	MyBin/translations/qt_ko.qm \
	MyBin/translations/qt_lv.qm \
	MyBin/translations/qt_nl.qm \
	MyBin/translations/qt_nn.qm \
	MyBin/translations/qt_pl.qm \
	MyBin/translations/qt_pt_BR.qm \
	MyBin/translations/qt_ru.qm \
	MyBin/translations/qt_sk.qm \
	MyBin/translations/qt_tr.qm \
	MyBin/translations/qt_uk.qm \
	MyBin/translations/qt_zh_CN.qm \
	MyBin/translations/qt_zh_TW.qm \
	MyBin/vc_redist.x64.exe \
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
INCLUDEPATH += $$PWD/MainWindow
INCLUDEPATH += $$PWD/Cars/ElementsCarsView
INCLUDEPATH += $$PWD/Emploee
