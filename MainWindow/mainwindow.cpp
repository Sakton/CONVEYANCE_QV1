#include "mainwindow.h"
#include "Cars/allcarswiewform.h"
#include "Constants.h"
#include "DataBase/databasecreator.h"
#include "Emploee/emploeetableview.h"
#include "Orders/orderwidget.h"
#include "ui_mainwindow.h"
#include <QAction>
#include <QCloseEvent>
#include <QMenuBar>
#include <QSqlDatabase>
#include <QToolBar>

MainWindow::MainWindow( QWidget * parent ) : QMainWindow( parent ), ui( new Ui::MainWindow ) {
	ui->setupUi( this );
	ui->tabWidget->slotClosetab( 1 );
	ui->tabWidget->slotClosetab( 0 );
	createDatabase( );
	readSettings( );
	createDatabaseConnection( );
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

//**********************************************************************************************
//TODO ДУБЛИРОВАНИЕ КОДА !!!!!!
/*
 * Widget * MainWindow::slotCreateWindow(const QString *name) {
 *		if( name == "xxx" ){
 *				return new OrderWidget(ui->tabWidget, tr( "ОРДЕРА" ));
 *		}
 *
 *
 * }
*/


void MainWindow::slotOrderWindow( ) {
	auto res = isAbsentTab( "OrderWidget" );
	if( ! res.first ){
		ui->tabWidget->addTab( new OrderWidget( ui->tabWidget ), tr( "ОРДЕРА" ) );
		ui->tabWidget->setCurrentIndex( ui->tabWidget->count() - 1 );
	} else {
		ui->tabWidget->setCurrentIndex( res.second );
	}
}

void MainWindow::slotCarsWindow( ) {
	auto res = isAbsentTab( "AllCarsWiewForm" );
	if( !res.first ) {
		ui->tabWidget->addTab( new AllCarsWiewForm( ui->tabWidget ), tr( "АВТО" ) );
		ui->tabWidget->setCurrentIndex( ui->tabWidget->count() - 1 );
	} else {
		ui->tabWidget->setCurrentIndex( res.second );
	}
}

void MainWindow::slotEmloeeWindow( ) {
	auto res = isAbsentTab( "EmploeeTableView" );
	if( !res.first ){
		ui->tabWidget->addTab( new EmploeeTableView( ui->tabWidget ), tr( "СОТРУДНИКИ" ) );
		ui->tabWidget->setCurrentIndex( ui->tabWidget->count() - 1 );
	} else {
		ui->tabWidget->setCurrentIndex( res.second );
	}
}

// ***************************************************************************************************

void MainWindow::slotCloseTab( int idx ) { ui->tabWidget->removeTab( idx ); }

QPair<bool, int> MainWindow::isAbsentTab( const QString & typeNameWidget ) {
	for( qsizetype index = 0; index < ui->tabWidget->count(); ++index ) {
		if( ui->tabWidget->widget(index)->metaObject()->className() == typeNameWidget ) {
			return {true, index};
		}
	}
	return {false, -1};
}

//QWidget * MainWindow::fabriqueCreateWindow(const QString & nameWindow)
//{
//	if( nameWindow == "OrderWidget" ) {

//	}
//}

void MainWindow::writeSettings( ) { qDebug( ) << "work MainWindow::writeSettings( )"; }
void MainWindow::readSettings( ) { qDebug( ) << "work MainWindow::readSettings( )"; }

void MainWindow::createDatabaseConnection( ) {
	QSqlDatabase db = QSqlDatabase::addDatabase( "QPSQL", ConveyanceConstats::NAME_DB_ALL );
	db.setHostName( "localhost" );
	db.setPort( 5432 );
	db.setDatabaseName( ConveyanceConstats::NAME_DATABASE_IN_SUBD );
	db.setUserName( "postgres" );
	db.setPassword( "postgres" );
	bool ok = db.open( );
	qDebug( ) << "database status = " << ok;
}

void MainWindow::createConnections( ) {

}

void MainWindow::createDatabase( ) {
	DatabaseCreator dbc;
	//	if ( !dbc.createDatabase( ) )
	//		qDebug( ) << "ERROR CREATE DB";
	//	else
	//		qDebug( ) << "CREATE DB";
}
