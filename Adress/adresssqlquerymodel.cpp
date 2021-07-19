#include "adresssqlquerymodel.h"

AdressSqlQueryModel::AdressSqlQueryModel( QObject *parent ) : QSqlQueryModel( parent ) {
}

QVariant AdressSqlQueryModel::data( const QModelIndex &index, int role ) const {
  if ( role == Qt::TextAlignmentRole )
    return Qt::AlignCenter;
  else
    return QSqlQueryModel::data( index, role );
}
