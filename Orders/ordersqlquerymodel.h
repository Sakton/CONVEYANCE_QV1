#ifndef ORDERSQLQUERYMODEL_H
#define ORDERSQLQUERYMODEL_H

#include <QSqlQueryModel>

class OrderSqlQueryModel : public QSqlQueryModel
{
  Q_OBJECT
public:
  explicit OrderSqlQueryModel(QObject *parent = nullptr);
};

#endif // ORDERSQLQUERYMODEL_H
