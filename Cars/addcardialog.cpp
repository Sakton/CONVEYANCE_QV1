#include "addcardialog.h"
#include "Constants.h"
#include "ui_addcardialog.h"
#include <QSqlError>
#include <QSqlQuery>

AddCarDialog::AddCarDialog( QWidget * parent ) : QDialog( parent ), ui( new Ui::AddCarDialog ) { ui->setupUi( this ); }

AddCarDialog::~AddCarDialog( ) { delete ui; }

void AddCarDialog::accept( ) {
  QString name = ui->lineEditName->text( );
  QString vin = ui->lineEditVin->text( );
  double lenth = ui->doubleSpinBoxLenth->value( );
  double width = ui->doubleSpinBoxWidth->value( );
  double height = ui->doubleSpinBoxHeight->value( );
  QDate dWork = ui->dateEditWork->date( );
  QDate dGto = ui->dateEditGto->date( );

  QSqlQuery query( QSqlDatabase::database( ConveyanceConstats::NAME_DB_ALL ) );
	query.prepare(
			"INSERT INTO cars.tempauto ( tempauto_name, tempauto_vin, tempauto_lenth, tempauto_width, tempauto_height, tempauto_datework, tempauto_dategto ) "
			"VALUES ( :name, :vin, :len, :width, :height, :dwork, :dgto );" );
	query.bindValue( ":name", name );
	query.bindValue( ":vin", vin );
	query.bindValue( ":len", lenth );
	query.bindValue( ":width", width );
	query.bindValue( ":height", height );
	query.bindValue( ":dwork", dWork );
	query.bindValue( ":dgto", dGto );
	if ( !query.exec( ) )
		qDebug( ) << query.lastError( ).text( );

  QDialog::accept( );
}
