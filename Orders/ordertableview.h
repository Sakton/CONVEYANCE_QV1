#ifndef ORDERTABLEVIEW_H
#define ORDERTABLEVIEW_H

#include <QTableView>

class OrderSqlTableModel;
class QSortFilterProxyModel;

class OrderTableView : public QTableView {
  Q_OBJECT
public:
  explicit OrderTableView( QWidget * parent = nullptr );

  void initModel( );
  // QWidget interface
public slots:
  void updateData( );

protected:
  void contextMenuEvent( QContextMenuEvent * event ) override;

private:
  OrderSqlTableModel * model;
  QSortFilterProxyModel * filterModel;
};

#endif // ORDERTABLEVIEW_H
