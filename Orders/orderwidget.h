#ifndef ORDERWIDGET_H
#define ORDERWIDGET_H

#include <QWidget>

class OrderSqlTableModel;
class QSortFilterProxyModel;
class QModelIndex;
class QAction;
class QMenu;

namespace Ui {
class OrderWidget;
}

class OrderWidget : public QWidget {
  Q_OBJECT

public:
  explicit OrderWidget( QWidget * parent = nullptr );
  ~OrderWidget( );

public slots:
  void slotAddOrder( );
  void slotUpdOrder( );
  void slotDelOrder( );

  void slotSelectRow( const QModelIndex & idx );
  void updateOrderWidget( );

private:
  void createConnects( );

  void initModels( );
  void setupView( );
  void createActions( );
  void setupsAction( );

private:
  Ui::OrderWidget * ui;
  OrderSqlTableModel * model;
  QSortFilterProxyModel * proxy;
  QAction * addingOrderAction;
  QAction * updateOrderAction;
  QAction * deleteOrderAction;

  QMenu * menuForTable;
};

#endif // ORDERWIDGET_H
