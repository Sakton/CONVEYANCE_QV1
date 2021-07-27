#include "ordersqlquerymodel.h"

OrderSqlQueryModel::OrderSqlQueryModel( QObject * parent ) : QSqlQueryModel( parent ) {}

QVariant OrderSqlQueryModel::data( const QModelIndex & index, int role ) const {
  if ( role == Qt::TextAlignmentRole )
    return Qt::AlignCenter;
  return QSqlQueryModel::data( index, role );
}
