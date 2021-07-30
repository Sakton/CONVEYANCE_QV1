#ifndef ORDERWIDGET_H
#define ORDERWIDGET_H

#include <QWidget>

class OrderSqlQueryModel;
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

private:
  void initModel( );
  void createConnects( );
  void refresh( );

private:
  Ui::OrderWidget * ui;
  OrderSqlQueryModel * model;
  QSortFilterProxyModel * proxy;
};

#endif // ORDERWIDGET_H
