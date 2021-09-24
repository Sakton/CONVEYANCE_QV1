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
    // ui->tableView->reload( ); //переустановука формы
  }
}

void AllCarsWiewForm::slotPushButtonDel( ) { qDebug( ) << "AllCarsWiewForm::slotPushButtonDel( )"; }
