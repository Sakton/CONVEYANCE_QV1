#include "createorderdialog.h"
#include "Shippers/addshipperdialog.h"
#include "ui_createorderdialog.h"

#include "Constants.h"
#include <QMessageBox>
#include <QSqlQuery>

CreateOrderDialog::CreateOrderDialog( QWidget *parent ) : QDialog( parent ), ui( new Ui::CreateOrderDialog ) {
  ui->setupUi(this);
  ui->dateEdit->setDate( QDate::currentDate( ) );
  connects( );
}

CreateOrderDialog::~CreateOrderDialog( ) {
  delete ui;
}

void CreateOrderDialog::accept( ) {

  //**** ЧАСТЬ ОРДЕР
  QDate date = ui->dateEdit->date( );
  QString numberContract = ui->lineEditnumberContract->text( );
  if ( numberContract.isEmpty( ) ) {
    QMessageBox::warning( this, tr( "Пустое поле" ), tr( "ПОЛЕ \"ДОГОВОР\": НЕ МОЖЕТ БЫТЬ ПУСТЫМ" ) );
    return;
  }
  int idShippers = ui->comboBoxShippers->currentData( ).toInt( );
  int idDriver = ui->comboBoxDriver->currentData( ).toInt( );
  qDebug( ) << "договор = " << date << " " << numberContract << " " << idShippers << " " << idDriver;
  //**** заметки
  QString text = ui->plainTextEditNote->toPlainText( );
  qDebug( ) << "notes = " << text;

  //**** ЧАСТЬ ОПЛАТА
  double cost = ui->doubleSpinBoxCost->value( );
  QString paymentPeriod = ui->comboBoxPaymentPeriod->currentText( );
  QString currency = ui->comboBoxCurrency->currentText( );
  qDebug( ) << "данные маршрута = " << cost << " " << paymentPeriod << " " << currency;

  //**** ЧАСТЬ МАРШРУТ
  int arrival = ui->spinBoxArrival->value( );
  int route = ui->spinBoxRoute->value( );
  double ante = ui->doubleSpinBoxAnte->value( );
  qDebug( ) << "route option = " << arrival << " " << route << " " << ante;

  //**** ЧАСТЬ ДОКУМЕНТЫ
  QString postPeriod = ui->comboBoxPostPeriad->currentText( );
  Qt::CheckState twoCopyCMR = ui->checkBox2CopyCMR->checkState( );
  Qt::CheckState originalContract = ui->checkBoxOriginalContract->checkState( );
  qDebug( ) << "doc options = " << postPeriod << " " << twoCopyCMR << " " << originalContract;

  QSqlQuery query( QSqlDatabase::database( NAME_DB_ALL ) );
  QString qs = QString { "" };

  // QDialog::accept( );
}

void CreateOrderDialog::slotAddShipper( ) {
  AddShipperDialog dialogAddShipper;
  dialogAddShipper.exec( );
}

void CreateOrderDialog::connects( ) {
  connect( ui->pushButtonAddShipper, QOverload< bool >::of( &QPushButton::clicked ), this, QOverload<>::of( &CreateOrderDialog::slotAddShipper ) );
}
