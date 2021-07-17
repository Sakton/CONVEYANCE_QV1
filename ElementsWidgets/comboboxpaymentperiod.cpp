#include "comboboxpaymentperiod.h"
#include <QLineEdit>

ComboBoxPaymentPeriod::ComboBoxPaymentPeriod( QWidget *parent ) : QComboBox( parent ) {
  QStringList items { tr( "60 дней" ), tr( "55 дней" ), tr( "45 дней" ),    tr( "35 дней" ),
                      tr( "30 дней" ), tr( "14 дней" ), tr( "на выгрузке" ) };
  addItems( items );
  setEditable( true );
  lineEdit( )->setAlignment( Qt::AlignCenter );
  lineEdit( )->setReadOnly( true );
}
