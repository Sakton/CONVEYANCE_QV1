#include "updateorderdialog.h"
#include "Constants.h"
#include "ui_commonorderform.h"
#include <QMessageBox>
#include <QSqlError>
#include <QSqlQuery>

UpdateOrderDialog::UpdateOrderDialog( const QSqlRecord & rec, QWidget * parent )
    : CommonOrderForm( CommonOrderForm::Regim::UPD, parent ), rec { rec } {
  setWindowTitle( "Правка ордера" );
  readRecord( rec );
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
