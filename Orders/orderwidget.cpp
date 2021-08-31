#include "orderwidget.h"
#include "Constants.h"
#include "createorderdialog.h"
#include "ordersqltablemodel.h"
#include "ui_orderwidget.h"
#include "updateorderdialog.h"

#include <QAction>
#include <QContextMenuEvent>
#include <QMenu>
#include <QMessageBox>
#include <QSortFilterProxyModel>
#include <QSqlRecord>

OrderWidget::OrderWidget( QWidget * parent )
    : QWidget( parent ),
      ui( new Ui::OrderWidget ), model { new OrderSqlTableModel { this, QSqlDatabase::database( NAME_DB_ALL ) } }, proxy { new QSortFilterProxyModel {
														       this } } {
  ui->setupUi( this );
  createActions( );
  setupsAction( );
  initModels( );
  createConnects( );
  setupView( );
}

OrderWidget::~OrderWidget( ) { delete ui; }

void OrderWidget::slotAddOrder( ) {
  CreateOrderDialog addorder( this );
  if ( addorder.exec( ) == QDialog::Accepted ) {
    updateOrderWidget( );
  }
}

void OrderWidget::slotUpdOrder( ) {
  QModelIndex ind = ui->tableViewOrder->selectionModel( )->currentIndex( );
  QSqlRecord rowData = model->record( ind.row( ) );
  qDebug( ) << "rowData = " << rowData;
  UpdateOrderDialog dialog( rowData, this );
  if ( dialog.exec( ) == QDialog::Accepted ) {
    updateOrderWidget( );
  }
}

void OrderWidget::slotDelOrder( ) {
  QMessageBox::information( this, tr( "УДАЛЕНИЕ ОРДЕРА" ), tr( "ХОПА, УДАЛИТСЯ ЗАПИТЬ, СТРАТЕГИЯ УДАЛЕНИЯ НЕ ПОНЯТНА ПОКА" ) );
}

void OrderWidget::slotSelectRow( const QModelIndex & idx ) {
  QSqlRecord rec = model->record( idx.row( ) );
  QString note = rec.value( 9 ).toString( );
  ui->labelNote->setText( note );
}

void OrderWidget::updateOrderWidget( ) {
  initModels( );
  setupView( );
}

void OrderWidget::createConnects( ) {
  connect( ui->tableViewOrder, QOverload< const QModelIndex & >::of( &QTableView::pressed ), this,
	   QOverload< const QModelIndex & >::of( &OrderWidget::slotSelectRow ) );
  connect( addingOrderAction, QOverload< bool >::of( &QAction::triggered ), this, QOverload<>::of( &OrderWidget::slotAddOrder ) );
  connect( updateOrderAction, QOverload< bool >::of( &QAction::triggered ), this, QOverload<>::of( &OrderWidget::slotUpdOrder ) );
  connect( deleteOrderAction, QOverload< bool >::of( &QAction::triggered ), this, QOverload<>::of( &OrderWidget::slotDelOrder ) );
}

void OrderWidget::initModels( ) {
  model->clear( );
  model->setTable( "orders.ordersview" );
  model->select( );
  model->setHeaderData( 0, Qt::Horizontal, tr( "ID" ) );
  model->setHeaderData( 1, Qt::Horizontal, tr( "Дата" ) );
  model->setHeaderData( 2, Qt::Horizontal, tr( "Номер Договора" ) );
  model->setHeaderData( 3, Qt::Horizontal, tr( "Грузотправитель" ) );
  model->setHeaderData( 4, Qt::Horizontal, tr( "Стоимость" ) );
  model->setHeaderData( 5, Qt::Horizontal, tr( "Валюта" ) );
  model->setHeaderData( 6, Qt::Horizontal, tr( "Период оплаты" ) );
  model->setHeaderData( 7, Qt::Horizontal, tr( "Испонитель" ) );
  model->setHeaderData( 8, Qt::Horizontal, tr( "Срок почты" ) );
  proxy->setSourceModel( model );
}

void OrderWidget::setupView( ) {
  ui->tableViewOrder->setModel( proxy );
  QHeaderView * hw = ui->tableViewOrder->horizontalHeader( );
  ui->tableViewOrder->hideColumn( 0 );
  ui->tableViewOrder->hideColumn( 9 );
  hw->setDefaultAlignment( Qt::AlignCenter );
  hw->setSectionResizeMode( QHeaderView::ResizeMode::ResizeToContents );

  menuForTable = new QMenu( this );
  menuForTable->addAction( addingOrderAction );
  menuForTable->addAction( updateOrderAction );
  menuForTable->addAction( deleteOrderAction );
  ui->tableViewOrder->setContextMenu( menuForTable );
}

void OrderWidget::createActions( ) {
  addingOrderAction = new QAction( tr( "Создать" ), this );
  updateOrderAction = new QAction( tr( "Изменить" ), this );
  deleteOrderAction = new QAction( tr( "Удалить" ), this );
}

void OrderWidget::setupsAction( ) {
  ui->toolButtonAddNewOrder->setAction( addingOrderAction );
  ui->toolButtonUpdateOrder->setAction( updateOrderAction );
  ui->toolButtonDeleteOrder->setAction( deleteOrderAction );
}
