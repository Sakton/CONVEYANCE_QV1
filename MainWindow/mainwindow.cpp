#include "mainwindow.h"
#include "ui_mainwindow.h"
#include <QAction>
#include <QCloseEvent>
#include <QMenuBar>
#include <QToolBar>

MainWindow::MainWindow( QWidget *parent ) :
    QMainWindow( parent ),
    ui( new Ui::MainWindow ) {
    ui->setupUi(this);
    readSettings( );
}

MainWindow::~MainWindow( ) {
  delete ui;
}

void MainWindow::closeEvent( QCloseEvent *event ) {
  writeSettings( );
  event->accept( );
}

void MainWindow::writeSettings( ) {
  qDebug( ) << "work MainWindow::writeSettings( )";
}

void MainWindow::readSettings( ) {
  qDebug( ) << "work MainWindow::readSettings( )";
}
