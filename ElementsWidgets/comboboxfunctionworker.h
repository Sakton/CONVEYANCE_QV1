#ifndef COMBOBOXFUNCTIONWORKER_H
#define COMBOBOXFUNCTIONWORKER_H

#include <QComboBox>

class ComboBoxFunctionWorker : public QComboBox {
  Q_OBJECT
public:
  ComboBoxFunctionWorker( QWidget * parent = 0 );
  void updateData( );

private:
  void init( );
};

#endif // COMBOBOXFUNCTIONWORKER_H
