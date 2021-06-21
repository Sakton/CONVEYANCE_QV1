#include "citydialog.h"
#include "ui_citydialog.h"

CityDialog::CityDialog(QWidget *parent) :
      QDialog(parent),
      ui(new Ui::CityDialog)
{
  ui->setupUi(this);
}

CityDialog::~CityDialog()
{
  delete ui;
}
