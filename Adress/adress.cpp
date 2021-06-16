#include "adress.h"
#include "ui_adress.h"

Adress::Adress(QWidget *parent) :
      QWidget(parent),
      ui(new Ui::Adress)
{
  ui->setupUi(this);
}

Adress::~Adress()
{
  delete ui;
}
