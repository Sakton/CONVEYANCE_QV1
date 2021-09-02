#include "ordersqltablemodel.h"

OrderSqlTableModel::OrderSqlTableModel( QObject * parent, const QSqlDatabase & db ) : QSqlTableModel( parent, db ) {}

QVariant OrderSqlTableModel::data( const QModelIndex & index, int role ) const {
  if ( index.column( ) == 9 && role == Qt::DisplayRole ) {
    // qDebug( ) << itemData( index );
  }
  if ( role == Qt::TextAlignmentRole ) {
    return Qt::AlignCenter;
  }
  return QSqlTableModel::data( index, role );
}
