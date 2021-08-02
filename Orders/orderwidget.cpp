#include "orderwidget.h"
#include "Constants.h"
#include "createorderdialog.h"
#include "ordersqltablemodel.h"
#include "ui_orderwidget.h"

#include <QAction>
#include <QSortFilterProxyModel>
#include <QSqlRecord>

OrderWidget::OrderWidget( QWidget * parent )
    : QWidget( parent ),
      ui( new Ui::OrderWidget ), model { new OrderSqlTableModel { this, QSqlDatabase::database( NAME_DB_ALL ) } }, proxy { new QSortFilterProxyModel {
														       this } } {
  ui->setupUi( this );
  createConnects( );
  initModels( );
  setupView( );
  createActions( );
}

OrderWidget::~OrderWidget( ) { delete ui; }

void OrderWidget::slotAddOrder( ) {
  CreateOrderDialog addorder( this );
  if ( addorder.exec( ) == QDialog::Accepted ) {
    updateOrderWidget( );
  }
}

void OrderWidget::slotSelectRow( const QModelIndex & idx ) {
  QSqlRecord rec = model->record( idx.row( ) );
  QString note = rec.value( 8 ).toString( );
  ui->labelNote->setText( note );
}

void OrderWidget::updateOrderWidget( ) {
  initModels( );
  setupView( );
}

void OrderWidget::createConnects( ) {
  // connect( ui->pushButtonAddNewOrder, QOverload< bool >::of( &QPushButton::clicked ), this, QOverload<>::of( &OrderWidget::slotAddOrder ) );
  connect( ui->tableViewOrder, QOverload< const QModelIndex & >::of( &QTableView::pressed ), this,
	   QOverload< const QModelIndex & >::of( &OrderWidget::slotSelectRow ) );
}

void OrderWidget::initModels( ) {
  model->clear( );
  model->setTable( "orders.ordersview" );
  model->select( );
  model->setHeaderData( 0, Qt::Horizontal, tr( "Дата" ) );
  model->setHeaderData( 1, Qt::Horizontal, tr( "Номер Договора" ) );
  model->setHeaderData( 2, Qt::Horizontal, tr( "Грузотправитель" ) );
  model->setHeaderData( 3, Qt::Horizontal, tr( "Стоимость" ) );
  model->setHeaderData( 4, Qt::Horizontal, tr( "Валюта" ) );
  model->setHeaderData( 5, Qt::Horizontal, tr( "Период оплаты" ) );
  model->setHeaderData( 6, Qt::Horizontal, tr( "Испонитель" ) );
  model->setHeaderData( 7, Qt::Horizontal, tr( "Срок почты" ) );
  proxy->setSourceModel( model );
}

void OrderWidget::setupView( ) {
  ui->tableViewOrder->setModel( proxy );
  QHeaderView * hw = ui->tableViewOrder->horizontalHeader( );
  ui->tableViewOrder->hideColumn( 8 );
  hw->setDefaultAlignment( Qt::AlignCenter );
  hw->setSectionResizeMode( QHeaderView::ResizeMode::ResizeToContents );
}

void OrderWidget::createActions( ) {}
