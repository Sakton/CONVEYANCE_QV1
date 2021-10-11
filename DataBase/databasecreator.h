#ifndef DATABASECREATOR_H
#define DATABASECREATOR_H
#include <QSqlDatabase>

class DatabaseCreator {
	public:
		// DatabaseCreator();
		static void initializationDatabase();
		static void defaultConnect();
		static void closeDefaultConnect();
	private:
		static void connectToNewDb();
		static void createDatabase();
		static void createEmptyTablesInDatabase();
		static void writeConstantDataInDb();
		static bool isCreated();
};

#endif // DATABASECREATOR_H
