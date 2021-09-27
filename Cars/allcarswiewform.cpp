#include "allcarswiewform.h"
#include "addcardialog.h"
#include "ui_allcarswiewform.h"
#include <QAction>
#include <QMenu>

AllCarsWiewForm::AllCarsWiewForm( QWidget * parent ) : QWidget( parent ), ui( new Ui::AllCarsWiewForm ) {
  ui->setupUi( this );
  initButton( );
}

AllCarsWiewForm::~AllCarsWiewForm( ) { delete ui; }

void AllCarsWiewForm::initButton( ) {
  add = new QAction( tr( "Добавить" ), this );
  del = new QAction( tr( "Удалить" ), this );

  connect( add, QOverload< bool >::of( &QAction::triggered ), this, QOverload<>::of( &AllCarsWiewForm::slotPushButtonAdd ) );
  connect( del, QOverload< bool >::of( &QAction::triggered ), ui->tableView, QOverload<>::of( &TableWiewCars::slotDeleteRecord ) );

  ui->pushButtonAdd->setAction( add );
  ui->pushButtonDel->setAction( del );

  contextMenu = new QMenu( ui->tableView );
  contextMenu->addAction( add );
  contextMenu->addAction( del );

  ui->tableView->setContextMenu( contextMenu );
}

void AllCarsWiewForm::slotPushButtonAdd( ) {
  AddCarDialog addCar( this );
  if ( addCar.exec( ) ) {
    emit signalPushButtonAdd( );
  }
}
