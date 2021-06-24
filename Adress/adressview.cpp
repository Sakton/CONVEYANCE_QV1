#include "adressview.h"
#include "Constants.h"
#include "ElementsWidgets/adresscountrydelegate.h"
#include "ui_adressview.h"
#include <QSqlTableModel>

AdressView::AdressView(QWidget *parent) :
      QWidget(parent),
      ui(new Ui::AdressView)
{
  ui->setupUi( this );
  createModel( );
  AdressCountryDelegate *d = new AdressCountryDelegate;
  ui->tableView->setModel( model );
  ui->tableView->setItemDelegate( d );
  ui->tableView->setColumnHidden( 0, true );
  ui->tableView->setColumnHidden( 1, true );
}

AdressView::~AdressView()
{
  delete ui;
}

void AdressView::createModel( ) {
  model = new QSqlTableModel( this, QSqlDatabase::database( NAME_DB_ALL ) );
  model->setTable( "adress_view" );
  model->setHeaderData( 2, Qt::Orientation::Horizontal, tr( "СТРАНА" ) );
  model->setHeaderData( 3, Qt::Orientation::Horizontal, tr( "ИНДЕКС" ) );
  model->setHeaderData( 4, Qt::Orientation::Horizontal, tr( "ГОРОД" ) );
  model->setHeaderData( 5, Qt::Orientation::Horizontal, tr( "АДРЕС" ) );
  model->select( );
}
