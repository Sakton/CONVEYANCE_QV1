#include "comboboxdrivers.h"
#include "Constants.h"

#include <QSqlError>
#include <QSqlQuery>

ComboBoxDrivers::ComboBoxDrivers( QWidget * parent ) : QComboBox( parent ) { init( ); }

void ComboBoxDrivers::init( ) {
  QSqlQuery query( QSqlDatabase::database( NAME_DB_ALL ) );
  QString qs = QString { "SELECT emploee_name FROM emploee.voditeli;" };
  if ( !query.exec( qs ) )
    qDebug( ) << query.lastError( ).text( );
  else
    while ( query.next( ) ) {
      addItem( query.value( "emploee_name" ).toString( ) );
    }
}