/* Комбо-бокс для отображения списка валют */

#ifndef COMBOBOXCURRENCY_H
#define COMBOBOXCURRENCY_H

#include <QComboBox>

class ComboBoxCurrency : public QComboBox {
  Q_OBJECT
public:
  explicit ComboBoxCurrency( QWidget *parent = nullptr );
};

#endif // COMBOBOXCURRENCY_H
