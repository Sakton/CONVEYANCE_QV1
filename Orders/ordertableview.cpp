#include "ordertableview.h"
#include "Constants.h"
#include "ordersqltablemodel.h"
#include <QContextMenuEvent>
#include <QHeaderView>
#include <QMenu>
#include <QSortFilterProxyModel>

OrderTableView::OrderTableView( QWidget * parent ) : QTableView( parent ) {}

void OrderTableView::contextMenuEvent( QContextMenuEvent * event ) {
  QMenu menu;
  menu.addAction( "Update" );
  menu.addAction( "Delete" );
  menu.exec( event->globalPos( ) );
}
