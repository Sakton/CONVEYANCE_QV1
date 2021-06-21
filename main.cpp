#include "Adress/addadress.h"
#include "Adress/adress.h"
#include "ElementsWidgets/comboboxcountrys.h"
#include "MainWindow/mainwindow.h"
#include <QApplication>
#include <QSplashScreen>
#include <QSqlDatabase>

// global
void setsApp( QApplication &app );
// tempory

void createDbConnection( );

//***********************************************
int main( int argc, char *argv[] ) {
  QApplication a( argc, argv );
  setsApp( a );

  QSplashScreen splash( QPixmap( ":/img/splash.jpg" ) );
  splash.show( );

  //  MainWindow w;
  //  w.show( );
  createDbConnection( ); //в MainWindow создание соединения. Эта вместо маин

  //  Adress w;
  //  w.show( );

  AddAdress w;
  w.show( );

  //  ComboBoxCountrys w;
  //  w.show( );

  splash.finish( &w );
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
  QSqlDatabase db = QSqlDatabase::addDatabase( "QPSQL", "DB" );
  db.setHostName( "localhost" );
  db.setPort( 5432 );
  db.setDatabaseName( "demo_coveyance_db" );
  db.setUserName( "postgres" );
  db.setPassword( "postgres" );
  bool ok = db.open( );
  qDebug( ) << "database status = " << ok;
}
