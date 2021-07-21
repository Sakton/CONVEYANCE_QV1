#include "addshipperdialog.h"
#include "Constants.h"
#include "ui_addshipperdialog.h"

#include <QMessageBox>
#include <QSqlError>
#include <QSqlQuery>

AddShipperDialog::AddShipperDialog( QWidget * parent ) : QDialog( parent ), ui( new Ui::AddShipperDialog ) {
  ui->setupUi( this );
}

AddShipperDialog::~AddShipperDialog( ) { delete ui; }

void AddShipperDialog::accept( ) {
  QString name = ui->lineEditName->text( );
  if ( name.isEmpty( ) ) {
    QMessageBox::warning( this, tr( "ПУСТОЕ ПОЛЕ" ), tr( "ПОЛЕ МЕ МОЖЕТ БЫТЬ ПУСТЫМ" ) );
    return;
  }
  QSqlQuery query( QSqlDatabase::database( NAME_DB_ALL ) );
  QString qs = QString { "CALL shipper.addShipper( '%1' )" }.arg( name );
  if ( !query.exec( qs ) )
    qDebug( ) << query.lastError( ).text( );
  QDialog::accept( );
}
