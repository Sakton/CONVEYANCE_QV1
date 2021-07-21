#include "emploeesqltablemodel.h"

EmploeeSqlTableModel::EmploeeSqlTableModel( QObject * parent, const QSqlDatabase & db ) : QSqlTableModel( parent, db ) {}

QVariant EmploeeSqlTableModel::data( const QModelIndex & index, int role ) const {
  if ( role == Qt::TextAlignmentRole )
    return Qt::AlignCenter;
  return QSqlTableModel::data( index, role );
}
