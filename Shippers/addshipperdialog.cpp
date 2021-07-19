#include "addshipperdialog.h"
#include "Constants.h"
#include "ui_addishipperdialog.h"

#include <QSqlError>
#include <QSqlQuery>

AddiShipperDialog::AddiShipperDialog( QWidget * parent ) : QDialog( parent ), ui( new Ui::AddiShipperDialog ) { ui->setupUi( this ); }

AddiShipperDialog::~AddiShipperDialog( ) { delete ui; }

void AddiShipperDialog::accept( ) {
  QString name = ui->lineEditName->text( );
  if ( name.isEmpty( ) )
    return;
  QSqlQuery query( QSqlDatabase::database( NAME_DB_ALL ) );
  QString qs = QString { "CALL shipper.addShipper( '%1' )" }.arg( name );
  if ( !query.exec( qs ) )
    qDebug( ) << query.lastError( ).text( );
  QDialog::accept( );
}
