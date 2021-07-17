/* Комбо-бокс для отображения списка периодов оплаты */

#ifndef COMBOBOXPAYMENTPERIOD_H
#define COMBOBOXPAYMENTPERIOD_H
#include <QComboBox>

class ComboBoxPaymentPeriod : public QComboBox {
  Q_OBJECT
public:
  ComboBoxPaymentPeriod( QWidget *parent = nullptr );
};

#endif // COMBOBOXPAYMENTPERIOD_H
