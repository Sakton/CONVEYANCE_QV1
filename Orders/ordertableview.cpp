#include "ordertableview.h"
#include "Constants.h"
#include "ordersqlquerymodel.h"
#include "ui_ordertableview.h"

OrderTableView::OrderTableView( QWidget * parent ) : QWidget( parent ), ui( new Ui::OrderTableView ) {
  ui->setupUi( this );
  model = new OrderSqlQueryModel( this );
  initModel( );
  ui->tableViewOrder->setModel( model );
}

OrderTableView::~OrderTableView( ) { delete ui; }

void OrderTableView::initModel( ) {
  model->setQuery( "SELECT * FROM orders.ordersview;", QSqlDatabase::database( NAME_DB_ALL ) );
  model->setHeaderData( 0, Qt::Orientation::Horizontal, tr( "ДАТА" ) );
  model->setHeaderData( 1, Qt::Orientation::Horizontal, tr( "НОМЕР" ) );
  model->setHeaderData( 2, Qt::Orientation::Horizontal, tr( "ЗАКАЗЧИК" ) );
  model->setHeaderData( 3, Qt::Orientation::Horizontal, tr( "ЦЕНА" ) );
  model->setHeaderData( 4, Qt::Orientation::Horizontal, tr( "ВАЛЮТА" ) );
  model->setHeaderData( 5, Qt::Orientation::Horizontal, tr( "СРОК ОПЛАТЫ" ) );
  model->setHeaderData( 6, Qt::Orientation::Horizontal, tr( "ВОДИТЕЛЬ" ) );
  model->setHeaderData( 7, Qt::Orientation::Horizontal, tr( "СРОК ПОЧТЫ" ) );
}
