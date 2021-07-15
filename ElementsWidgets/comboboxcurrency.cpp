#include "comboboxcurrency.h"
#include <QLineEdit>

ComboBoxCurrency::ComboBoxCurrency( QWidget *parent ) : QComboBox( parent ) {
  QStringList items { "PL", "EUR", "PL/EUR" };
  addItems( items );
  setEditable( true );
  lineEdit( )->setAlignment( Qt::AlignCenter );
  lineEdit( )->setReadOnly( true );
  // setStyleSheet( "ComboBoxCurrency{ padding-left: 20px; } " );
}
