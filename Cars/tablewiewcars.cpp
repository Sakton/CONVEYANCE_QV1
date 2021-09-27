#include "tablewiewcars.h"
#include "Constants.h"
#include "carsstyleditemdelegate.h"
#include <Cars/carsqltablemodel.h>
#include <QContextMenuEvent>
#include <QHeaderView>
#include <QMenu>

TableWiewCars::TableWiewCars( QWidget * parent )
    : QTableView( parent ), _model { new CarSqlTableModel( this, QSqlDatabase::database( ConveyanceConstats::NAME_DB_ALL ) ) } {
  setModel( _model );
  setItemDelegate( new CarsStyledItemDelegate( this ) );
  horizontalHeader( )->setSectionResizeMode( QHeaderView::ResizeMode::ResizeToContents );
  hideColumn( 0 );
  setSortingEnabled( true );
}

void TableWiewCars::setContextMenu( QMenu * menu ) {
  if ( menu ) {
    contextMenu = menu;
  }
}

void TableWiewCars::updateModel( ) { _model->select( ); }

void TableWiewCars::slotDeleteRecord( ) {
  // TODO но это верно пока работает 1 таблица
  _model->removeRow( selectionModel( )->currentIndex( ).row( ) );
  updateModel( );
}

void TableWiewCars::contextMenuEvent( QContextMenuEvent * event ) {
  if ( contextMenu )
    contextMenu->exec( event->globalPos( ) );
  QTableView::contextMenuEvent( event );
}
