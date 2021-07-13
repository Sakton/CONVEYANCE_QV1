#ifndef COMBOBOXCARCATEGORIES_H
#define COMBOBOXCARCATEGORIES_H

#include <QComboBox>

class ComboBoxCarCategories : public QComboBox
{
  Q_OBJECT
public:
  ComboBoxCarCategories( QWidget *parent = nullptr );
  void init( );
};

#endif // COMBOBOXCARCATEGORIES_H
