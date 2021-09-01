#include "createorderdialog.h"
// #include "ui_createorderdialog.h"
#include "ui_commonorderform.h"

#include "Constants.h"
#include <QMessageBox>
#include <QSpinBox>
#include <QSqlError>
#include <QSqlQuery>

CreateOrderDialog::CreateOrderDialog( QWidget * parent ) : CommonOrderForm( CommonOrderForm::Regim::ADD, parent ) {
  setWindowTitle( "Добавить ордер" );
  ui->dateEdit->setDate( QDate::currentDate( ) );
}

void CreateOrderDialog::accept( ) {
  //**** ЧАСТЬ ОРДЕР
  QDate data = ui->dateEdit->date( );				// ДАТА
  QString numberContract = ui->lineEditnumberContract->text( ); //НОМЕР ДОГОВРА
  if ( numberContract.isEmpty( ) ) {
    QMessageBox::warning( this, tr( "Пустое поле" ), tr( "ПОЛЕ \"ДОГОВОР\": НЕ МОЖЕТ БЫТЬ ПУСТЫМ" ) );
    return;
  }
  int idShipper = ui->comboBoxShippers->currentData( ).toInt( ); // ID ЗАКАЗЧИКА
  int idDriver = ui->comboBoxDriver->currentData( ).toInt( );	 // ID ВОДИЛЫ
  //**** заметки
  QString text = ui->plainTextEditNote->toPlainText( );

  //**** ЧАСТЬ ОПЛАТА
  double cost = ui->doubleSpinBoxCost->value( );
  QString paymentPeriod = ui->comboBoxPaymentPeriod->currentText( );
  QString currency = ui->comboBoxCurrency->currentText( );

  //**** ЧАСТЬ МАРШРУТ
  int arrival = ui->spinBoxArrival->value( );
  int route = ui->spinBoxRoute->value( );
  // double ante = ui->labelAnte->text( ).toDouble( );

  //**** ЧАСТЬ ДОКУМЕНТЫ
  QString postPeriod = ui->comboBoxPostPeriad->currentText( );
  Qt::CheckState twoCopyCMR = ui->checkBox2CopyCMR->checkState( );
  Qt::CheckState originalContract = ui->checkBoxOriginalContract->checkState( );
  /*
  //***************************************************************************************************************************************************

  //  QSqlDatabase db = QSqlDatabase::database( ConveyanceConstats::NAME_DB_ALL );
  //  QSqlQuery query( db );
  //  QString qsToPayment = QString( "SELECT payment.getPayment_id(%1, '%2', '%3') AS idpayment;" ).arg( cost ).arg( paymentPeriod, currency );
  //  QString qsToRoute = QString( "SELECT route.getRouteId(%1, %2, %3) AS idroute;" ).arg( arrival ).arg( route ).arg( ante );
  //  QString qsDocuments =
  //      QString( "SELECT document.getDocumentId ('%1', %2, %3) AS iddocument;" ).arg( postPeriod ).arg( twoCopyCMR ).arg( originalContract );

  //  db.transaction( ); //ТРАНЗАКЦИЯ
  //  query.exec( qsToPayment );
  //  query.next( );
  //  int idPayment = query.value( "idpayment" ).toInt( );
  //  query.exec( qsToRoute );
  //  query.next( );
  //  int idRoute = query.value( "idroute" ).toInt( );
  //  query.exec( qsDocuments );
  //  query.next( );
  //  int idDocument = query.value( "iddocument" ).toInt( );
  //  QString qsInsertOrder = QString( "CALL orders.addOrder(%1, %2, %3, %4, %5, '%6', '%7', '%8');" )
  //			      .arg( idShipper )
  //			      .arg( idDriver )
  //			      .arg( idPayment )
  //			      .arg( idRoute )
  //			      .arg( idDocument )
  //			      .arg( data.toString( ), numberContract, text );
  //  if ( !query.exec( qsInsertOrder ) ) {
  //    qDebug( ) << query.lastError( ).text( );
  //    QMessageBox::warning( this, tr( "ОШИБКА" ), query.lastError( ).text( ) );
  //    db.rollback( ); //ОТМЕНИТЬ ТРАНЗАКЦИЮ
  //  } else {
  //    db.commit( ); //ПРИНЯТЬ ТРАНЗАКЦИЮ (функции получения id автоматически вставляют в базу, то есть эта транзакция частично вносит измемнения )
  //    // TODO тут возможно изменение поведения
  //    CommonOrderForm::accept( );
  //    // QDialog::accept( );
  //  }

  //***************************************************************************************************************************************************
  */
  QSqlQuery query( QSqlDatabase::database( ConveyanceConstats::NAME_DB_ALL ) );
  QString qs = QString( "CALL orders.addToOrder('%1', '%2', %3, %4, %5, '%6', '%7', %8, %9, '%10', %11, %12, '%13')" )
		   .arg( data.toString( "ddMMyyyy" ) )
		   .arg( numberContract )
		   .arg( idShipper )
		   .arg( idDriver )
		   .arg( cost )
		   .arg( paymentPeriod )
		   .arg( currency )
		   .arg( arrival )
		   .arg( route )
		   .arg( postPeriod )
		   .arg( twoCopyCMR )
		   .arg( originalContract )
		   .arg( text );
  if ( !query.exec( qs ) )
    qDebug( ) << query.lastError( ).text( );
}
