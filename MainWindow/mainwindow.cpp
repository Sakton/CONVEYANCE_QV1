#include "mainwindow.h"
#include "Cars/allcarswiewform.h"
#include "Autorization/autorizationdialog.h"
#include "Constants.h"
// #include "DataBase/databasecreator.h"
#include "dbcreatorthread.h"
#include "Emploee/emploeetableview.h"
#include "Orders/orderwidget.h"
#include "ui_mainwindow.h"
#include <QAction>
#include <QCloseEvent>
#include <QMenuBar>
#include <QSqlDatabase>
#include <QToolBar>
#include "ElementsWidgets/waitwidget.h"
#include <QMetaObject>
#include <QSignalMapper>

MainWindow::MainWindow( QWidget * parent ) : QMainWindow( parent ), ui( new Ui::MainWindow ), map{nullptr} {
	ui->setupUi( this );
	ui->tabWidget->slotClosetab( 1 );
	ui->tabWidget->slotClosetab( 0 );
	createDatabase( );
	autorizationUser();
	readSettings( );
	initSignalMapper();
	// createDatabaseConnection( );
}

MainWindow::~MainWindow( ) {
	delete ui;
}

void MainWindow::closeEvent( QCloseEvent * event ) {
	writeSettings( );
	event->accept( );
}

void MainWindow::contextMenuEvent( QContextMenuEvent * event ) {
	if ( event->reason( ) == QContextMenuEvent::Reason::Mouse ) {
		// TODO тут?
	}
}

void MainWindow::slotCloseTab( int idx ) { ui->tabWidget->removeTab( idx ); }

void MainWindow::slotCreateTabWidget(const QString & typeNameWidget) {
	auto [ result, index ] = isAbsentTab( typeNameWidget );
	if( !result ) {
		auto w = fabriqueCreateWindow(typeNameWidget);
		ui->tabWidget->addTab( w, w->property("nameWindowWidget").toString() );
	} else {
		ui->tabWidget->setCurrentIndex(index);
	}
}

//void MainWindow::slotOrderWindow( ) {
//	auto [ result, index ] = isAbsentTab("OrderWidget");
//			if( !result ){
//		ui->tabWidget->addTab( new OrderWidget( ui->tabWidget ), tr( "ОРДЕРА" ) );
//	} else {
//		ui->tabWidget->setCurrentIndex( index );
//	}
//}

//void MainWindow::slotCarsWindow( ) {
//	auto [ result, index ] = isAbsentTab("AllCarsWiewForm");
//			if(!result) {
//		ui->tabWidget->addTab( new AllCarsWiewForm( ui->tabWidget ), tr( "АВТО" ) );
//	} else {
//		ui->tabWidget->setCurrentIndex( index );
//	}
//}

//void MainWindow::slotEmloeeWindow( ) {
//	auto [ result, index ] = isAbsentTab("EmploeeTableView");
//			if( !result ){
//		ui->tabWidget->addTab( new EmploeeTableView( ui->tabWidget ), tr( "СОТРУДНИКИ" ) );
//	} else {
//		ui->tabWidget->setCurrentIndex( index );
//	}
//}

QPair<bool, int> MainWindow::isAbsentTab(const QString & typeNameWidget) {
	for( int i = 0; i < ui->tabWidget->count(); ++i ) {
		if( ui->tabWidget->widget(i)->objectName() == typeNameWidget ) {
			return { true, i };
		}
	}
	return { false, -1 };
}

QWidget * MainWindow::fabriqueCreateWindow(const QString & nameWindow) {
	QWidget *res = nullptr;
	if( nameWindow == "OrderWidget" ){
		res = new OrderWidget( ui->tabWidget );
		res->setProperty("nameWindowWidget", tr("ОРДЕРА"));
	}
	if( nameWindow == "AllCarsWiewForm" ) {
		res = new AllCarsWiewForm( ui->tabWidget );
		res->setProperty("nameWindowWidget", tr("АВТО"));
	}
	if( nameWindow == "EmploeeTableView" ) {
		res = new EmploeeTableView( ui->tabWidget );
		res->setProperty( "nameWindowWidget", tr("СОТРУДНИКИ") );
	}
	return res;
}

void MainWindow::autorizationUser() const {
	qDebug() << "авторизация";
	AutorizationDialog ad(ui->tabWidget);
	ad.exec();
}

void MainWindow::writeSettings( ) { qDebug( ) << "work MainWindow::writeSettings( )"; }
void MainWindow::readSettings( ) { qDebug( ) << "work MainWindow::readSettings( )"; }

//void MainWindow::createDatabaseConnection( ) {
//  QSqlDatabase db = QSqlDatabase::addDatabase( "QPSQL", ConveyanceConstats::NAME_DB_ALL );
//  db.setHostName( "localhost" );
//  db.setPort( 5432 );
//  db.setDatabaseName( ConveyanceConstats::NAME_DATABASE_IN_SUBD );
//  db.setUserName( "postgres" );
//  db.setPassword( "postgres" );
//  bool ok = db.open( );
//  qDebug( ) << "database status = " << ok;
//}

void MainWindow::createConnections( ) {

}

void MainWindow::createDatabase( ) {
	WaitWidget* ww = new WaitWidget;

	DbCreatorThread *threadCreateDb = new DbCreatorThread;
	connect( threadCreateDb, &QThread::started, ww, &WaitWidget::show );
	connect( threadCreateDb, &QThread::finished, threadCreateDb, &QThread::deleteLater );
	connect( threadCreateDb, &QThread::finished, ww, &WaitWidget::deleteLater );

	threadCreateDb->start();
}

void MainWindow::initSignalMapper() {
	map = new QSignalMapper( this );

	connect( ui->actionShowAllOrder, QOverload<bool>::of( &QAction::triggered ), map, QOverload<>::of( &QSignalMapper::map ) );
	map->setMapping( ui->actionShowAllOrder, "OrderWidget" );
	connect( ui->actionViewAllAuto, QOverload<bool>::of( &QAction::triggered ), map, QOverload<>::of( &QSignalMapper::map ) );
	map->setMapping( ui->actionViewAllAuto, "AllCarsWiewForm" );
	connect( ui->actionViewAllEmploee, QOverload<bool>::of( &QAction::triggered ), map, QOverload<>::of( &QSignalMapper::map ) );
	map->setMapping( ui->actionViewAllEmploee, "EmploeeTableView" );

	connect( map, &QSignalMapper::mappedString, this, &MainWindow::slotCreateTabWidget );
}
