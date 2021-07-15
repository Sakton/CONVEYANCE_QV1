#include "comboboxperiodsendmail.h"
#include <QLineEdit>

ComboBoxPeriodSendMail::ComboBoxPeriodSendMail( QWidget *parent ) : QComboBox( parent ) {
  QStringList listItem { "1 день", "2 дня", "4 дня", "8 дней", "14 дней", "nd" };
  addItems( listItem );
  setEditable( true );
  lineEdit( )->setAlignment( Qt::AlignCenter );
  lineEdit( )->setReadOnly( true );
}
