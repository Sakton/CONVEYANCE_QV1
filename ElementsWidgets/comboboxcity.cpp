#include "comboboxcity.h"

#include <QSqlError>
#include <QSqlQuery>

ComboBoxCity::ComboBoxCity( QWidget *parent ) : QComboBox( parent ), currentIdCountry { 0 } {
}

void ComboBoxCity::getCity( int idCountry ) {
  currentIdCountry = idCountry;
  QSqlQuery query( QSqlDatabase::database( "DB" ) );
  QString qs = QString( "SELECT city_id, city_name FROM cities WHERE country_id = %1 ORDER BY city_name;" ).arg( idCountry );
  qDebug( ) << qs;

  query.exec( qs );
  if ( query.isActive( ) ) {
    clear( );
    while ( query.next( ) ) {
      addItem( query.value( "city_name" ).toString( ), query.value( "city_id" ) );
    }
  }
}

void ComboBoxCity::updateCity( ) { getCity( currentIdCountry ); }

void ComboBoxCity::updateCity( int idCountry ) { getCity( idCountry ); }

int ComboBoxCity::getCurrentIdCountry( ) const { return currentIdCountry; }
