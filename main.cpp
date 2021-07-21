#include "Adress/adressdialog.h"
#include "Adress/adressview.h"
#include "Emploee/addemploeedialog.h"
#include "Emploee/emploeetableview.h"
#include "MainWindow/mainwindow.h"
#include "Orders/createorderdialog.h"

#include "Shippers/addshipperdialog.h"

#include <QApplication>
#include <QLabel>
#include <QSplashScreen>
#include <QSqlDatabase>

#include "MyTests/testqsqltableformform.h"

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

  createDbConnection( ); //в MainWindow создание соединения. Эта вместо маин

  // Adress w;
  // AddAdress w;
  // ComboBoxCountrys w;
  // ComboBoxCity w;
  // CityDialog w;
  // QLabel *w = new QLabel( "<img source = \":/img/flagCountrys/austria.png\"><H3>AUSTRIA</H3></img>" );
  // ComboBoxCarBrand w;

  // AddBrandCarDialog w;
  // AdressDialog w;
  // AdressView w;
  // TestQSqlTableFormForm w;

  // AddEmploeeDialog w;
  // EmploeeTableView w;
  // AddShipperDialog w;
  CreateOrderDialog w;
  w.show( );

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
