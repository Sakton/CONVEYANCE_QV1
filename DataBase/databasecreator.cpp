#include "databasecreator.h"
#include "Autorization/newuserdatabasedialog.h"

#include "Constants.h"
#include <QFile>
#include <QSqlError>
#include <QSqlQuery>
#include <QFile>

void DatabaseCreator::initializationDatabase()
{
	defaultConnect();
	if( !isCreated() ) {
		createDatabase();
		closeDefaultConnect();
		connectToNewDb();
		createEmptyTablesInDatabase();
		writeConstantDataInDb();
		QSqlDatabase::removeDatabase( "CONVEYANCE" );
	} else {
		qDebug() << "DB BYLA SOZDANA RANYSHE";
	}
	QSqlDatabase::removeDatabase("POSTGRES");
}

void DatabaseCreator::defaultConnect() {
	auto db = QSqlDatabase::addDatabase( "QPSQL", "POSTGRES" );
	db.setHostName( "127.0.0.1" );
	db.setDatabaseName( "postgres" );
	if( !db.open( "postgres", "postgres" ) ){
		qDebug() << "ERROR open default DB";
	} else {
		qDebug() << "Dafault DB open";
	}
	if( QSqlDatabase::database( "POSTGRES" ).tables().size() ) {
		for( auto &el : QSqlDatabase::database( "POSTGRES" ).tables() ) {
			qDebug() << el;
		}
	} else {
		qDebug() << "DB empty";
	}
}

void DatabaseCreator::connectToNewDb() {
	auto db = QSqlDatabase::addDatabase( "QPSQL", "CONVEYANCE" );
	db.setHostName( "127.0.0.1" );
	db.setDatabaseName( ConveyanceConstats::NAME_DATABASE_IN_SUBD );
	if( !db.open( "postgres", "postgres" ) ) {
		qDebug() << "ERROR open CONVEYANCE DB";
	} else {
		qDebug() << "Open CONVEYANCE DB";
	}
}

void DatabaseCreator::closeDefaultConnect() {
	QSqlDatabase::removeDatabase("POSTGRES");
}

void DatabaseCreator::createDatabase() {
	QString qs = QString( "CREATE DATABASE %1;" ).arg( ConveyanceConstats::NAME_DATABASE_IN_SUBD );
	QSqlQuery query( QSqlDatabase::database("POSTGRES") );
	if( !query.exec( qs ) ) {
		qDebug() << "ERROR CREATE DATABASE " << query.lastError().text();
	} else {
		qDebug() << "CREATE DATABASE";
	}
}

void DatabaseCreator::createEmptyTablesInDatabase() {
	QFile file( ":/DumpStructureDatabase/conveyanceDbSchema.sql" );
	if( !file.open( QFile::ReadOnly | QFile::Text ) ) {
		qDebug() << "ERROR OPEN FILE DB STRUCTURE";
		return;
	}
	QString qs = file.readAll();
	QSqlQuery query( QSqlDatabase::database("CONVEYANCE") );
	if( !query.exec( qs ) ) {
		qDebug() << "ERROR CREATE TABLE IN DATABASE" << query.lastError().text();
	} else {
		qDebug() << "OK CREATE TABLE IN DATABASE";
	}
}

void DatabaseCreator::writeConstantDataInDb()
{
	QFile file(":/DumpStructureDatabase/InsertConstatsDataInTable.sql");
	if( !file.open( QFile::ReadOnly | QFile::Text ) ) {
		qDebug() << "ERROR OPEN FILE CONSTANT DATA";
		return;
	}
	QString qs = file.readAll();
	QSqlQuery query( QSqlDatabase::database("CONVEYANCE") );
	if( !query.exec(qs) ) {
		qDebug() << "ERROR WRITE DATA TO TABLE " << query.lastError().text();
	} else {
		qDebug() << "OK WRITE DATA TO TABLE";
	}
}

bool DatabaseCreator::isCreated()
{
	QString qs = QString( " SELECT EXISTS ( SELECT 1 FROM pg_database WHERE datname = '%1' );" ).arg( ConveyanceConstats::NAME_DATABASE_IN_SUBD );
	QSqlQuery query( QSqlDatabase::database( "POSTGRES" ) );
	if( !query.exec(qs) ) {
		qDebug() << "Error isCreated(): " << query.lastError().text();
	}
	query.next();
	return query.value(0).toBool();
}


