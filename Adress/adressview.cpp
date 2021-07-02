#include "adressview.h"
#include "Constants.h"
#include "addadress.h"
#include "adresscountrydelegate.h"
#include "adressdialog.h"
#include "ui_adressview.h"
#include "updateadressdialog.h"
#include <QContextMenuEvent>
#include <QMenu>
#include <QSqlError>
#include <QSqlQuery>
#include <QSqlRecord>
#include <QSqlRelationalTableModel>
#include <QSqlTableModel>

AdressView::AdressView( QWidget * parent ) : QWidget( parent ), ui( new Ui::AdressView ), model { nullptr } {
  ui->setupUi( this );
  createModel( );
  ui->tableView->setModel( model );
  ui->tableView->setItemDelegate( new AdressCountryDelegate( ui->tableView ) );
  ui->tableView->setColumnHidden( 0, true );
  ui->tableView->setColumnHidden( 1, true );
  ui->tableView->horizontalHeader( )->setSectionResizeMode( QHeaderView::ResizeMode::Stretch );

  connect(
      ui->tableView,
      QOverload< const QModelIndex & >::of( &QTableView::clicked ), this,
      QOverload< const QModelIndex & >::of( &AdressView::slotSelectedRow ) );
}

AdressView::~AdressView( ) { delete ui; }

void AdressView::slotSelectedRow( const QModelIndex & indexRowSelected ) {
  qDebug( ) << "indexRow = " << indexRowSelected.row( );
}

void AdressView::slotEditActionContextMenu( bool ) {
  int id = model->record( ui->tableView->selectionModel( )->currentIndex( ).row( ) ).value( "adres_id" ).toInt( );
  UpdateAdressDialog dialog { id, model, this };
  dialog.setWindowTitle( tr( "ПРАВКА" ) );
  dialog.exec( );
  updateModel( );
}

void AdressView::slotAddActionContextMenu( bool ) {
  QSqlRecord record = model->record( ui->tableView->selectionModel( )->currentIndex( ).row( ) );
  QString nameCountry = record.value( 2 ).toString( );

  AdressDialog addDialog( model, this );
  addDialog.slotSetCountry( nameCountry );
  addDialog.exec( );
  updateModel( );
}

void AdressView::slotDelActionContextMenu( bool ) {
  QModelIndex selected = ui->tableView->selectionModel( )->currentIndex( );
  QString curIdTableAdress = model->record( selected.row( ) ).value( "adres_id" ).toString( );
  // TODO нужно ли оставлять тут ???
  QSqlQuery query { QSqlDatabase::database( NAME_DB_ALL ) };
  if ( !query.exec( "DELETE FROM adress WHERE adres_id = " + curIdTableAdress ) ) {
    qDebug( ) << "ERROR DELETE QUERY: " << query.lastError( ).text( );
  }
  updateModel( );
}

void AdressView::updateModel( ) {
  // TODO тут перезапрашиваем модель после вставки ( минусы: перезапрос )
  model->select( );
  ui->tableView->setModel( model );
  ui->tableView->update( );
}

void AdressView::createModel( ) {
  model = new QSqlTableModel { this, QSqlDatabase::database( NAME_DB_ALL ) };
  model->setTable( "adress_view" );
  model->setHeaderData( 2, Qt::Orientation::Horizontal, tr( "СТРАНА" ) );
  model->setHeaderData( 3, Qt::Orientation::Horizontal, tr( "ИНДЕКС" ) );
  model->setHeaderData( 4, Qt::Orientation::Horizontal, tr( "ГОРОД" ) );
  model->setHeaderData( 5, Qt::Orientation::Horizontal, tr( "АДРЕС" ) );
  model->select( );
}

void AdressView::contextMenuEvent( QContextMenuEvent * event ) {
  //выбранный индекс модели -> выбранная строка

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
