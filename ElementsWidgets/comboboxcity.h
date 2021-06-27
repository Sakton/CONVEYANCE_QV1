#ifndef COMBOBOXCITY_H
#define COMBOBOXCITY_H

#include <QComboBox>

class ComboBoxCity : public QComboBox
{
  Q_OBJECT
public:
  explicit ComboBoxCity( QWidget *parent = nullptr );

  void getCity( int idCountry );
  int getCurrentIdCountry( ) const;

public slots:
  void updateCity( );
  void updateCity( int idCountry );

private:
  int currentIdCountry;
};

#endif // COMBOBOXCITY_H
