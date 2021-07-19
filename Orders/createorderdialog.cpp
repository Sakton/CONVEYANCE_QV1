#include "createorderdialog.h"
#include "Shippers/addshipperdialog.h"
#include "ui_createorderdialog.h"

CreateOrderDialog::CreateOrderDialog( QWidget *parent ) : QDialog( parent ), ui( new Ui::CreateOrderDialog ) {
  ui->setupUi(this);
  connects( );
}

CreateOrderDialog::~CreateOrderDialog( ) {
  delete ui;
}

void CreateOrderDialog::accept( ) {
  QDialog::accept( );
}

void CreateOrderDialog::slotAddShipper( ) {
  AddiShipperDialog dialogAddShipper;
  dialogAddShipper.exec( );
}

void CreateOrderDialog::connects( ) {
  connect( ui->pushButtonAddShipper, QOverload< bool >::of( &QPushButton::clicked ), this, QOverload<>::of( &CreateOrderDialog::slotAddShipper ) );
}
