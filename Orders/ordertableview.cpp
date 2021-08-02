#include "ordertableview.h"
#include "Constants.h"
#include "ordersqltablemodel.h"
#include <QContextMenuEvent>
#include <QHeaderView>
#include <QMenu>
#include <QSortFilterProxyModel>

OrderTableView::OrderTableView( QWidget * parent )
    : QTableView( parent ), model { new OrderSqlTableModel { this, QSqlDatabase::database( NAME_DB_ALL ) } },
      filterModel { new QSortFilterProxyModel { this } } {
  updateData( );
}

void OrderTableView::initModel( ) {
  model->setTable( "orders.ordersview" );
  model->select( );
  model->setHeaderData( 0, Qt::Orientation::Horizontal, tr( "ДАТА" ) );
  model->setHeaderData( 1, Qt::Orientation::Horizontal, tr( "НОМЕР" ) );
  model->setHeaderData( 2, Qt::Orientation::Horizontal, tr( "ЗАКАЗЧИК" ) );
  model->setHeaderData( 3, Qt::Orientation::Horizontal, tr( "ЦЕНА" ) );
  model->setHeaderData( 4, Qt::Orientation::Horizontal, tr( "ВАЛЮТА" ) );
  model->setHeaderData( 5, Qt::Orientation::Horizontal, tr( "ПЕРИОД ОПЛАТЫ" ) );
  model->setHeaderData( 6, Qt::Orientation::Horizontal, tr( "ВОДИТЕЛЬ" ) );
  model->setHeaderData( 7, Qt::Orientation::Horizontal, tr( "ПЕРИОД ПОЧТЫ" ) );
  filterModel->setSourceModel( model );
}

void OrderTableView::updateData( ) {
  model->clear( );
  initModel( );
  setModel( filterModel );
  horizontalHeader( )->resizeSections( QHeaderView::ResizeToContents );
  hideColumn( 8 );
}

void OrderTableView::contextMenuEvent( QContextMenuEvent * event ) {
  QMenu menu;
  menu.addAction( "Update" );
  menu.addAction( "Delete" );
  menu.exec( event->globalPos( ) );
}
