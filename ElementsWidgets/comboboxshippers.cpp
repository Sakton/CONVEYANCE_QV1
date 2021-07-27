#include "comboboxshippers.h"
#include "Constants.h"

#include <QSqlError>
#include <QSqlQuery>

ComboBoxShippers::ComboBoxShippers( QWidget * parent ) : QComboBox( parent ) { init( ); }

void ComboBoxShippers::init( ) {
  clear( );
  QString qs { "SELECT shipper_id, shipper_name FROM shipper.shippers" };
  QSqlQuery query( QSqlDatabase::database( NAME_DB_ALL ) );
  if ( !query.exec( qs ) )
    qDebug( ) << query.lastError( ).text( );
  else
    while ( query.next( ) )
      addItem( query.value( "shipper_name" ).toString( ), query.value( "shipper_id" ) );
}
