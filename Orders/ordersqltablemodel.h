#ifndef ORDERSQLTABLEMODEL_H
#define ORDERSQLTABLEMODEL_H

#include <QSqlTableModel>

class OrderSqlTableModel : public QSqlTableModel
{
  Q_OBJECT
public:
  explicit OrderSqlTableModel( QObject * parent = nullptr, const QSqlDatabase & db = QSqlDatabase { } );

  // QAbstractItemModel interface
public:
  QVariant data( const QModelIndex & index, int role ) const override;
};

#endif // ORDERSQLTABLEMODEL_H
