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

MainWindow::MainWindow( QWidget * parent ) : QMainWindow( parent ), ui( new Ui::MainWindow ) {
	ui->setupUi( this );
	ui->tabWidget->slotClosetab( 1 );
	ui->tabWidget->slotClosetab( 0 );
	// в поток
	createDatabase( );
	autorizationUser();
	// readSettings( );
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

void MainWindow::slotOrderWindow( ) { ui->tabWidget->addTab( new OrderWidget( ui->tabWidget ), tr( "ОРДЕРА" ) ); }
void MainWindow::slotCloseTab( int idx ) { ui->tabWidget->removeTab( idx ); }
void MainWindow::slotCarsWindow( ) { ui->tabWidget->addTab( new AllCarsWiewForm( ui->tabWidget ), tr( "АВТО" ) ); }
void MainWindow::slotEmloeeWindow( ) { ui->tabWidget->addTab( new EmploeeTableView( ui->tabWidget ), tr( "СОТРУДНИКИ" ) ); }

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
