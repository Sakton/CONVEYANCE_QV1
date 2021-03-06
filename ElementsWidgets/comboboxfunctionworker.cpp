#include "comboboxfunctionworker.h"
#include "Constants.h"

#include <QSqlError>
#include <QSqlQuery>

ComboBoxFunctionWorker::ComboBoxFunctionWorker( QWidget * parent ) : QComboBox( parent ) { init( ); }

void ComboBoxFunctionWorker::updateData( ) { init( ); }

void ComboBoxFunctionWorker::init( ) {
  clear( );
  QString qs { "SELECT functionworker_id, functionworker_name FROM  emploee.functionworker;" };
  QSqlQuery query( QSqlDatabase::database( ConveyanceConstats::NAME_DB_ALL ) );
  if ( !query.exec( qs ) )
    qDebug( ) << query.lastError( ).text( );
  else
    while ( query.next( ) ) {
      addItem( query.value( "functionworker_name" ).toString( ), query.value( "functionworker_id" ) );
    }
}
