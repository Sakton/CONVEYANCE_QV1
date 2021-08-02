#include "orderwidget.h"
#include "Constants.h"
#include "createorderdialog.h"
#include "ordersqlquerymodel.h"
#include "ui_orderwidget.h"

#include <QSortFilterProxyModel>
#include <QSqlRecord>

OrderWidget::OrderWidget( QWidget * parent ) : QWidget( parent ), ui( new Ui::OrderWidget ) {
  ui->setupUi( this );
  createConnects( );
}

OrderWidget::~OrderWidget( ) { delete ui; }

void OrderWidget::slotAddOrder( ) {
  CreateOrderDialog addorder( this );
  if ( addorder.exec( ) == QDialog::Accepted )
    ui->tableViewOrder->updateData( );
}

void OrderWidget::slotSelectRow( const QModelIndex & idx ) {
  QSqlRecord rec = model->record( idx.row( ) );
  QString note = rec.value( 8 ).toString( );
  ui->labelNote->setText( note );
}

void OrderWidget::createConnects( ) {
  connect( ui->pushButtonAddNewOrder, QOverload< bool >::of( &QPushButton::clicked ), this, QOverload<>::of( &OrderWidget::slotAddOrder ) );
  connect( ui->tableViewOrder, QOverload< const QModelIndex & >::of( &QTableView::pressed ), this,
	   QOverload< const QModelIndex & >::of( &OrderWidget::slotSelectRow ) );
}
