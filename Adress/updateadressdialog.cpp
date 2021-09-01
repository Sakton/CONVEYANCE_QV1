#include "updateadressdialog.h"
#include "Constants.h"
#include "ui_updateadressdialog.h"
#include "updatecitydialog.h"

#include <QMessageBox>
#include <QSqlError>
#include <QSqlQuery>
#include <QSqlRecord>

UpdateAdressDialog::UpdateAdressDialog( int id, QSqlQueryModel *m, QWidget *parent )
    : QDialog( parent ), ui( new Ui::UpdateAdressDialog ), model { m }, curId { id } {
  ui->setupUi( this );
  setWindowTitle( tr( "ОБНОВИТЬ" ) );
  init( );
  connect( ui->pushButtonEditCity, QOverload< bool >::of( &QPushButton::clicked ), this, QOverload<>::of( &UpdateAdressDialog::slotEditCity ) );
}

UpdateAdressDialog::~UpdateAdressDialog( ) {
  delete ui;
}

void UpdateAdressDialog::accept( ) {
  QString country = ui->comboBoxCountry->currentText( );
  QString city = ui->comboBoxCity->currentText( );
  QString street = ui->lineEditAdress->text( ).simplified( );
  QString index = ui->lineEditIndex->text( ).simplified( );
  QString type = ui->comboBoxType->currentText( );

  QString qs = QString( "CALL update_adress (%1, '%2', '%3', '%4', '%5', '%6');" )
                   .arg( curId )
                   .arg( country )
                   .arg( city )
                   .arg( street )
                   .arg( index )
                   .arg( type );

  QSqlQuery query( QSqlDatabase::database( ConveyanceConstats::NAME_DB_ALL ) );
  if ( !query.exec( qs ) ) {
    qDebug( ) << query.lastError( ).text( );
  }
  QDialog::accept( );
}

void UpdateAdressDialog::slotEditCity( ) {
  UpdateCityDialog dialog( ui->comboBoxCity->currentText( ), this );
  if ( dialog.exec( ) )
    init( );
}

void UpdateAdressDialog::init( ) {
  QSqlQuery query( QSqlDatabase::database( ConveyanceConstats::NAME_DB_ALL ) );
  QString qs = QString { "SELECT * FROM adress_view WHERE adres_id = %1;" }.arg( curId );
  if ( !query.exec( qs ) ) {
    qDebug( ) << "ERROR QUERY ON UNIT UPDATE FORM ADRESS";
  }
  query.next( ); //курсор после запроса стоит перед 1 строкой, поэтому его надо 1 раз сдвинуть
  QSqlRecord rec = query.record( );
  ui->comboBoxCountry->setCurrentIndex( ui->comboBoxCountry->findText( rec.value( "country_name" ).toString( ) ) );
  ui->comboBoxCity->updateCity( ui->comboBoxCountry->currentData( ).toInt( ) );
  ui->comboBoxCity->setCurrentIndex( ui->comboBoxCity->findText( rec.value( "city_name" ).toString( ) ) );
  ui->lineEditAdress->setText( rec.value( "street_name" ).toString( ) );
  ui->lineEditIndex->setText( rec.value( "adres_index" ).toString( ) );
  ( rec.value( "adres_type" ).toString( ) == QString { tr( "Фактический" ) } ) ? ui->comboBoxType->setCurrentIndex( 0 )
                                                                               : ui->comboBoxType->setCurrentIndex( 1 );
}
