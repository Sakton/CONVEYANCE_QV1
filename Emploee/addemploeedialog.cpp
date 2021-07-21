#include "addemploeedialog.h"
#include "Constants.h"
#include "addfunctionemploeedialog.h"
#include "ui_addemploeedialog.h"

#include <QMessageBox>
#include <QSqlError>
#include <QSqlQuery>

AddEmploeeDialog::AddEmploeeDialog( QWidget * parent ) : QDialog( parent ), ui( new Ui::AddEmploeeDialog ) {
  ui->setupUi( this );
  connects( );
}

AddEmploeeDialog::~AddEmploeeDialog( ) { delete ui; }

void AddEmploeeDialog::accept( ) {
  QString name = ui->lineEditName->text( );
  if ( name.isEmpty( ) ) {
    QMessageBox::warning( this, tr( "ПУСТОЕ ПОЛЕ" ), tr( "ПОЛЕ ИМЯ ПУСТО" ) );
    return;
  }
  int idFunc = ui->comboBoxFunctionWork->currentData( ).toInt( );
  int idDriveLic = ui->comboBoxDriveLicense->currentData( ).toInt( );
  QString qs = QString { "CALL emploee.addemploee (%1, %2, '%3');" }.arg( idFunc ).arg( idDriveLic ).arg( name );
  QSqlQuery query { QSqlDatabase::database( NAME_DB_ALL ) };
  if ( !query.exec( qs ) )
    qDebug( ) << query.lastError( ).text( );
  QDialog::accept( );
}

void AddEmploeeDialog::slotCallAddFunctionWorkDialog( ) {
  AddFunctionEmploeeDialog addFun;
  if ( addFun.exec( ) )
    ui->comboBoxFunctionWork->reCreate( );
}

void AddEmploeeDialog::connects( ) const {
  connect( ui->pushButtonAddFunction, QOverload< bool >::of( &QPushButton::clicked ), this,
	   QOverload<>::of( &AddEmploeeDialog::slotCallAddFunctionWorkDialog ) );
}
