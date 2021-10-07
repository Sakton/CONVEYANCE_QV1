#include "dbcreatorthread.h"
#include "DataBase/databasecreator.h"

DbCreatorThread::DbCreatorThread( QObject *parent ) : QThread( parent )
{

}

void DbCreatorThread::run() {
	DatabaseCreator::initializationDatabase();
}
