#ifndef DATABASECREATOR_H
#define DATABASECREATOR_H
#include <QSqlDatabase>

class DatabaseCreator
{
public:
	DatabaseCreator();
  bool createDatabase( );
  ~DatabaseCreator( );

private:
	//  bool createEmptyBase( );
	//  bool createTablesAndUtilities( );
	//  bool isCreateDataBase( const QSqlDatabase & db );
  bool createDefaultConnectionDb( );
	bool createNormalConnectionDb( );
	bool createConnection( QSqlDatabase db, const QString &nameConnection = {} );
	// bool addingConstantData( );
};

#endif // DATABASECREATOR_H
