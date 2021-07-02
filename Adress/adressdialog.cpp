#include "adressdialog.h"
#include "Constants.h"
#include "citydialog.h"
#include "comboboxtypeadress.h"
#include "ui_adressdialog.h"

#include <QMessageBox>
#include <QSqlQuery>
#include <QSqlRecord>
#include <QSqlTableModel>

AdressDialog::AdressDialog( QSqlTableModel * model, QWidget * parent )
    : QDialog( parent ), ui( new Ui::AdressDialog ), model { model } {
  ui->setupUi( this );
  ui->comboBoxType->addItems( QStringList( ) << tr( "Фактический" ) << tr( "Юридический" ) );
  ui->comboBoxCity->updateCity( ui->comboBoxCountry->currentData( ).toInt( ) );
  connect( ui->pushButtonAddCity, QOverload< bool >::of( &QPushButton::clicked ), this,
           QOverload<>::of( &AdressDialog::slotAddCity ) );
  connect( ui->comboBoxCountry, QOverload< int >::of( &QComboBox::currentIndexChanged ), this,
           QOverload< int >::of( &AdressDialog::slotCountryIndexChanged ) );
  setRegimWindowTitle( );
}

AdressDialog::~AdressDialog( ) {
  delete ui;
}

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

void AdressDialog::accept( ) {
  addRecord( );
  QDialog::accept( );
}

void AdressDialog::reject( ) {
  QDialog::reject( );
}

void AdressDialog::addRecord( ) {
  readForm( );
  QSqlQuery query( QSqlDatabase::database( NAME_DB_ALL ) );
  QString qs = QString { "SELECT insertOrIgnoreStreet('%3'); SELECT insert_adress('%1', '%2', '%3', '%4', '%5');" }
                   .arg( poles.at( 0 ) )
                   .arg( poles.at( 1 ) )
                   .arg( poles.at( 2 ) )
                   .arg( poles.at( 3 ) )
                   .arg( castAdres( poles.at( 4 ) ) );
  if ( !query.exec( qs ) )
    QMessageBox::warning( this, "ERROR", "Error add adress", QMessageBox::StandardButton::Ok );
  else
    emit signalUpdateTableToDb( );
}

void AdressDialog::updateRecord( ) {
  readForm( );
}

void AdressDialog::readForm( ) {
  poles.clear( );
  poles << ui->comboBoxCountry->currentText( ) << ui->comboBoxCity->currentText( ) << ui->lineEditAdress->text( ).simplified( )
        << ui->lineEditIndex->text( ).simplified( ) << ui->comboBoxType->currentText( );
}

void AdressDialog::setRegimWindowTitle( ) {
  setWindowTitle( tr( "ДОБАВИТЬ АДРЕС" ) );
}

QString AdressDialog::castAdres( const QString &tAdr ) {
  if ( tAdr == tr( "Фактический" ) )
    return "FACT";
  return "LEGAL";
}
