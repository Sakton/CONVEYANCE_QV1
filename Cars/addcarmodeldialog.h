#ifndef ADDCARMODELDIALOG_H
#define ADDCARMODELDIALOG_H

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

#endif // ADDCARMODELDIALOG_H
