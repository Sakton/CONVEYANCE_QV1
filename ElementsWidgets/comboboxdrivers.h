#ifndef COMBOBOXDRIVERS_H
#define COMBOBOXDRIVERS_H

#include <QComboBox>

class ComboBoxDrivers : public QComboBox
{
  Q_OBJECT
public:
  ComboBoxDrivers( QWidget * parent = nullptr );
  void init( );
};

#endif // COMBOBOXDRIVERS_H
