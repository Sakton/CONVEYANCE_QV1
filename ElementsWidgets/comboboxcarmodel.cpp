#include "comboboxcarmodel.h"

ComboBoxCarModel::ComboBoxCarModel( QWidget *parent ) : QComboBox( parent ) {
}

void ComboBoxCarModel::init( ) {
  //заполняем из базы
}

void ComboBoxCarModel::update( ) {
  clear( );
  init( );
}
