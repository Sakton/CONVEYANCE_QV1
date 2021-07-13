#include "comboboxcarcategories.h"
#include "Constants.h"
#include <QSqlQuery>

ComboBoxCarCategories::ComboBoxCarCategories( QWidget *parent ) : QComboBox( parent ) {
  init( );
}

void ComboBoxCarCategories::init( ) {
  QString qs = QString( "SELECT autocategory_id, autocategory_name, autocategory_symbol, autocategory_icon"
                        "FROM auto.autocategoryes;" );
  QSqlQuery query( qs, QSqlDatabase::database( NAME_DB_ALL ) );
  while ( query.next( ) ) {
    QString nameFileIconImg = query.value( "autocategory_icon" ).toString( );
  }
}
