#include "databasecreator.h"

#include "Constants.h"
#include <QFile>
#include <QSqlError>
#include <QSqlQuery>

bool DatabaseCreator::createDatabase( ) { return createEmptyBase( ); }

DatabaseCreator::~DatabaseCreator( ) {
  QSqlDatabase::removeDatabase( "POSTGRES" );
  QSqlDatabase::removeDatabase( "CREATECONNECT" );
}

bool DatabaseCreator::createEmptyBase( ) {

  bool createDb = createDefaultConnectionDb( );

  Q_ASSERT_X( createDb, "createDefaultConnectionDb", "createDefaultConnectionDb" );

  QSqlDatabase defaultDb = QSqlDatabase::database( "POSTGRES" );
  bool ok = false;
  if ( !isCreateDataBase( defaultDb ) ) {
    QSqlQuery query( defaultDb );
    if ( query.exec( QString( "CREATE DATABASE %1 WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Russian_Russia.1251';" )
			 .arg( NAME_DATABASE_IN_SUBD ) ) ) {
      bool ok1 = createTablesAndUtilities( );
      bool ok2 = addingConstantData( );
      qDebug( ) << "ok1 = " << ok1 << "  ok2 = " << ok2;
    } else {
      ok = true;
    }
  }
  return ok;
}

bool DatabaseCreator::createTablesAndUtilities( ) {
  if ( !createConnectionToDb( ) ) {
    qDebug( ) << "ERROR OPEN DB in DatabaseCreator::createTablesAndUtilities";
    return false;
  }
  QSqlDatabase db = QSqlDatabase::database( "CREATECONNECT" );
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

bool DatabaseCreator::createConnectionToDb( ) {
  QSqlDatabase db = QSqlDatabase::addDatabase( "QPSQL", "CREATECONNECT" );
  db.setHostName( "localhost" );
  db.setPort( 5432 );
  db.setUserName( "postgres" );
  db.setPassword( "postgres" );
  db.setDatabaseName( NAME_DATABASE_IN_SUBD );
  return db.open( );
}

bool DatabaseCreator::addingConstantData( ) {
  QFile file( ":/DumpStructureDatabase/InsertConstatsDataInTable.sql" );
  if ( file.open( QFile::ReadOnly ) ) {
    QString qs { file.readAll( ) };
    //    qDebug( ) << "qs = " << qs;
    if ( !createConnectionToDb( ) ) {
      qDebug( ) << "ERROR OPEN DB in DatabaseCreator::createTablesAndUtilities";
      return false;
    }
    QSqlDatabase db = QSqlDatabase::database( "CREATECONNECT" );
    QSqlQuery query( db );
    return query.exec( qs );
  }
  return false;
}
