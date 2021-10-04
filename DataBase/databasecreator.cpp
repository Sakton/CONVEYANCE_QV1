#include "databasecreator.h"

#include "Constants.h"
#include <QFile>
#include <QSqlError>
#include <QSqlQuery>

DatabaseCreator::DatabaseCreator()
{
	createDefaultConnectionDb();
}

bool DatabaseCreator::createDefaultConnectionDb( ) {
	QSqlDatabase defaultConnect = QSqlDatabase::addDatabase( "QPSQL", "POSTGRES" );
	defaultConnect.setHostName( "localhost" );
	defaultConnect.setPort( 5432 );
	defaultConnect.setUserName( "postgres" );
	defaultConnect.setPassword( "postgres" );
	defaultConnect.setDatabaseName( "postgres" );
	if( defaultConnect.open( ) ) {
		qDebug() << "CONNECTION OK";
		return true;
	}
	qDebug() << "ERROR DatabaseCreator::createDefaultConnectionDb" << defaultConnect.lastError().text();
	return false;
}

//bool DatabaseCreator::createNormalConnectionDb( ) {
//	QSqlDatabase db = QSqlDatabase::addDatabase( "QPSQL", "CREATECONNECT" );
//	db.setHostName( "localhost" );
//	db.setPort( 5432 );
//	db.setUserName( "postgres" );
//	db.setPassword( "postgres" );
//	db.setDatabaseName( ConveyanceConstats::NAME_DATABASE_IN_SUBD );
//	return db.open( );
//}

//bool DatabaseCreator::createConnection(const QString & nameConnection)
//{
//	db.setHostName( "localhost" );
//	db.setPort( 5432 );
//	db.setUserName( "postgres" );
//	db.setPassword( "postgres" );
//	db.setDatabaseName( ConveyanceConstats::NAME_DATABASE_IN_SUBD );
//	return db.open( );
//}

//bool DatabaseCreator::createDatabase( ) {
//	return createEmptyBase( );
//}

DatabaseCreator::~DatabaseCreator( ) {
  QSqlDatabase::removeDatabase( "POSTGRES" );
	// QSqlDatabase::removeDatabase( "CREATECONNECT" );
}

//bool DatabaseCreator::createEmptyBase( ) {

//  bool createDb = createDefaultConnectionDb( );

//  Q_ASSERT_X( createDb, "createDefaultConnectionDb", "createDefaultConnectionDb" );

//  QSqlDatabase defaultDb = QSqlDatabase::database( "POSTGRES" );
//  bool ok = false;
//  if ( !isCreateDataBase( defaultDb ) ) {
//    QSqlQuery query( defaultDb );
//		QString qs = QString("CREATE DATABASE %1 WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Russian_Russia.1251';").arg( ConveyanceConstats::NAME_DATABASE_IN_SUBD );
//		if ( query.exec( qs ) ) {
//      bool ok1 = createTablesAndUtilities( );
//      bool ok2 = addingConstantData( );
//      qDebug( ) << "ok1 = " << ok1 << "  ok2 = " << ok2;
//			if( ok1 && ok2 ) ok = true;
//			else ok = false;
//		}
//  }
//  return ok;
//}

//bool DatabaseCreator::createTablesAndUtilities( ) {
//  if ( !createConnectionToDb( ) ) {
//    qDebug( ) << "ERROR OPEN DB in DatabaseCreator::createTablesAndUtilities";
//    return false;
//  }
//  QSqlDatabase db = QSqlDatabase::database( "CREATECONNECT" );
//  QFile file( ConveyanceConstats::PATH_NAME_DUMP_SCHEMA_TO_FIRST_LOAD );
//	if ( !file.open( QFile::ReadOnly | QFile::Text ) ) {
//    qDebug( ) << "ERROR OPEN FILE DB";
//  } else {
//    QString qs( file.readAll( ) );
//    QSqlQuery query( db );
//    if ( !query.exec( qs ) ) {
//      qDebug( ) << query.lastError( ).text( );
//      return false;
//    }
//  }
//  return true;
//}

//bool DatabaseCreator::isCreateDataBase( const QSqlDatabase & db ) {
//  QSqlQuery query(
//      QString( "SELECT EXISTS ( SELECT 1 FROM pg_database WHERE datname = '%1' ) AS res;" ).arg( ConveyanceConstats::NAME_DATABASE_IN_SUBD ), db );
//  query.next( );
//  return query.value( "res" ).toBool( );
//}



//bool DatabaseCreator::addingConstantData( ) {
//  QFile file( ConveyanceConstats::PATH_NAME_DUMP_CONSTATNTS_DATA_INSERT );
//  if ( file.open( QFile::ReadOnly ) ) {
//    QString qs { file.readAll( ) };
//		qDebug() << qs;
//    if ( !createConnectionToDb( ) ) {
//      qDebug( ) << "ERROR OPEN DB in DatabaseCreator::createTablesAndUtilities";
//      return false;
//    }
//    QSqlDatabase db = QSqlDatabase::database( "CREATECONNECT" );
//    QSqlQuery query( db );
//		if( !query.exec( qs ) ){
//			qDebug() << "ERROR DatabaseCreator::addingConstantData  " << db.lastError().text();
//			return false;
//		}
//  }
//	return true;
//}
