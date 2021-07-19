#ifndef ADRESSSQLQUERYMODEL_H
#define ADRESSSQLQUERYMODEL_H

#include <QSqlQueryModel>

// может понадобится, а так кандидат на удаление

class AdressSqlQueryModel : public QSqlQueryModel
{
  Q_OBJECT
public:
  explicit AdressSqlQueryModel( QObject *parent = nullptr );

  // QAbstractItemModel interface
public:
  QVariant data( const QModelIndex &index, int role ) const override;
};

#endif // ADRESSSQLQUERYMODEL_H
