/* Комбо-бокс для отображения списка периодов высылки докуметов почтой */

#ifndef COMBOBOXPERIODSENDMAIL_H
#define COMBOBOXPERIODSENDMAIL_H

#include <QComboBox>

class ComboBoxPeriodSendMail : public QComboBox
{
  Q_OBJECT
public:
  explicit ComboBoxPeriodSendMail( QWidget *parent = nullptr );
};

#endif // COMBOBOXPERIODSENDMAIL_H
