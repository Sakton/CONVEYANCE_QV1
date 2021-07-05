#ifndef ADRESSSQLTABLEMODEL_H
#define ADRESSSQLTABLEMODEL_H

#include <QSqlTableModel>

class AdressSqlTableModel : public QSqlTableModel
{
  Q_OBJECT
public:
  explicit AdressSqlTableModel( QObject *parent = nullptr, const QSqlDatabase &db = QSqlDatabase( ) );
  // QAbstractItemModel interface
public:
  QVariant data( const QModelIndex &index, int role ) const override;
};

#endif // ADRESSSQLTABLEMODEL_H
