#ifndef ORDERTABLEVIEW_H
#define ORDERTABLEVIEW_H

#include <QTableView>

class OrderSqlTableModel;
class QSortFilterProxyModel;

class OrderTableView : public QTableView {
  Q_OBJECT
public:
  explicit OrderTableView( QWidget * parent = nullptr );

protected:
  void contextMenuEvent( QContextMenuEvent * event ) override;
};

#endif // ORDERTABLEVIEW_H
