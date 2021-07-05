#include "adresssqltablemodel.h"

AdressSqlTableModel::AdressSqlTableModel( QObject *parent, const QSqlDatabase &db ) : QSqlTableModel( parent, db ) {
}

QVariant AdressSqlTableModel::data( const QModelIndex &index, int role ) const {
  if ( role == Qt::TextAlignmentRole )
    return Qt::AlignCenter;
  return QSqlTableModel::data( index, role );
}
