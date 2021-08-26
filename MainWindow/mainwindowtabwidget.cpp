#include "mainwindowtabwidget.h"
#include <QDebug>

MainWindowTabWidget::MainWindowTabWidget( QWidget * parent ) : QTabWidget( parent ) {}

void MainWindowTabWidget::slotClosetab( int index ) { removeTab( index ); }

void MainWindowTabWidget::createConnected( ) {
  connect( this, QOverload< int >::of( &QTabWidget::tabCloseRequested ), this, QOverload< int >::of( &MainWindowTabWidget::slotClosetab ) );
}

//проблема с удалением закладок в конструкторе, их еще нет, поэтому и не удаляются,
//при событии показа виджета ( когда он подготовлен их удаляем )
void MainWindowTabWidget::showEvent( QShowEvent * event ) { QTabWidget::showEvent( event ); }
