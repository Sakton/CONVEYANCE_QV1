#ifndef DATABASECREATOR_H
#define DATABASECREATOR_H

class QSqlDatabase;

class DatabaseCreator
{
public:
  DatabaseCreator( );
  bool createDatabase( );
};

#endif // DATABASECREATOR_H
