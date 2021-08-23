#include "databasecreator.h"

#include "Constants.h"
#include <QSqlError>
#include <QSqlQuery>

DatabaseCreator::DatabaseCreator( ) {}

bool DatabaseCreator::createDatabase( ) {

  QSqlDatabase defaultDb = QSqlDatabase::addDatabase( "QPSQL", "DEFAULT_POSTGRES" );
  defaultDb.setHostName( "localhost" );
  defaultDb.setPort( 5432 );
  defaultDb.setUserName( "postgres" );
  defaultDb.setPassword( "postgres" );
  defaultDb.setDatabaseName( "postgres" );
  bool ok = defaultDb.open( );
  if ( !ok )
    qDebug( ) << "ERROR OPEN DB";

  QString qs = QString( "SELECT EXISTS ( SELECT 1 FROM pg_database WHERE datname = '%1' ) AS res;" ).arg( NAME_DATABASE_IN_SUBD );
  QSqlQuery query( defaultDb );
  if ( !query.exec( qs ) ) {
    qDebug( ) << query.lastError( ).text( );
    return false;
  } else {
    query.next( );
    bool res = query.value( "res" ).toBool( );
    if ( !res ) {
      qs = QString( "CREATE DATABASE %1 WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Russian_Russia.1251';" ).arg( NAME_DATABASE_IN_SUBD );
      if ( !query.exec( qs ) ) {
	qDebug( ) << query.lastError( ).text( );
	return false;
      }
    }
  }
  return true;
}
