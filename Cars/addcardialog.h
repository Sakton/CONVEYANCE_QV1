#ifndef ADDCARDIALOG_H
#define ADDCARDIALOG_H

#include <QDialog>

namespace Ui {
class AddCarDialog;
}

class AddCarDialog : public QDialog {
  Q_OBJECT

public:
  explicit AddCarDialog( QWidget * parent = nullptr );
  ~AddCarDialog( );
  void accept( ) override;

private:
  Ui::AddCarDialog * ui;
};

#endif // ADDCARDIALOG_H
