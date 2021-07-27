#include "orderwidget.h"
#include "Constants.h"
#include "createorderdialog.h"
#include "ordersqlquerymodel.h"
#include "ui_ordertableview.h"

#include <QSortFilterProxyModel>

OrderWidget::OrderWidget( QWidget * parent ) : QWidget( parent ), ui( new Ui::OrderWidget ) {
  ui->setupUi( this );
  model = new OrderSqlQueryModel( this );
  initModel( );
  proxy = new QSortFilterProxyModel( this );
  proxy->setSourceModel( model );
  ui->tableViewOrder->setModel( proxy );
  connects( );
}

OrderWidget::~OrderWidget( ) { delete ui; }

void OrderWidget::slotAddOrder( ) {
  CreateOrderDialog addorder( this );
  if ( addorder.exec( ) )
    refresh( );
}

void OrderWidget::initModel( ) {
  model->setQuery( "SELECT * FROM orders.ordersview;", QSqlDatabase::database( NAME_DB_ALL ) );
  model->setHeaderData( 0, Qt::Orientation::Horizontal, tr( "ДАТА" ) );
  model->setHeaderData( 1, Qt::Orientation::Horizontal, tr( "НОМЕР" ) );
  model->setHeaderData( 2, Qt::Orientation::Horizontal, tr( "ЗАКАЗЧИК" ) );
  model->setHeaderData( 3, Qt::Orientation::Horizontal, tr( "ЦЕНА" ) );
  model->setHeaderData( 4, Qt::Orientation::Horizontal, tr( "ВАЛЮТА" ) );
  model->setHeaderData( 5, Qt::Orientation::Horizontal, tr( "СРОК ОПЛАТЫ" ) );
  model->setHeaderData( 6, Qt::Orientation::Horizontal, tr( "ВОДИТЕЛЬ" ) );
  model->setHeaderData( 7, Qt::Orientation::Horizontal, tr( "СРОК ПОЧТЫ" ) );
  ui->tableViewOrder->horizontalHeader( )->resizeSections( QHeaderView::ResizeToContents );
}

void OrderWidget::connects( ) {
  connect( ui->pushButtonAddNewOrder, QOverload< bool >::of( &QPushButton::clicked ), this, QOverload<>::of( &OrderWidget::slotAddOrder ) );
}

void OrderWidget::refresh( ) {
  model->clear( );
  initModel( );
}
