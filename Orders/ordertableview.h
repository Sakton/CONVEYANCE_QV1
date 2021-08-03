#ifndef ORDERTABLEVIEW_H
#define ORDERTABLEVIEW_H

#include <QTableView>

class OrderSqlTableModel;
class QSortFilterProxyModel;

class OrderTableView : public QTableView {
  Q_OBJECT
public:
  explicit OrderTableView( QWidget * parent = nullptr );

  void setContextMenu( QMenu * m );

protected:
  void contextMenuEvent( QContextMenuEvent * event ) override;

private:
  QMenu * contextMenu;
};

#endif // ORDERTABLEVIEW_H
