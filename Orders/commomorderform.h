#ifndef COMMOMORDERFORM_H
#define COMMOMORDERFORM_H

#include <QDialog>

namespace Ui {
class CommomOrderForm;
}

class CommomOrderForm : public QDialog {
  Q_OBJECT

public:
  enum class Regim { ADD, UPD };
  explicit CommomOrderForm( Regim regim = Regim::ADD, QWidget * parent = nullptr );
  ~CommomOrderForm( );

protected:
  Ui::CommomOrderForm * ui;
  Regim r;
};

#endif // COMMOMORDERFORM_H
