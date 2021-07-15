#include "createorderdialog.h"
#include "ui_createorderdialog.h"

CreateOrderDialog::CreateOrderDialog( QWidget *parent ) : QDialog( parent ), ui( new Ui::CreateOrderDialog ) {
  ui->setupUi(this);
}

CreateOrderDialog::~CreateOrderDialog( ) {
  delete ui;
}

void CreateOrderDialog::accept( ) {
  QDialog::accept( );
}
