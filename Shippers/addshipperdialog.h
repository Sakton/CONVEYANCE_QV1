#ifndef ADDSHIPPERDIALOG_H
#define ADDSHIPPERDIALOG_H

#include <QDialog>

namespace Ui {
class AddiShipperDialog;
}

class AddiShipperDialog : public QDialog {
  Q_OBJECT

public:
  explicit AddiShipperDialog(QWidget *parent = nullptr);
  ~AddiShipperDialog();
  // QDialog interface
public slots:
  void accept( ) override;

private:
  Ui::AddiShipperDialog * ui;
};

#endif // ADDSHIPPERDIALOG_H
