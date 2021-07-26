#include "createorderdialog.h"
#include "Shippers/addshipperdialog.h"
#include "ui_createorderdialog.h"

#include "Constants.h"
#include <QMessageBox>
#include <QSqlError>
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
  QDate data = ui->dateEdit->date( );
  QString numberContract = ui->lineEditnumberContract->text( );
  if ( numberContract.isEmpty( ) ) {
    QMessageBox::warning( this, tr( "Пустое поле" ), tr( "ПОЛЕ \"ДОГОВОР\": НЕ МОЖЕТ БЫТЬ ПУСТЫМ" ) );
    return;
  }
  int idShipper = ui->comboBoxShippers->currentData( ).toInt( );
  int idDriver = ui->comboBoxDriver->currentData( ).toInt( );
  qDebug( ) << "договор = " << data << " " << numberContract << " " << idShipper << " " << idDriver;
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

  //  QSqlQuery query( QSqlDatabase::database( NAME_DB_ALL ) );
  //  QString qs = QString { "" };

  QSqlDatabase db = QSqlDatabase::database( NAME_DB_ALL );
  QSqlQuery query( db );
  QString qsToPayment =
      QString( "SELECT payment.getPayment_id(%1, '%2', '%3') AS idpayment;" ).arg( cost ).arg( paymentPeriod, currency );
  QString qsToRoute = QString( "SELECT route.getRouteId(%1, %2, %3) AS idroute;" ).arg( arrival ).arg( route ).arg( ante );
  QString qsDocuments = QString( "SELECT document.getDocumentId ('%1', %2, %3) AS iddocument" )
                            .arg( postPeriod )
                            .arg( twoCopyCMR )
                            .arg( originalContract );

  db.transaction( ); //ТРАНЗАКЦИЯ
  query.exec( qsToPayment );
  query.next( );
  int idPayment = query.value( "idpayment" ).toInt( );
  qDebug( ) << "idPayment  = " << idPayment;
  query.exec( qsToRoute );
  query.next( );
  int idRoute = query.value( "idroute" ).toInt( );
  qDebug( ) << "idRoute  = " << idRoute;
  query.exec( qsDocuments );
  query.next( );
  int idDocument = query.value( "iddocument" ).toInt( );
  qDebug( ) << "idDocument  = " << idDocument;
  QString qsInsertOrder = QString( "CALL orders.addOrder(%1, %2, %3, %4, %5, '%6', '%7', '%8')" )
			      .arg( idShipper )
			      .arg( idDriver )
			      .arg( idPayment )
			      .arg( idRoute )
			      .arg( idDocument )
			      .arg( data.toString( ), numberContract, text );
  qDebug( ) << qsInsertOrder;
  if( !query.exec( qsInsertOrder ) ) {
    qDebug( ) << query.lastError( ).text( );
    db.rollback( ); //ОТМЕНИТЬ ТРАНЗАКЦИЮ
  }
  db.commit( ); //ПРИНЯТЬ ТРАНЗАКЦИЮ (функции получения id автоматически вставляют в базу, то есть эта транзакция частично вносит измемнения )
  // TODO тут возможно изменение поведения
  QDialog::accept( );
}

void CreateOrderDialog::slotAddShipper( ) {
  AddShipperDialog dialogAddShipper;
  dialogAddShipper.exec( );
}

void CreateOrderDialog::connects( ) {
  connect( ui->pushButtonAddShipper, QOverload< bool >::of( &QPushButton::clicked ), this, QOverload<>::of( &CreateOrderDialog::slotAddShipper ) );
}
