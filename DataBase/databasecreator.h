#ifndef DATABASECREATOR_H
#define DATABASECREATOR_H
#include <QSqlDatabase>

class DatabaseCreator
{
	public:
		DatabaseCreator();

	private:
		static void defaultConnect();
		void createUser()const;
		void createServer()const;
		void createEmptyDatabase()const;
};

#endif // DATABASECREATOR_H
