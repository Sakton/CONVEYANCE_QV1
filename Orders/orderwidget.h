#ifndef ORDERWIDGET_H
#define ORDERWIDGET_H

#include <QWidget>

class OrderSqlTableModel;
class QSortFilterProxyModel;
class QModelIndex;

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
  void slotSelectRow( const QModelIndex & idx );
  void updateOrderWidget( );

private:
  void createConnects( );
  void initModels( );
  void setupView( );

private:
  Ui::OrderWidget * ui;
  OrderSqlTableModel * model;
  QSortFilterProxyModel * proxy;
};

#endif // ORDERWIDGET_H
