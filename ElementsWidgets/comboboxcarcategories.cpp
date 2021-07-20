#include "comboboxcarcategories.h"
#include "Constants.h"
#include <QSqlQuery>

ComboBoxCarCategories::ComboBoxCarCategories( QWidget *parent ) : QComboBox( parent ) {
  init( );
}

void ComboBoxCarCategories::init( ) {
  QSqlQuery query( "SELECT autocategory_id, autocategory_symbol, autocategory_icon FROM cars.autocategories;",
		   QSqlDatabase::database( NAME_DB_ALL ) );
  while ( query.next( ) ) {
    QVariant id = query.value( "autocategory_id" );
    QString categorySymbol = query.value( "autocategory_symbol" ).toString( );
    QString nameFilePathIconImg = QString( ":/img/CategoriesAuto/" ) + query.value( "autocategory_icon" ).toString( );
    addItem( QIcon { nameFilePathIconImg }, categorySymbol, id );
    setIconSize( QSize { 76, 24 } );
  }
}
