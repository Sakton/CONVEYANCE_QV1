#include "comboboxcarmodel.h"
#include <QSqlError>
#include <QSqlQuery>
#include <QSqlRecord>

// ******** MODEL

CarModelSqlQueryModel::CarModelSqlQueryModel( QObject * parent ) : QSqlQueryModel( parent ) {
  
}

QVariant CarModelSqlQueryModel::data( const QModelIndex & index, int role ) const {
  if ( !index.isValid( ) )
    return { };
  switch ( role ) {
  case Qt::DisplayRole:
    return record( index.row( ) ).value( "" ).toString( );
  }

  return QSqlQueryModel::data( index, role );
}

// ******** COMBOBOX

ComboBoxCarModel::ComboBoxCarModel( QWidget * parent ) : QComboBox( parent ) {}

void ComboBoxCarModel::init( ) {}

void ComboBoxCarModel::update( ) {
  clear( );
  init( );
}
