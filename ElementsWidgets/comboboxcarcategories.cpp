#include "comboboxcarcategories.h"
#include "Constants.h"
#include <QSqlQuery>
#include <QSqlRecord>

//******** MODEL

CarCategoriesSqlQueryModel::CarCategoriesSqlQueryModel( QObject * parent ) : QSqlQueryModel( parent ) {
  setQuery( "SELECT autocategory_id, autocategory_symbol, autocategory_icon, autocategory_name FROM cars.autocategories;",
	    QSqlDatabase::database( ConveyanceConstats::NAME_DB_ALL ) );
}

QVariant CarCategoriesSqlQueryModel::data( const QModelIndex & index, int role ) const {
  if ( !index.isValid( ) )
    return { };
  switch ( role ) {
    case Qt::DisplayRole:
      return record( index.row( ) ).value( "autocategory_symbol" ).toString( );
    case Qt::DecorationRole: {
      QPixmap pix( ":/img/CategoriesAuto/" + record( index.row( ) ).value( "autocategory_icon" ).toString( ) );
      QIcon ico { pix };
      return ico;
    }
    case AUTOCATEGORY_ID:
      return record( index.row( ) ).value( "autocategory_id" );
    case AUTOCATEGORY_NAME:
      return record( index.row( ) ).value( "autocategory_name" );
    case AUTOCATEGORY_SYMBOL:
      return record( index.row( ) ).value( "autocategory_symbol" );
  }
  return QSqlQueryModel::data( index, role );
}

//********COMBO BOX

ComboBoxCarCategories::ComboBoxCarCategories( QWidget * parent ) : QComboBox( parent ) {
  _model = new CarCategoriesSqlQueryModel;
  setModel( _model );
  setIconSize( QSize { 76, 24 } );
}

void ComboBoxCarCategories::update( ) {
  CarCategoriesSqlQueryModel * dMod = _model;
  _model = new CarCategoriesSqlQueryModel;
  dMod->deleteLater( );
  setModel( _model );
}
