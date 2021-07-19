#include "testqsqltableformform.h"
#include "Constants.h"
#include "ui_testqsqltableformform.h"

#include <QSqlQuery>
#include <QSqlTableModel>

TestQSqlTableFormForm::TestQSqlTableFormForm( QWidget *parent ) : QWidget( parent ), ui( new Ui::TestQSqlTableFormForm ) {
  ui->setupUi( this );
  //  QString qs { "SELECT * FROM adres.TestAdressView" };
  //  QSqlQuery query( QSqlDatabase::database( NAME_DB_ALL ) );
  //  query.exec( qs );
  QSqlTableModel *tmodel = new QSqlTableModel( this, QSqlDatabase::database( NAME_DB_ALL ) );
  tmodel->setTable( "adres.testadressview" ); //наименования таблиц должны быть в нижнем регистре, как они записаны в базе
  tmodel->select( );
  ui->tableView->setModel( tmodel );
}

TestQSqlTableFormForm::~TestQSqlTableFormForm( ) {
  delete ui;
}
