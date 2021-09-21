#include "semitrailersview.h"
#include "ui_semitrailersview.h"

SemitrailersView::SemitrailersView( QWidget * parent ) : QWidget( parent ), ui( new Ui::SemitrailersView ) { ui->setupUi( this ); }

SemitrailersView::~SemitrailersView( ) { delete ui; }

void SemitrailersView::slotCurrentIndexChanged( ) {
  qDebug( ) << ui->comboBoxSemitrailerName->currentData( SemitrailerRole::ID );
  qDebug( ) << ui->comboBoxSemitrailerName->currentData( SemitrailerRole::CARRYING );
  qDebug( ) << ui->comboBoxSemitrailerName->currentData( SemitrailerRole::HEIGHT );
  qDebug( ) << ui->comboBoxSemitrailerName->currentData( SemitrailerRole::LENTH );
  qDebug( ) << ui->comboBoxSemitrailerName->currentData( SemitrailerRole::WIDTH );
  qDebug( ) << ui->comboBoxSemitrailerName->currentData( SemitrailerRole::HEIGHT );
  qDebug( ) << ui->comboBoxSemitrailerName->currentData( SemitrailerRole::DESCRIPTION );

  ui->labelCarrying->setText( ui->comboBoxSemitrailerName->currentData( SemitrailerRole::CARRYING ).toString( ) );
  ui->labelDescription->setText( ui->comboBoxSemitrailerName->currentData( SemitrailerRole::DESCRIPTION ).toString( ) );
  ui->labelHeight->setText( ui->comboBoxSemitrailerName->currentData( SemitrailerRole::HEIGHT ).toString( ) );
  ui->labelLenth->setText( ui->comboBoxSemitrailerName->currentData( SemitrailerRole::LENTH ).toString( ) );
  ui->labelWidth->setText( ui->comboBoxSemitrailerName->currentData( SemitrailerRole::WIDTH ).toString( ) );
  // ui->labelimg->setText( ui->comboBoxSemitrailerName->currentData( SemitrailerRole::IMG ).toString( ) );
  ui->labelimg->setPixmap( ":/img/Eurofura/" + ui->comboBoxSemitrailerName->currentData( SemitrailerRole::IMG ).toString( ) );
}
