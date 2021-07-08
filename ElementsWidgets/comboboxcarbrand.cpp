#include "comboboxcarbrand.h"
#include "Constants.h"
#include <QDir>
#include <QMessageBox>
#include <QSqlError>
#include <QSqlQuery>

ComboBoxCarBrand::ComboBoxCarBrand( QWidget *parent ) : QComboBox( parent ) {
  init( );
  setIconSize( { 48, 48 } );
}

void ComboBoxCarBrand::init( ) {
  QSqlQuery query( "SELECT autobrand_id, autobrand_name, autobrand_icon FROM auto.autobrands;", QSqlDatabase::database( NAME_DB_ALL ) );
  while ( query.next( ) ) {
    QString fileName = query.value( "autobrand_icon" ).toString( );
    QString pathPix;
    ( fileName != QLatin1String( NAME_EMPTY_IMG_ICON ) ) ? pathPix = QString( QDir::currentPath( ) + "/" + NAME_DIR_LOGOBRANDS + "/" + fileName )
                                                         : pathPix = QString( "qrc:/img/No_image.png" );
    addItem( QIcon { QPixmap { pathPix } }, query.value( "autobrand_name" ).toString( ), query.value( "autobrand_id" ) );
  }
}
