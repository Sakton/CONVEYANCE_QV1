#ifndef COMBOBOXCARBRAND_H
#define COMBOBOXCARBRAND_H

#include <QComboBox>

class ComboBoxCarBrand : public QComboBox {
  Q_OBJECT
public:
  ComboBoxCarBrand( QWidget *parent = nullptr );
  void init( );
};

#endif // COMBOBOXCARBRAND_H
