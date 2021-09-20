#include "comboboxcarmodel.h"
#include <QSqlError>
#include <QSqlQuery>

ComboBoxCarModel::ComboBoxCarModel( QWidget *parent ) : QComboBox( parent ) {
}

void ComboBoxCarModel::init( ) { QString qs = QString( "" ); }

void ComboBoxCarModel::update( ) {
  clear( );
  init( );
}
