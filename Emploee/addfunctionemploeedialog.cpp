#include "addfunctionemploeedialog.h"
#include "Constants.h"
#include "ui_addfunctionemploeedialog.h"

#include <QMessageBox>
#include <QSqlError>
#include <QSqlQuery>

AddFunctionEmploeeDialog::AddFunctionEmploeeDialog( QWidget * parent ) : QDialog( parent ), ui( new Ui::AddFunctionEmploeeDialog ) {
  ui->setupUi( this );
}

AddFunctionEmploeeDialog::~AddFunctionEmploeeDialog( ) { delete ui; }

void AddFunctionEmploeeDialog::accept( ) {
  QString nameFunctions = ui->lineEditFunctionEmploee->text( );
  if ( nameFunctions.isEmpty( ) ) {
    QMessageBox::warning( this, tr( "ПУСТОЕ ПОЛЕ" ), tr( "ПОЛЕ НЕ МОЖЕТ БЫТЬ ПУСТЫМ" ) );
    return;
  }
  QString qs = QString { "INSERT INTO emploee.functionworker ( functionWorker_name ) VALUES ('%1') " }.arg( nameFunctions );
  qDebug( ) << qs;
  QSqlQuery query( QSqlDatabase::database( NAME_DB_ALL ) );
  if ( !query.exec( qs ) )
    qDebug( ) << query.lastError( ).text( );
  QDialog::accept( );
}
