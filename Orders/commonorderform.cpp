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
  connect( ui->doubleSpinBoxCost, QOverload< double >::of( &QDoubleSpinBox::valueChanged ), this,
	   QOverload< double >::of( &CommonOrderForm::slotCostChanged ) );
  connect( ui->spinBoxArrival, QOverload< int >::of( &QSpinBox::valueChanged ), this, QOverload< int >::of( &CommonOrderForm::slotArrivalChanged ) );
  connect( ui->spinBoxRoute, QOverload< int >::of( &QSpinBox::valueChanged ), this, QOverload< int >::of( &CommonOrderForm::slotRouteChanged ) );
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

double CommonOrderForm::ante( double cost, int path ) { return cost / path; }
