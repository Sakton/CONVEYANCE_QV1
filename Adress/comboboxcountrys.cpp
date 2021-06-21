#include "comboboxcountrys.h"

#include <QSqlQuery>

ComboBoxCountrys::ComboBoxCountrys( QWidget *parent ) : QComboBox( parent ) {
  QSqlQuery query( QSqlDatabase::database( "DB" ) );
  QString sq( "SELECT country_id, country_name, country_icon FROM countrys ORDER BY country_name" );
  query.exec( sq );
  while ( query.next( ) ) {
    QIcon icon( QPixmap( QString( ":/img/flagCountrys/%1" ).arg( query.value( "country_icon" ).toString( ) ) ) );
    QString txt( query.value( "country_name" ).toString( ) );
    QVariant id = query.value( "country_id" );
    addItem( icon, txt, id );
    setIconSize( QSize( 24, 24 ) );
  }
}
