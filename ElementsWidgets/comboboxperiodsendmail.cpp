#include "comboboxperiodsendmail.h"
#include <QLineEdit>

ComboBoxPeriodSendMail::ComboBoxPeriodSendMail( QWidget *parent ) : QComboBox( parent ) {
  QStringList listItem { tr( "5 дней" ),  tr( "7 дней" ),  tr( "10 дней" ), tr( "14 дней" ),
                         tr( "20 дней" ), tr( "25 дней" ), tr( "30 дней" ), tr( "e-mail" ) };
  addItems( listItem );
  setEditable( true );
  lineEdit( )->setAlignment( Qt::AlignCenter );
  lineEdit( )->setReadOnly( true );
}
