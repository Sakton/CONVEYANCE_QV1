#include "mainwindow.h"
#include "ui_mainwindow.h"
#include <QAction>
#include <QMenuBar>
#include <QToolBar>

MainWindow::MainWindow( QWidget *parent ) :
    QMainWindow( parent ),
    ui( new Ui::MainWindow ) {
    ui->setupUi(this);
    createMenu( );
    addToolBar( Qt::TopToolBarArea, createToolBar( ) );
}

MainWindow::~MainWindow()
{
    delete ui;
}

void MainWindow::createMenu( ) {
    auto p_menuBar = ui->menubar;
}

QToolBar *MainWindow::createToolBar( ) {
    QToolBar *p = new QToolBar( "works" );

    return p;
}

void MainWindow::createFileMenu( ) {
}
