#ifndef DATABASECREATOR_H
#define DATABASECREATOR_H
#include <QSqlDatabase>

class DatabaseCreator
{
	public:
		// DatabaseCreator();
		static void initializationDatabase();
	private:
		static void defaultConnect();
		static void connectToNewDb();
		static void closeDefaultConnect();
		static void createDatabase();
		static void createEmptyTablesInDatabase();
		static void writeConstantDataInDb();
};

#endif // DATABASECREATOR_H
