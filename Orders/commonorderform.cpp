#include "commonorderform.h"
#include "Emploee/adddriverdialog.h"
#include "Shippers/addshipperdialog.h"
#include "ui_commonorderform.h"

CommonOrderForm::CommonOrderForm( Regim regim, QWidget * parent ) : QDialog( parent ), ui( new Ui::CommonOrderForm ), r { regim } {
  ui->setupUi( this );
  if ( regim == Regim::UPD ) {
    ui->pushButtonAddDriver->setVisible( false );
    ui->pushButtonAddShipper->setVisible( false );
    ui->pushButtonCreateFrom->setVisible( false );
    ui->labelDopolnit->setVisible( false );
  }
  connects( );
}

CommonOrderForm::~CommonOrderForm( ) { delete ui; }

void CommonOrderForm::connects( ) {
  if ( r == Regim::ADD ) {
    connect( ui->pushButtonAddShipper, QOverload< bool >::of( &QPushButton::clicked ), this, QOverload<>::of( &CommonOrderForm::slotAddShipper ) );
    connect( ui->pushButtonAddDriver, QOverload< bool >::of( &QPushButton::clicked ), this, QOverload<>::of( &CommonOrderForm::slotAddDriver ) );
  }
}

void CommonOrderForm::slotAddShipper( ) {
  AddShipperDialog dialogAddShipper;
  if ( dialogAddShipper.exec( ) )
    ui->comboBoxShippers->init( );
}

void CommonOrderForm::slotAddDriver( ) {
  AddDriverDialog dd;
  if ( dd.exec( ) == QDialog::Accepted ) {
    ui->comboBoxDriver->init( );
  }
}

void CommonOrderForm::slotCostChanged( double cost ) {
  double arrival = ui->spinBoxArrival->value( );
  double route = ui->spinBoxRoute->value( );
  ui->labelAnte->setText( QString::number( ante( cost, arrival + route ), 'f', 2 ) );
}

void CommonOrderForm::slotArrivalChanged( int arrival ) {
  double cost = ui->doubleSpinBoxCost->value( );
  double route = ui->spinBoxRoute->value( );
  ui->labelAnte->setText( QString::number( ante( cost, arrival + route ), 'f', 2 ) );
}

void CommonOrderForm::slotRouteChanged( int route ) {
  double cost = ui->doubleSpinBoxCost->value( );
  double arrival = ui->spinBoxArrival->value( );
  ui->labelAnte->setText( QString::number( ante( cost, arrival + route ), 'f', 2 ) );
}

void CommonOrderForm::readRecord( const QSqlRecord & rec ) {
  ui->dateEdit->setDate( rec.value( "order_data" ).toDate( ) );
  ui->lineEditnumberContract->setText( rec.value( "order_contractnumber" ).toString( ) );
  ui->comboBoxShippers->setCurrentIndex( ui->comboBoxShippers->findText( rec.value( "shipper_name" ).toString( ) ) );
  ui->comboBoxDriver->setCurrentIndex( ui->comboBoxDriver->findText( rec.value( "emploee_name" ).toString( ) ) );
  ui->doubleSpinBoxCost->setValue( rec.value( "payment_cost" ).toDouble( ) );
  ui->comboBoxPaymentPeriod->setCurrentIndex( ui->comboBoxPaymentPeriod->findText( rec.value( "payment_period" ).toString( ) ) );
  ui->comboBoxCurrency->setCurrentIndex( ui->comboBoxCurrency->findText( rec.value( "payment_currency" ).toString( ) ) );
  ui->spinBoxArrival->setValue( rec.value( "route_arrival" ).toInt( ) );
  ui->spinBoxRoute->setValue( rec.value( "route_route" ).toInt( ) );
  ui->labelAnte->setText( QString::number( rec.value( "payment_cost" ).toDouble( ) /
                                               ( rec.value( "route_arrival" ).toInt( ) + rec.value( "route_route" ).toInt( ) ),
                                           'f', 2 ) );
  ui->comboBoxPostPeriad->setCurrentIndex( ui->comboBoxPostPeriad->findText( rec.value( "document_postperiod" ).toString( ) ) );
  ui->checkBox2CopyCMR->setCheckState( static_cast< Qt::CheckState >( rec.value( "document_2copycmr" ).toInt( ) ) );
  ui->checkBoxOriginalContract->setCheckState( static_cast< Qt::CheckState >( rec.value( "document_original" ).toInt( ) ) );
}

double CommonOrderForm::ante( double cost, int path ) { return cost / path; }
