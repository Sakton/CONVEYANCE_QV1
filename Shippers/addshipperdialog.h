#ifndef ADDSHIPPERDIALOG_H
#define ADDSHIPPERDIALOG_H

#include <QDialog>

namespace Ui {
class AddShipperDialog;
}

class AddShipperDialog : public QDialog {
  Q_OBJECT

public:
  explicit AddShipperDialog( QWidget * parent = nullptr );
  ~AddShipperDialog( );
  // QDialog interface
public slots:
  void accept( ) override;

private:
  Ui::AddShipperDialog * ui;
};

#endif // ADDSHIPPERDIALOG_H
