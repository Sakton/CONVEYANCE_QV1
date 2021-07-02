#include "comboboxtypeadress.h"

ComboBoxTypeAdress::ComboBoxTypeAdress( QWidget *parent ) : QComboBox( parent ) {
  addItem( tr( "Фактический" ) );
  addItem( tr( "Юридический" ) );
}

QString ComboBoxTypeAdress::castToDb( ) {
  return currentIndex( ) ? "LEGAL" : "FACT";
}
