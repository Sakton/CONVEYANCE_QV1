#include "updatecitydialog.h"
#include "Constants.h"
#include "ui_updatecitydialog.h"

#include <QSqlError>
#include <QSqlQuery>
#include <QSqlRecord>

UpdateCityDialog::UpdateCityDialog( int idSity, QWidget *parent ) : QDialog( parent ), ui( new Ui::UpdateCityDialog ), curId { idSity } {
  ui->setupUi(this);
  QString qs = QString( "SELECT street_name FROM streets WHERE street_id = %1" ).arg( curId );
  QSqlQuery query( QSqlDatabase::database( NAME_DB_ALL ) );
  if ( !query.exec( ) )
    qDebug( ) << "ERROR QUERY: " << query.lastError( ).text( );
  else {
    query.next( );
    QSqlRecord rec;
    ui->lineEditCity->setText( rec.value( "street_name" ).toString( ) );
  }
}

UpdateCityDialog::~UpdateCityDialog()
{
  delete ui;
}

void UpdateCityDialog::accept( ) {
  QString city = ui->lineEditCity->text( ).simplified( );
  QSqlQuery query( QSqlDatabase::database( NAME_DB_ALL ) );
  QString qs = QString( "UPDATE streets SET street_name = '%1' WHERE street_id = %2" ).arg( city ).arg( curId );
  query.exec( qs );
  QDialog::accept( );
}
