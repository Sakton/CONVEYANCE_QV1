#include "comboboxcity.h"
#include "Constants.h"

#include <QSqlError>
#include <QSqlQuery>

ComboBoxCity::ComboBoxCity( QWidget *parent ) : QComboBox( parent ), currentIdCountry { 0 } {
}

void ComboBoxCity::getCity( int idCountry ) {
  currentIdCountry = idCountry;
  QSqlQuery query( QSqlDatabase::database( NAME_DB_ALL ) );
  QString qs =
      QString( "SELECT city_id, city_name FROM adres.сities WHERE country_id = %1 ORDER BY city_name;" ).arg( idCountry );
  query.exec( qs );
  clear( );
  while( query.next( ) ) {
    addItem( query.value( "city_name" ).toString( ), query.value( "city_id" ) );
  }
}

void ComboBoxCity::updateCity( ) { getCity( currentIdCountry ); }

void ComboBoxCity::updateCity( int idCountry ) { getCity( idCountry ); }

int ComboBoxCity::getCurrentIdCountry( ) const { return currentIdCountry; }
