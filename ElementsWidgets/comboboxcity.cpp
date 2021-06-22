#include "comboboxcity.h"

#include <QSqlError>
#include <QSqlQuery>

ComboBoxCity::ComboBoxCity( QWidget *parent ) : QComboBox( parent ), currentIdCountry { 0 } {
  // TODO какоето начальное значение
}

void ComboBoxCity::getCity( int idCountry ) {
  currentIdCountry = idCountry;
  QSqlQuery query( QSqlDatabase::database( "DB" ) );
  QString qs( "SELECT city_id, city_name FROM cities WHERE country_id = %1 ORDER BY city_name;" );
  qs = qs.arg( idCountry );
  query.exec( qs );
  if ( query.isActive( ) ) {
    clear( );
    while ( query.next( ) ) {
      addItem( query.value( "city_name" ).toString( ), query.value( "city_id" ) );
    }
  }
}
