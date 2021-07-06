#include "updatecitydialog.h"
#include "Constants.h"
#include "ui_updatecitydialog.h"

#include <QSqlError>
#include <QSqlQuery>
#include <QSqlRecord>

UpdateCityDialog::UpdateCityDialog( const QString &cityName, QWidget *parent )
    : QDialog( parent ), ui( new Ui::UpdateCityDialog ), curCity { cityName } {
  ui->setupUi(this);
  setWindowTitle( tr( "ОБНОВИТЬ ГОРОД" ) );
  ui->lineEditCity->setText( cityName );
}

UpdateCityDialog::~UpdateCityDialog( ) {
  delete ui;
}

void UpdateCityDialog::accept( ) {
  qDebug( ) << "ACCEPT";
  QString city = ui->lineEditCity->text( ).simplified( );
  QSqlQuery query( QSqlDatabase::database( NAME_DB_ALL ) );
  QString qs = QString( "UPDATE cities SET city_name = '%1' WHERE city_name = '%2';" ).arg( city ).arg( curCity );
  if ( !query.exec( qs ) ) {
    qDebug( ) << "ERROR: " << query.lastError( ).text( );
  }
  QDialog::accept( );
}
