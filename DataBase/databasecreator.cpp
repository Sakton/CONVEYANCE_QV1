#include "databasecreator.h"
#include "Autorization/newuserdatabasedialog.h"

#include "Constants.h"
#include <QFile>
#include <QSqlError>
#include <QSqlQuery>

DatabaseCreator::DatabaseCreator()
{
//	if( !createDefaultConnectionDb() ){
//		qDebug() << "ERROR DatabaseCreator::createDefaultConnectionDb" << defaultConnect.lastError().text();
//	}
	createDefaultConnectionDb();
	createDatabase();
	qDebug() << "Is create DB = " << isCreateDataBase();
}

bool DatabaseCreator::createDatabase()
{
	//1/ Есть ли такая база в записях
	if( !isCreateDataBase() ) { //если базы такой нет
		if( !createNewDataBase() ) { //создаем и смотрим результат
			qDebug() << "не могу создать базу";
			return false;
		} else {
			QSqlDatabase::database("POSTGRES").close();
			if( NewUserdataBaseDialog().exec() ) {

			} else {

			}
		}
	}
	return true;
}

bool DatabaseCreator::createDefaultConnectionDb( ) {
	QSqlDatabase defaultConnect = QSqlDatabase::addDatabase( "QPSQL", "POSTGRES" );
	defaultConnect.setHostName( "localhost" );
	defaultConnect.setPort( 5432 );
	defaultConnect.setUserName( "postgres" );
	defaultConnect.setPassword( "postgres" );
	defaultConnect.setDatabaseName( "postgres" );
	// return defaultConnect.open( );
	if( defaultConnect.open( ) ) {
		qDebug() << "CONNECTION OK";
		return true;
	}
	qDebug() << "ERROR DatabaseCreator::createDefaultConnectionDb" << defaultConnect.lastError().text();
	return false;
}

QString DatabaseCreator::queryFromFile(const QString & fileName) const {
	QFile file( fileName );
	if( !file.open(QFile::ReadOnly | QFile::Text ) ) {
		qDebug() << "ERROR open file dump create db";
	}
	return file.readAll();
}

bool DatabaseCreator::isCreateDataBase() const
{
	QString qs = QString( "SELECT EXISTS ( SELECT * FROM pg_database WHERE datname = '%1' );" ).arg(ConveyanceConstats::NAME_DATABASE_IN_SUBD);
	QSqlQuery query( QSqlDatabase::database("POSTGRES") );
	if( !query.exec(qs) ) {
		qDebug() << "Error query: " << query.lastError().text();
	}
	bool res = true;
	if( query.isSelect() ) {
			query.next();
			res = query.value(0).toBool();
	}
	return res;
}

bool DatabaseCreator::createNewDataBase()
{
	QString qs = QString("CREATE DATABASE %1").arg( ConveyanceConstats::NAME_DATABASE_IN_SUBD );
	QSqlQuery query( QSqlDatabase::database("POSTGRES") );
	if( !query.exec(qs) ) {
		printErrorQuery(query);
		return false;
	}
	return true;
}

bool DatabaseCreator::createTablesNewDataBase()
{
//	QString qs = queryFromFile( ":/DumpStructureDatabase/conveyanceDbSchema.sql" );
//	QSqlQuery query(  );
	return true;
}

bool DatabaseCreator::createNewServer() {
	return true;
}

void DatabaseCreator::printErrorQuery(const QSqlQuery & query) const
{
	qDebug() << query.lastError().text();
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
