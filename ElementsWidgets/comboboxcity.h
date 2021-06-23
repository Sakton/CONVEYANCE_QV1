#ifndef COMBOBOXCITY_H
#define COMBOBOXCITY_H

#include <QComboBox>

class ComboBoxCity : public QComboBox
{
  Q_OBJECT
public:
  explicit ComboBoxCity( QWidget *parent = nullptr );

  void getCity( int idCountry );

public slots:
  void update( );
  void update( int idCity );

private:
  int currentIdCountry;
};

#endif // COMBOBOXCITY_H