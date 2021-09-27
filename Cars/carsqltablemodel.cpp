#include "carsqltablemodel.h"

CarSqlTableModel::CarSqlTableModel( QObject * parent, const QSqlDatabase & db ) : QSqlTableModel( parent, db ) {
  setTable( "wagons.autos" );
  select( );
  setEditStrategy( QSqlTableModel::EditStrategy::OnFieldChange );
  setHeaderData( 0, Qt::Orientation::Horizontal, "ID" );
  setHeaderData( 1, Qt::Orientation::Horizontal, tr( "Бренд" ) );
  setHeaderData( 2, Qt::Orientation::Horizontal, tr( "Длина" ) );
  setHeaderData( 3, Qt::Orientation::Horizontal, tr( "Ширина" ) );
  setHeaderData( 4, Qt::Orientation::Horizontal, tr( "Высота" ) );
  setHeaderData( 5, Qt::Orientation::Horizontal, tr( "ВИН" ) );
  setHeaderData( 6, Qt::Orientation::Horizontal, tr( " Дата выпуска " ) );
  setHeaderData( 7, Qt::Orientation::Horizontal, tr( "    Дата ГТО  " ) );
}

QVariant CarSqlTableModel::data( const QModelIndex & index, int role ) const {
  if ( role == Qt::TextAlignmentRole )
    return Qt::AlignCenter;
  return QSqlTableModel::data( index, role );
}
