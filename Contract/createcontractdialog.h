#ifndef CREATECONTRACTDIALOG_H
#define CREATECONTRACTDIALOG_H

#include <QDialog>

namespace Ui {
class CreateContractDialog;
}

class CreateContractDialog : public QDialog {
  Q_OBJECT

public:
  explicit CreateContractDialog(QWidget *parent = nullptr);
  ~CreateContractDialog();
  // QDialog interface
public slots:
  void accept( ) override;

private:
  Ui::CreateContractDialog *ui;
};

#endif // CREATECONTRACTDIALOG_H
