#ifndef COMBOBOXSHIPPERS_H
#define COMBOBOXSHIPPERS_H

#include <QComboBox>

class ComboBoxShippers : public QComboBox
{
  Q_OBJECT
public:
  ComboBoxShippers( QWidget * parent = nullptr );
  void init( );
};

#endif // COMBOBOXSHIPPERS_H
