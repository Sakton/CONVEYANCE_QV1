#ifndef ORDERTABLEVIEW_H
#define ORDERTABLEVIEW_H

#include <QWidget>

class OrderSqlQueryModel;

namespace Ui {
class OrderTableView;
}

class OrderTableView : public QWidget
{
  Q_OBJECT

public:
  explicit OrderTableView(QWidget *parent = nullptr);
  ~OrderTableView();

private:
  void initModel( );

private:
  Ui::OrderTableView * ui;
  OrderSqlQueryModel * model;
};

#endif // ORDERTABLEVIEW_H
