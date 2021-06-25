#include "adressview.h"
#include "Constants.h"
#include "addadress.h"
#include "adresscountrydelegate.h"
#include "ui_adressview.h"
#include <QContextMenuEvent>
#include <QMenu>
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
  ui->tableView->horizontalHeader( )->setSectionResizeMode(
      QHeaderView::ResizeMode::Stretch );

  connect(
      ui->tableView,
      QOverload< const QModelIndex & >::of( &QTableView::clicked ), this,
      QOverload< const QModelIndex & >::of( &AdressView::slotSelectedRow ) );
}

AdressView::~AdressView( ) { delete ui; }

void AdressView::slotSelectedRow( const QModelIndex & indeRowSelected ) {
  qDebug( ) << "indexRow = " << indeRowSelected.row( );
}

void AdressView::slotEditActionContextMenu( bool ) {
  qDebug( ) << "EditAction";
}

void AdressView::slotAddActionContextMenu( bool ) {
  qDebug( ) << "AddAction";
  AddAdress addDialog( this );
  addDialog.exec( );
}

void AdressView::slotDelActionContextMenu( bool ) { qDebug( ) << "DelAction"; }

void AdressView::createModel( ) {
  model = new QSqlTableModel( this, QSqlDatabase::database( NAME_DB_ALL ) );
  model->setTable( "adress_view" );
  model->setHeaderData( 2, Qt::Orientation::Horizontal, tr( "СТРАНА" ) );
  model->setHeaderData( 3, Qt::Orientation::Horizontal, tr( "ИНДЕКС" ) );
  model->setHeaderData( 4, Qt::Orientation::Horizontal, tr( "ГОРОД" ) );
  model->setHeaderData( 5, Qt::Orientation::Horizontal, tr( "АДРЕС" ) );
  model->select( );
}

void AdressView::contextMenuEvent( QContextMenuEvent * event ) {
  QMenu contextMenu( this );
  // TODO тут возможно придется изменить
  QAction actionEditRow( tr( "Править" ), &contextMenu );
  QAction actionAddRow( tr( "Добавить" ), &contextMenu );
  QAction actionDelRow( tr( "Удалить" ), &contextMenu );

  connect( &actionEditRow, QOverload< bool >::of( &QAction::triggered ), this,
           QOverload< bool >::of( &AdressView::slotEditActionContextMenu ) );
  connect( &actionAddRow, QOverload< bool >::of( &QAction::triggered ), this,
           QOverload< bool >::of( &AdressView::slotAddActionContextMenu ) );
  connect( &actionDelRow, QOverload< bool >::of( &QAction::triggered ), this,
           QOverload< bool >::of( &AdressView::slotDelActionContextMenu ) );

  contextMenu.addAction( &actionEditRow );
  contextMenu.addAction( &actionAddRow );
  contextMenu.addAction( &actionDelRow );

  contextMenu.exec( event->globalPos( ) );
}
