#include "ordertableview.h"
#include "Constants.h"
#include "ordersqltablemodel.h"
#include <QContextMenuEvent>
#include <QHeaderView>
#include <QMenu>
#include <QSortFilterProxyModel>

OrderTableView::OrderTableView( QWidget * parent ) : QTableView( parent ), contextMenu { nullptr } {}

void OrderTableView::setContextMenu( QMenu * m ) {
  if ( !m )
    return;
  contextMenu = m;
}

void OrderTableView::contextMenuEvent( QContextMenuEvent * event ) {
  if ( contextMenu )
    contextMenu->exec( event->globalPos( ) );
  QTableView::contextMenuEvent( event );
}
