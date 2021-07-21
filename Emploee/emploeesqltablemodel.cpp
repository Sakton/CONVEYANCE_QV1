#include "emploeesqltablemodel.h"

EmploeeSqlTableModel::EmploeeSqlTableModel( QObject * parent, const QSqlDatabase & db ) : QSqlTableModel( parent, db ) {
  setTable( "emploee.emploeeview" );
  setHeaderData( 0, Qt::Orientation::Horizontal, tr( "ID" ) );
  setHeaderData( 1, Qt::Orientation::Horizontal, tr( "ИМЯ" ) );
  setHeaderData( 2, Qt::Orientation::Horizontal, tr( "ДОЛЖНОСТЬ" ) );
  setHeaderData( 3, Qt::Orientation::Horizontal, tr( "КАТЕГОРИЯ ВУ" ) );
  select( );
}

QVariant EmploeeSqlTableModel::data( const QModelIndex & index, int role ) const {
  if ( role == Qt::TextAlignmentRole )
    return Qt::AlignCenter;
  return QSqlTableModel::data( index, role );
}
