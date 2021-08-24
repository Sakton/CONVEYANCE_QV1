#include "databasecreator.h"

#include "Constants.h"
#include <QFile>
#include <QSqlError>
#include <QSqlQuery>

bool DatabaseCreator::createDatabase( ) {

  if ( createEmptyBase( ) )
    return createTablesAndUtilities( );
  return false;
}

// TODO ШАМАНИТЬ ТУТ

bool DatabaseCreator::createEmptyBase( ) {
  createDefaultConnectionDb( );
  QSqlDatabase defaultDb = QSqlDatabase::database( "POSTGRES" );
  bool ok = false;
  if ( !isCreateDataBase( defaultDb ) ) {
    QSqlQuery query(
	QString( "CREATE DATABASE %1 WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Russian_Russia.1251';" ).arg( NAME_DATABASE_IN_SUBD ),
	defaultDb );
    ok = query.exec( );
    qDebug( ) << "ok = " << ok;
  }
  return ok;
}

bool DatabaseCreator::createTablesAndUtilities( ) {
  QSqlDatabase db = QSqlDatabase::addDatabase( "QPSQL", "NAME_DATABASE_IN_SUBD" );
  db.setHostName( "localhost" );
  db.setPort( 5432 );
  db.setUserName( "postgres" );
  db.setPassword( "postgres" );
  db.setDatabaseName( NAME_DATABASE_IN_SUBD );
  bool ok = db.open( );
  if ( !ok ) {
    qDebug( ) << "ERROR OPEN DB in DatabaseCreator::createTablesAndUtilities";
    return false;
  }

  QFile file( ":/DumpStructureDatabase/currentDumpSchema.sql" );
  if ( !file.open( QFile::ReadOnly ) ) {
    qDebug( ) << "ERROR OPEN FILE DB";
  } else {
    QString qs( file.readAll( ) );
    QSqlQuery query( db );
    if ( !query.exec( qs ) ) {
      qDebug( ) << query.lastError( ).text( );
      return false;
    }
  }
  return true;
}

bool DatabaseCreator::isCreateDataBase( const QSqlDatabase & db ) {
  QSqlQuery query( QString( "SELECT EXISTS ( SELECT 1 FROM pg_database WHERE datname = '%1' ) AS res;" ).arg( NAME_DATABASE_IN_SUBD ), db );
  query.next( );
  return query.value( "res" ).toBool( );
}

bool DatabaseCreator::createDefaultConnectionDb( ) {
  QSqlDatabase defaultDb = QSqlDatabase::addDatabase( "QPSQL", "POSTGRES" );
  defaultDb.setHostName( "localhost" );
  defaultDb.setPort( 5432 );
  defaultDb.setUserName( "postgres" );
  defaultDb.setPassword( "postgres" );
  defaultDb.setDatabaseName( "postgres" );
  return defaultDb.open( );
}