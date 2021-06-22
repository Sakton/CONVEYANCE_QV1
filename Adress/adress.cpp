#include "adress.h"
#include "ui_adress.h"

#include <QSqlDatabase>
#include <QSqlTableModel>

Adress::Adress( QWidget *parent ) : QWidget( parent ), ui( new Ui::Adress ) {
  ui->setupUi( this );
  createTableAdressModel( );
  ui->tableView->setModel( model );
}

Adress::~Adress()
{
  delete ui;
}

void Adress::createTableAdressModel( ) {
  QSqlDatabase db = QSqlDatabase::cloneDatabase( QSqlDatabase::database( "DB" ), "ADRESS" );
  bool ok = db.open( );
  qDebug( ) << "db ADRESS ok = " << ok;
  model = new QSqlTableModel( this, db );
  model->setTable( "countrys" );
  model->setEditStrategy( QSqlTableModel::OnManualSubmit );
  model->setHeaderData( 0, Qt::Horizontal, tr( "0" ) );
  model->setHeaderData( 1, Qt::Horizontal, tr( "1" ) );
  model->setHeaderData( 2, Qt::Horizontal, tr( "2" ) );
  model->setHeaderData( 3, Qt::Horizontal, tr( "3" ) );
  if ( !model->select( ) )
    qDebug( ) << "select NO";
}

void Adress::connecteds( ) {
}
