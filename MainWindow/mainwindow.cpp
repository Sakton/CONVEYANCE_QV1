#include "mainwindow.h"
#include "Orders/orderwidget.h"
#include "ui_mainwindow.h"
#include <QAction>
#include <QCloseEvent>
#include <QMenuBar>
#include <QSqlDatabase>
#include <QToolBar>

MainWindow::MainWindow( QWidget * parent ) : QMainWindow( parent ), ui( new Ui::MainWindow ) {
  ui->setupUi( this );
  readSettings( );
  // createToolBar( );
  createDatabaseConnection( );
  createConnections( );
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

void MainWindow::slotOrderWindow( ) { ui->tabWidget->addTab( new OrderWidget( ui->tabWidget ), "ОРДЕРА" ); }

void MainWindow::slotCloseTab( int idx ) { ui->tabWidget->removeTab( idx ); }

void MainWindow::writeSettings( ) { qDebug( ) << "work MainWindow::writeSettings( )"; }

void MainWindow::readSettings( ) { qDebug( ) << "work MainWindow::readSettings( )"; }

// void MainWindow::createToolBar( ) {
//  QToolBar * tool = addToolBar( "123" );
//  tool->addAction( "Tab1" );
//  tool->addAction( "Tab2" );
//}

void MainWindow::createDatabaseConnection( ) {
  QSqlDatabase db = QSqlDatabase::addDatabase( "QPSQL", "DB" );
  db.setHostName( "localhost" );
  db.setPort( 5432 );
  db.setDatabaseName( "demo_coveyance_db" );
  db.setUserName( "postgres" );
  db.setPassword( "postgres" );
  bool ok = db.open( );
  qDebug( ) << "database status = " << ok;
}

void MainWindow::createConnections( ) {
  connect( ui->actionShowAllOrder, QOverload< bool >::of( &QAction::triggered ), this, QOverload<>::of( &MainWindow::slotOrderWindow ) );
  connect( ui->tabWidget, QOverload< int >::of( &QTabWidget::tabCloseRequested ), this, QOverload< int >::of( &MainWindow::slotCloseTab ) );
}
