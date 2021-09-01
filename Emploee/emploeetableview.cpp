#include "emploeetableview.h"
#include "Constants.h"
#include "emploeesqltablemodel.h"
#include "ui_emploeetableview.h"

#include <QContextMenuEvent>
#include <QMenu>

EmploeeTableView::EmploeeTableView( QWidget * parent ) : QWidget( parent ), ui( new Ui::EmploeeTableView ) {
  ui->setupUi( this );
  model = new EmploeeSqlTableModel( this, QSqlDatabase::database( ConveyanceConstats::NAME_DB_ALL ) );
  ui->tableView->setModel( model );
  ui->tableView->setColumnHidden( 0, true );
  ui->tableView->setColumnHidden( 4, true );
  ui->tableView->horizontalHeader( )->setSectionResizeMode( QHeaderView::ResizeMode::Stretch );
}

EmploeeTableView::~EmploeeTableView( ) { delete ui; }

void EmploeeTableView::contextMenuEvent( QContextMenuEvent * event ) {
  qDebug( ) << "contextMenuEvent(QContextMenuEvent *event)" << event->pos( );
  QMenu contextMenu( this );
  contextMenu.addAction( "Add" );
  contextMenu.addAction( "Upd" );
  contextMenu.addAction( "Del" );
  contextMenu.exec( event->globalPos( ) );
}
