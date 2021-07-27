#ifndef ORDERWIDGET_H
#define ORDERWIDGET_H

#include <QWidget>

class OrderSqlQueryModel;
class QSortFilterProxyModel;

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

private:
  void initModel( );
  void connects( );
  void refresh( );

private:
  Ui::OrderWidget * ui;
  OrderSqlQueryModel * model;
  QSortFilterProxyModel * proxy;
};

#endif // ORDERWIDGET_H
