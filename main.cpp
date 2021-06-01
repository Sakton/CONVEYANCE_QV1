#include "MainWindow/mainwindow.h"
#include <QApplication>
#include <QSplashScreen>

int main( int argc, char *argv[] ) {
  QApplication a( argc, argv );
  a.setApplicationName( "" );
  a.setApplicationVersion( "" );

  QSplashScreen splash( QPixmap( ":/img/splash.jpg" ) );
  splash.show( );

  MainWindow w;
  w.show( );

  splash.finish( &w );
  return a.exec( );
}
