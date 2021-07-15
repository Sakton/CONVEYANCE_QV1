#include "comboboxpaymentperiod.h"
#include <QLineEdit>

ComboBoxPaymentPeriod::ComboBoxPaymentPeriod( QWidget *parent ) : QComboBox( parent ) {
  QStringList items { "1 день", "2 дня", "4 дня", "8 дней", "16 дней", "32 дня", "60 дней", "nd" };
  addItems( items );
  setEditable( true );
  lineEdit( )->setAlignment( Qt::AlignCenter );
  lineEdit( )->setReadOnly( true );
}
