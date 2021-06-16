#include "mainwindow.h"
#include "ui_mainwindow.h"
#include <QAction>
#include <QCloseEvent>
#include <QMenuBar>
#include <QSqlDatabase>
#include <QToolBar>

MainWindow::MainWindow( QWidget *parent ) : QMainWindow( parent ), ui( new Ui::MainWindow ) {
  ui->setupUi( this );
  readSettings( );
  createToolBar( );
  createDatabaseConnection( );
}

MainWindow::~MainWindow( ) {
  delete ui;
}

void MainWindow::closeEvent( QCloseEvent *event ) {
  writeSettings( );
  event->accept( );
}

void MainWindow::contextMenuEvent( QContextMenuEvent *event ) {
  if ( event->reason( ) == QContextMenuEvent::Reason::Mouse ) {
    qDebug( ) << event->x( ) << " : " << event->y( );
  }
}

void MainWindow::writeSettings( ) {
  qDebug( ) << "work MainWindow::writeSettings( )";
}

void MainWindow::readSettings( ) {
  qDebug( ) << "work MainWindow::readSettings( )";
}

void MainWindow::createToolBar( ) {
  tool = new QToolBar( this );
  tool->addAction( "Tab1" );
  tool->addAction( "Tab2" );
  addToolBar( Qt::ToolBarArea::TopToolBarArea, tool );
}

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
