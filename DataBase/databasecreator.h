#ifndef DATABASECREATOR_H
#define DATABASECREATOR_H
#include <QSqlDatabase>

class DatabaseCreator
{
public:
  bool createDatabase( );

private:
  bool createEmptyBase( );
  bool createTablesAndUtilities( );
  bool isCreateDataBase( const QSqlDatabase & db );
  bool createDefaultConnectionDb( );
};

#endif // DATABASECREATOR_H