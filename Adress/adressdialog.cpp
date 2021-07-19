#include "adressdialog.h"
#include "Constants.h"
#include "citydialog.h"
#include "comboboxtypeadress.h"
#include "ui_adressdialog.h"

#include <QMessageBox>
#include <QSqlError>
#include <QSqlQuery>
#include <QSqlRecord>
#include <QSqlTableModel>

AdressDialog::AdressDialog( QWidget * parent ) : QDialog( parent ), ui( new Ui::AdressDialog ) /*, model { model }*/ {
  ui->setupUi( this );
  ui->comboBoxCity->updateCity( ui->comboBoxCountry->currentData( ).toInt( ) );
  connect( ui->pushButtonAddCity, QOverload< bool >::of( &QPushButton::clicked ), this,
           QOverload<>::of( &AdressDialog::slotAddCity ) );
  connect( ui->comboBoxCountry, QOverload< int >::of( &QComboBox::currentIndexChanged ), this,
           QOverload< int >::of( &AdressDialog::slotCountryIndexChanged ) );
  setWindowTitle( tr( "ДОБАВИТЬ АДРЕС" ) );
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
  QString country = ui->comboBoxCountry->currentText( );
  QString city = ui->comboBoxCity->currentText( );
  QString adress = ui->lineEditAdress->text( ).simplified( );
  QString index = ui->lineEditIndex->text( ).simplified( );
  QString type = ui->comboBoxType->currentText( );

  QSqlQuery query( QSqlDatabase::database( NAME_DB_ALL ) );
  QString qs = QString { "CALL adres.insertAdress('%1', '%2', '%3', '%4');" }.arg( city, adress, index, type );
  qDebug( ) << qs;
  if ( !query.exec( qs ) )
    QMessageBox::warning( this, "ERROR", "Error add adress: " + query.lastError( ).text( ), QMessageBox::StandardButton::Ok );
  qDebug( ) << query.lastQuery( );
}
