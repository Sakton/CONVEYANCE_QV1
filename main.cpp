
#include "ElementsWidgets/actionpushbutton.h"
#include "MainWindow/mainwindow.h"
#include "Orders/ordertableview.h"
#include "Orders/orderwidget.h"

#include "DataBase/databasecreator.h"
#include "Orders/commomorderform.h"

#include <QAction>
#include <QApplication>
#include <QLabel>
#include <QSplashScreen>
#include <QSqlDatabase>
#include "Constants.h"

// global
void setsApp( QApplication &app );
// tempory

void createDbConnection( );

//***********************************************
int main( int argc, char *argv[] ) {
  QApplication a( argc, argv );
  setsApp( a );

  //  DatabaseCreator dbc;
  //  if ( !dbc.createDatabase( ) )
  //    qDebug( ) << "ERROR CREATE DB";
  //  else
  //    qDebug( ) << "CREATE DB";

  QSplashScreen splash( QPixmap( ":/img/splash.jpg" ) );
  splash.show( );

  // createDbConnection( ); //в MainWindow создание соединения. Эта вместо маин

  MainWindow w;
  w.show( );
  //  CommomOrderForm of( CommomOrderForm::Regim::UPD );
  //  of.show( );

  splash.finish( &w );
  // splash.finish( &of );
  return a.exec( );
}
//***********************************************

void setsApp( QApplication &app ) {
  app.setApplicationName( "CONVEYANCE" );
  app.setApplicationVersion( "1.00" );
  app.setApplicationDisplayName( "CONVEYANCE" );
  app.setWindowIcon( QIcon( ":/img/icon24.png" ) );
}

void createDbConnection( ) {
  QSqlDatabase db = QSqlDatabase::addDatabase( "QPSQL", NAME_DB_ALL );
  db.setHostName( "localhost" );
  db.setPort( 5432 );
  db.setDatabaseName( NAME_DATABASE_IN_SUBD );
  db.setUserName( "postgres" );
  db.setPassword( "postgres" );
  bool ok = db.open( );
  qDebug( ) << "database status = " << ok;
}
