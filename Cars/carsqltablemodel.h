#ifndef CARSQLTABLEMODEL_H
#define CARSQLTABLEMODEL_H

#include <QSqlTableModel>

class CarSqlTableModel : public QSqlTableModel {
  Q_OBJECT
public:
  explicit CarSqlTableModel( QObject * parent = nullptr, const QSqlDatabase & db = { } );

  // QAbstractItemModel interface
public:
  QVariant data( const QModelIndex & index, int role ) const override;
};

#endif // CARSQLTABLEMODEL_H
