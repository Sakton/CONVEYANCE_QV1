
#include "MainWindow/mainwindow.h"

#include "DataBase/databasecreator.h"

#include "Cars/addcarmodeldialog.h"
#include "Cars/commoncardialog.h"
#include "ElementsWidgets/comboboxcarbrand.h"
#include "ElementsWidgets/comboboxcarcategories.h"

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
int main( int argc, char * argv[] ) {

  QApplication a( argc, argv );

  setsApp( a );

  //  DatabaseCreator dbc;
  //  if ( !dbc.createDatabase( ) )
  //    qDebug( ) << "ERROR CREATE DB";
  //  else
  //    qDebug( ) << "CREATE DB";

  // **********

  //  QSplashScreen splash( QPixmap( ":/img/splash.jpg" ) );
  //  splash.show( );
  //  createDbConnection( ); //в MainWindow создание соединения. Эта вместо маин

  //  MainWindow w;
  //  w.show( );
  //  splash.finish( &w );

  // *****************

  createDbConnection( ); //в MainWindow создание соединения. Эта вместо маин

  ComboBoxCarCategories md;
  md.show( );

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
  QSqlDatabase db = QSqlDatabase::addDatabase( "QPSQL", ConveyanceConstats::NAME_DB_ALL );
  db.setHostName( "localhost" );
  db.setPort( 5432 );
  db.setDatabaseName( ConveyanceConstats::NAME_DATABASE_IN_SUBD );
  db.setUserName( "postgres" );
  db.setPassword( "postgres" );
  bool ok = db.open( );
  qDebug( ) << "database status = " << ok;
}
