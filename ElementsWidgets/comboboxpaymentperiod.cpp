#include "comboboxpaymentperiod.h"

ComboBoxPaymentPeriod::ComboBoxPaymentPeriod( QWidget *parent ) : QComboBox( parent ) {
  QStringList items { "1", "2", "4", "8", "16", "32", "60", "nd" };
  addItems( items );
}
