#include "semitrailersview---.h"
#include "ui_semitrailersview.h"

SemitrailersView::SemitrailersView( QWidget * parent ) : QWidget( parent ), ui( new Ui::SemitrailersView ) {
  ui->setupUi( this );
  slotCurrentIndexChanged( );
}

SemitrailersView::~SemitrailersView( ) { delete ui; }

int SemitrailersView::currentId( ) const { return ui->comboBoxSemitrailerName->currentData( SemitrailerRole::ID ).toInt( ); }

void SemitrailersView::slotCurrentIndexChanged( ) {
  ui->labelCarrying->setText( ui->comboBoxSemitrailerName->currentData( SemitrailerRole::CARRYING ).toString( ) + " М3." );
  ui->labelDescription->setText( ui->comboBoxSemitrailerName->currentData( SemitrailerRole::DESCRIPTION ).toString( ) );
  ui->labelHeight->setText( ui->comboBoxSemitrailerName->currentData( SemitrailerRole::HEIGHT ).toString( ) + " М." );
  ui->labelLenth->setText( ui->comboBoxSemitrailerName->currentData( SemitrailerRole::LENTH ).toString( ) + " М." );
  ui->labelWidth->setText( ui->comboBoxSemitrailerName->currentData( SemitrailerRole::WIDTH ).toString( ) + " М." );
  ui->labelimg->setPixmap( ":/img/Eurofura/" + ui->comboBoxSemitrailerName->currentData( SemitrailerRole::IMG ).toString( ) );
}
