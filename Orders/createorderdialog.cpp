#include "createorderdialog.h"
#include "Shippers/addshipperdialog.h"
#include "ui_createorderdialog.h"

#include <QMessageBox>

CreateOrderDialog::CreateOrderDialog( QWidget *parent ) : QDialog( parent ), ui( new Ui::CreateOrderDialog ) {
  ui->setupUi(this);
  ui->dateEdit->setDate( QDate::currentDate( ) );
  connects( );
}

CreateOrderDialog::~CreateOrderDialog( ) {
  delete ui;
}

void CreateOrderDialog::accept( ) {
  //**** договор
  QDate date = ui->dateEdit->date( );
  qDebug( ) << date;
  QString numberContract = ui->lineEditnumberContract->text( );
  if ( numberContract.isEmpty( ) ) {
    QMessageBox::warning( this, tr( "Пустое поле" ), tr( "ПОЛЕ \"ДОГОВОР\": НЕ МОЖЕТ БЫТЬ ПУСТЫМ" ) );
    return;
  }
  int idShippers = ui->comboBoxShippers->currentData( ).toInt( );
  int idDriver = ui->comboBoxDriver->currentData( ).toInt( );
  qDebug( ) << "договор = " << date << " " << numberContract << " " << idShippers << " " << idDriver;

  //**** оплата
  double cost = ui->doubleSpinBoxCost->value( );
  QString paymentPeriod = ui->comboBoxPaymentPeriod->currentText( );
  QString currency = ui->comboBoxCurrency->currentText( );
  qDebug( ) << "данные маршрута = " << cost << " " << paymentPeriod << " " << currency;

  //**** маршрут
  int arrival = ui->spinBoxArrival->value( );
  int route = ui->spinBoxRoute->value( );
  double ante = ui->doubleSpinBoxAnte->value( );

  //****
  // QDialog::accept( );
}

void CreateOrderDialog::slotAddShipper( ) {
  AddShipperDialog dialogAddShipper;
  dialogAddShipper.exec( );
}

void CreateOrderDialog::connects( ) {
  connect( ui->pushButtonAddShipper, QOverload< bool >::of( &QPushButton::clicked ), this, QOverload<>::of( &CreateOrderDialog::slotAddShipper ) );
}
