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
  qDebug( ) << "query.record( ).value(  adres_id ) = " << query.record( ).value( "adres_id" ).toInt( );
  // qDebug( ) << ui->comboBoxCity->findData( query.record( ).value( "adres_id" ) );
  // ui->comboBoxCountry->setCurrentIndex( ui->comboBoxCity->findData( query.record( ).value( "adres_id" ) ) );
}
