#include "updateadressdialog.h"
#include "Constants.h"
#include "ui_updateadressdialog.h"

#include <QMessageBox>
#include <QSqlQuery>
#include <QSqlRecord>

UpdateAdressDialog::UpdateAdressDialog( int id, QSqlTableModel *m, QWidget *parent )
    : QDialog( parent ), ui( new Ui::UpdateAdressDialog ), model { m }, curId { id } {
  ui->setupUi(this);
  init( );
}

UpdateAdressDialog::~UpdateAdressDialog( ) {
  delete ui;
}

void UpdateAdressDialog::init( ) {
  QSqlQuery query( QSqlDatabase::database( NAME_DB_ALL ) );
  QString qs = QString { "SELECT * FROM adress_view WHERE adres_id = %1;" }.arg( curId );
  if ( !query.exec( qs ) ) {
    qDebug( ) << "ERROR QUERY ON UNIT UPDATE FORM ADRESS";
  }
  query.next( );
  QSqlRecord rec = query.record( );
  ui->comboBoxCountry->setCurrentIndex( ui->comboBoxCountry->findText( rec.value( "country_name" ).toString( ) ) );
  ui->comboBoxCity->updateCity( ui->comboBoxCountry->currentData( ).toInt( ) );
  ui->comboBoxCity->setCurrentIndex( ui->comboBoxCity->findText( rec.value( "city_name" ).toString( ) ) );
  ui->lineEditAdress->setText( rec.value( "street_name" ).toString( ) );
  ui->lineEditIndex->setText( rec.value( "adres_index" ).toString( ) );
  // ui->comboBoxType->setCurrentIndex( ui->comboBoxType->find( rec.value("") ) );
}
