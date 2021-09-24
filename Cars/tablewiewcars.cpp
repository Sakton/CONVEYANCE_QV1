#include "tablewiewcars.h"
#include "Constants.h"
#include <Cars/carsqltablemodel.h>
#include <QContextMenuEvent>
#include <QHeaderView>
#include <QMenu>

TableWiewCars::TableWiewCars( QWidget * parent ) : QTableView( parent ) {
  setModel( new CarSqlTableModel( this, QSqlDatabase::database( ConveyanceConstats::NAME_DB_ALL ) ) );
  horizontalHeader( )->setSectionResizeMode( QHeaderView::ResizeMode::Interactive );
  hideColumn( 0 );
}

void TableWiewCars::setContextMenu( QMenu * menu ) {
  if ( menu ) {
    contextMenu = menu;
  }
}

void TableWiewCars::contextMenuEvent( QContextMenuEvent * event ) {
  if ( contextMenu )
    contextMenu->exec( event->globalPos( ) );
  QTableView::contextMenuEvent( event );
}
