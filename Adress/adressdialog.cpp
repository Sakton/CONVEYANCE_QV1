#include "adressdialog.h"
#include "citydialog.h"
#include "ui_adressdialog.h"

AdressDialog::AdressDialog( QSqlTableModel * tView, QWidget * parent )
    : QDialog( parent ), ui( new Ui::AdressDialog ), tVw { tView } {
  ui->setupUi( this );
  ui->comboBoxCity->updateCity( ui->comboBoxCountry->currentData( ).toInt( ) );
  connect( ui->pushButtonAddCity, QOverload< bool >::of( &QPushButton::clicked ), this,
           QOverload<>::of( &AdressDialog::slotAddCity ) );
  connect( ui->comboBoxCountry, QOverload< int >::of( &QComboBox::currentIndexChanged ), this,
           QOverload< int >::of( &AdressDialog::slotCountryIndexChanged ) );
}

AdressDialog::~AdressDialog( ) { delete ui; }

void AdressDialog::slotAddCity( ) {
  CityDialog cityDialog( ui->comboBoxCountry->currentIndex( ) );
  connect( &cityDialog, QOverload< int >::of( &CityDialog::signalChangedIndex ), ui->comboBoxCity,
           QOverload< int >::of( &ComboBoxCity::updateCity ) );
  cityDialog.exec( );
}

void AdressDialog::slotSetCountry( const QString & countryName ) {
  ui->comboBoxCountry->setCurrentIndex( ui->comboBoxCountry->findText( countryName ) );
  ui->comboBoxCity->updateCity( ui->comboBoxCountry->currentData( ).toInt( ) );
}

void AdressDialog::slotCountryIndexChanged( int idx ) {
  ui->comboBoxCity->updateCity( ui->comboBoxCountry->itemData( idx ).toInt( ) );
}
