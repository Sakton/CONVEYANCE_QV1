#include "commomorderform.h"
#include "ui_commomorderform.h"

CommomOrderForm::CommomOrderForm( Regim regim, QWidget * parent ) : QDialog( parent ), ui( new Ui::CommomOrderForm ), r { regim } {
  ui->setupUi( this );
  if ( regim == Regim::UPD ) {
    ui->pushButtonAddDriver->setVisible( false );
    ui->pushButtonAddShipper->setVisible( false );
    ui->pushButtonCreateFrom->setVisible( false );
    ui->labelDopolnit->setVisible( false );
  }
}

CommomOrderForm::~CommomOrderForm( ) { delete ui; }
