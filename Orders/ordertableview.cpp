#include "ordertableview.h"
#include <QContextMenuEvent>
#include <QMenu>

OrderTableView::OrderTableView( QWidget * parent ) : QTableView( parent ) { qDebug( ) << "OrderTableView::OrderTableView"; }

void OrderTableView::contextMenuEvent( QContextMenuEvent * event ) {
  qDebug( ) << "contextMenuEvent";
  QMenu menu;
  menu.addAction( "Update" );
  menu.addAction( "Delete" );
  menu.popup( event->globalPos( ) );
}
