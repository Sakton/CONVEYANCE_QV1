#ifndef ADDCARMODELDIALOG //---_H
#define ADDCARMODELDIALOG //---_H

#include <QDialog>

namespace Ui {
class AddCarModelDialog;
}

class AddCarModelDialog : public QDialog
{
  Q_OBJECT

public:
  explicit AddCarModelDialog(QWidget *parent = nullptr);
  ~AddCarModelDialog();
  // QDialog interface
public slots:
  void accept( ) override;

private:
  Ui::AddCarModelDialog *ui;
};

#endif // ADDCARMODELDIALOG---_H
