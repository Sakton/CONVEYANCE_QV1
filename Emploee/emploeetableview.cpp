#include "emploeetableview.h"
#include "Constants.h"
#include "emploeesqltablemodel.h"
#include "ui_emploeetableview.h"

#include <QContextMenuEvent>

EmploeeTableView::EmploeeTableView( QWidget * parent ) : QWidget( parent ), ui( new Ui::EmploeeTableView ) {
  ui->setupUi( this );
  model = new EmploeeSqlTableModel( this, QSqlDatabase::database( NAME_DB_ALL ) );
  model->setTable( "emploee.emploees" );
  model->select( );
  ui->tableView->setModel( model );
}

EmploeeTableView::~EmploeeTableView( ) { delete ui; }

void EmploeeTableView::contextMenuEvent( QContextMenuEvent * event ) { qDebug( ) << "contextMenuEvent(QContextMenuEvent *event)" << event->pos( ); }
