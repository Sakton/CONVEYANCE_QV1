#include "createcontractdialog.h"
#include "ui_createcontractdialog.h"

CreateContractDialog::CreateContractDialog(QWidget *parent) :
      QDialog(parent),
      ui(new Ui::CreateContractDialog)
{
  ui->setupUi(this);
}

CreateContractDialog::~CreateContractDialog()
{
  delete ui;
}
