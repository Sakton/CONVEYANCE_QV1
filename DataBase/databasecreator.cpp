#include "databasecreator.h"
#include "Autorization/newuserdatabasedialog.h"

#include "Constants.h"
#include <QFile>
#include <QSqlError>
#include <QSqlQuery>

DatabaseCreator::DatabaseCreator()
{
	// только для тестов
	defaultConnect();
	createUser();
}

void DatabaseCreator::defaultConnect()
{
	auto db = QSqlDatabase::addDatabase("QPSQL", "POSTGRES");
	db.setHostName("127.0.0.1");
	db.setDatabaseName("postgres");
	if( !db.open("postgres", "postgres") ){
		qDebug() << "ERROR open dafault DB";
	} else {
		qDebug() << "Dafault DB open";
	}
	if( QSqlDatabase::database("POSTGRES").tables().size() ) {
		for(auto &el : QSqlDatabase::database("POSTGRES").tables()) {
			qDebug() << el;
		}
	} else {
		qDebug() << "DB empty";
	}
}

void DatabaseCreator::createUser() const
{
	if( !NewUserdataBaseDialog{}.exec() ) {
		qDebug() << "Error create user";
	}
}


