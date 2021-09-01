#include "updateorderdialog.h"
#include "ui_commonorderform.h"

UpdateOrderDialog::UpdateOrderDialog( const QSqlRecord & rec, QWidget * parent )
    : CommonOrderForm( CommonOrderForm::Regim::UPD, parent ), rec { rec } {
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
  // ui->spinBoxArrival->setValue( rec.value("") );
  // TODO тут
}
