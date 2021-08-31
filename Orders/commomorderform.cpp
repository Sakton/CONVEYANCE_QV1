#include "commomorderform.h"
#include "Emploee/adddriverdialog.h"
#include "Shippers/addshipperdialog.h"
#include "ui_commomorderform.h"

CommomOrderForm::CommomOrderForm( Regim regim, QWidget * parent ) : QDialog( parent ), ui( new Ui::CommomOrderForm ), r { regim } {
  ui->setupUi( this );
  if ( regim == Regim::UPD ) {
    ui->pushButtonAddDriver->setVisible( false );
    ui->pushButtonAddShipper->setVisible( false );
    ui->pushButtonCreateFrom->setVisible( false );
    ui->labelDopolnit->setVisible( false );
  }
  if ( regim == Regim::ADD ) {
    connects( );
  }
}

CommomOrderForm::~CommomOrderForm( ) { delete ui; }

void CommomOrderForm::connects( ) {
  connect( ui->pushButtonAddShipper, QOverload< bool >::of( &QPushButton::clicked ), this, QOverload<>::of( &CommomOrderForm::slotAddShipper ) );
  connect( ui->pushButtonAddDriver, QOverload< bool >::of( &QPushButton::clicked ), this, QOverload<>::of( &CommomOrderForm::slotAddDriver ) );
  connect( ui->doubleSpinBoxCost, QOverload< double >::of( &QDoubleSpinBox::valueChanged ), this,
	   QOverload< double >::of( &CommomOrderForm::slotCostChanged ) );
  connect( ui->spinBoxArrival, QOverload< int >::of( &QSpinBox::valueChanged ), this, QOverload< int >::of( &CommomOrderForm::slotArrivalChanged ) );
  connect( ui->spinBoxRoute, QOverload< int >::of( &QSpinBox::valueChanged ), this, QOverload< int >::of( &CommomOrderForm::slotRouteChanged ) );
}

void CommomOrderForm::slotAddShipper( ) {
  AddShipperDialog dialogAddShipper;
  if ( dialogAddShipper.exec( ) )
    ui->comboBoxShippers->init( );
}

void CommomOrderForm::slotAddDriver( ) {
  AddDriverDialog dd;
  if ( dd.exec( ) == QDialog::Accepted ) {
    ui->comboBoxDriver->init( );
  }
}

void CommomOrderForm::slotCostChanged( double cost ) {

  double arrival = ui->spinBoxArrival->value( );
  double route = ui->spinBoxRoute->value( );
  ui->labelAnte->setText( QString::number( ante( cost, arrival + route ), 'f', 2 ) );
}

void CommomOrderForm::slotArrivalChanged( int arrival ) {
  double cost = ui->doubleSpinBoxCost->value( );
  double route = ui->spinBoxRoute->value( );
  ui->labelAnte->setText( QString::number( ante( cost, arrival + route ), 'f', 2 ) );
}

void CommomOrderForm::slotRouteChanged( int route ) {
  double cost = ui->doubleSpinBoxCost->value( );
  double arrival = ui->spinBoxArrival->value( );
  ui->labelAnte->setText( QString::number( ante( cost, arrival + route ), 'f', 2 ) );
}

double CommomOrderForm::ante( double cost, int path ) { return cost / path; }
