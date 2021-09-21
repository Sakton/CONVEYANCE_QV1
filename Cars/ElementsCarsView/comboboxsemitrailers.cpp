#include "comboboxsemitrailers.h"
#include "Constants.h"
#include <QSqlRecord>

ComboBoxSemitrailersSqlQueryModel::ComboBoxSemitrailersSqlQueryModel( QObject * parent ) : QSqlQueryModel( parent ) {
  setQuery( "SELECT id, name, carrying, lenth, width, height, img, description FROM cars.semitrailers_view;",
	    QSqlDatabase::database( ConveyanceConstats::NAME_DB_ALL ) );
}

QVariant ComboBoxSemitrailersSqlQueryModel::data( const QModelIndex & index, int role ) const {
  if ( !index.isValid( ) )
    return { };
  switch ( role ) {
    case Qt::DisplayRole:
      return record( index.row( ) ).value( "name" );
    case SemitrailerRole::ID:
      return record( index.row( ) ).value( "id" );
    case SemitrailerRole::CARRYING:
      return record( index.row( ) ).value( "carrying" );
    case SemitrailerRole::LENTH:
      return record( index.row( ) ).value( "lenth" );
    case SemitrailerRole::WIDTH:
      return record( index.row( ) ).value( "width" );
    case SemitrailerRole::HEIGHT:
      return record( index.row( ) ).value( "height" );
    case SemitrailerRole::IMG:
      return record( index.row( ) ).value( "img" );
    case SemitrailerRole::DESCRIPTION:
      return record( index.row( ) ).value( "description" );
  }
  return QSqlQueryModel::data( index, role );
}

ComboBoxSemitrailers::ComboBoxSemitrailers( QWidget * parent ) : QComboBox( parent ) {
  _model = new ComboBoxSemitrailersSqlQueryModel;
  setModel( _model );
}
