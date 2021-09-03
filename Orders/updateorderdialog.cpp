#include "updateorderdialog.h"
#include "Constants.h"
#include "ui_commonorderform.h"
#include <QMessageBox>
#include <QSqlError>
#include <QSqlQuery>

UpdateOrderDialog::UpdateOrderDialog( const QSqlRecord & rec, QWidget * parent )
    : CommonOrderForm( CommonOrderForm::Regim::UPD, parent ), rec { rec } {
  setWindowTitle( "Правка ордера" );
  initForm( );
}

void UpdateOrderDialog::initForm( ) {
  ui->dateEdit->setDate( rec.value( "order_data" ).toDate( ) );
  ui->lineEditnumberContract->setText( rec.value( "order_contractnumber" ).toString( ) );
  ui->comboBoxShippers->setCurrentIndex( ui->comboBoxShippers->findText( rec.value( "shipper_name" ).toString( ) ) );
  ui->comboBoxDriver->setCurrentIndex( ui->comboBoxDriver->findText( rec.value( "emploee_name" ).toString( ) ) );
  ui->doubleSpinBoxCost->setValue( rec.value( "payment_cost" ).toDouble( ) );
  ui->comboBoxPaymentPeriod->setCurrentIndex( ui->comboBoxPaymentPeriod->findText( rec.value( "payment_period" ).toString( ) ) );
  ui->comboBoxCurrency->setCurrentIndex( ui->comboBoxCurrency->findText( rec.value( "payment_currency" ).toString( ) ) );
  ui->spinBoxArrival->setValue( rec.value( "route_arrival" ).toInt( ) );
  ui->spinBoxRoute->setValue( rec.value( "route_route" ).toInt( ) );
  ui->labelAnte->setText( QString::number(
      rec.value( "payment_cost" ).toDouble( ) / ( rec.value( "route_arrival" ).toInt( ) + rec.value( "route_route" ).toInt( ) ), 'f', 2 ) );
  ui->comboBoxPostPeriad->setCurrentIndex( ui->comboBoxPostPeriad->findText( rec.value( "document_postperiod" ).toString( ) ) );
  ui->checkBox2CopyCMR->setCheckState( static_cast< Qt::CheckState >( rec.value( "document_2copycmr" ).toInt( ) ) );
  ui->checkBoxOriginalContract->setCheckState( static_cast< Qt::CheckState >( rec.value( "document_original" ).toInt( ) ) );
}

// TODO почти одинаковые методы с void CreateOrderDialog::accept( ) вынести в базовый класс

void UpdateOrderDialog::accept( ) {
  //**** ЧАСТЬ ОРДЕР
  QDate data = ui->dateEdit->date( );				// ДАТА
  QString numberContract = ui->lineEditnumberContract->text( ); // НОМЕР ДОГОВРА
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

  //**** ЧАСТЬ ДОКУМЕНТЫ
  QString postPeriod = ui->comboBoxPostPeriad->currentText( );
  Qt::CheckState twoCopyCMR = ui->checkBox2CopyCMR->checkState( );
  // qDebug() << "twoCopyCMR" <<
  Qt::CheckState originalContract = ui->checkBoxOriginalContract->checkState( );

  QSqlQuery query( QSqlDatabase::database( ConveyanceConstats::NAME_DB_ALL ) );
  QString qs = QString( "CALL orders.updateOrder(%1, '%2', '%3', %4, %5, %6, '%7', '%8', %9, %10, '%11', %12, %13, '%14')" )
		   .arg( rec.value( "order_id" ).toInt( ) )
		   .arg( data.toString( ) )
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
  if ( !query.exec( qs ) ) {
    qDebug( ) << query.lastError( ).text( );
  } else {
    QDialog::accept( );
  }
}
