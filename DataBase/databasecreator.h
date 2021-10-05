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
	QString queryFromFile( const QString & fileName ) const;
	bool isCreateDataBase()const;
	bool createNewDataBase();
	bool createTablesNewDataBase();
	bool createNewServer();

	private:
	void printErrorQuery( const QSqlQuery &query ) const;

};

#endif // DATABASECREATOR_H
