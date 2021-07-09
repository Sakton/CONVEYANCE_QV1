#ifndef COMBOBOXCARMODEL_H
#define COMBOBOXCARMODEL_H

#include <QComboBox>

class ComboBoxCarModel : public QComboBox {
  Q_OBJECT
public:
  ComboBoxCarModel( QWidget *parent = nullptr );
  void init( );
  void update( );
};

#endif // COMBOBOXCARMODEL_H
