/* Комбо-бокс типа адреса */

#ifndef COMBOBOXTYPEADRESS_H
#define COMBOBOXTYPEADRESS_H

#include <QComboBox>

class ComboBoxTypeAdress : public QComboBox
{
  Q_OBJECT
public:
  ComboBoxTypeAdress( QWidget *parent = nullptr );
  QString castToDb( );
};

#endif // COMBOBOXTYPEADRESS_H
