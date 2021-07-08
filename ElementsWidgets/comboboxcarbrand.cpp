#include "comboboxcarbrand.h"
#include "ui_comboboxcarbrand.h"

comboBoxCarBrand::comboBoxCarBrand(QWidget *parent) :
      QWidget(parent),
      ui(new Ui::comboBoxCarBrand)
{
  ui->setupUi(this);
}

comboBoxCarBrand::~comboBoxCarBrand()
{
  delete ui;
}
