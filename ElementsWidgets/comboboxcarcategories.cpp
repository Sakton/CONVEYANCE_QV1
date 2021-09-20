#include "comboboxcarcategories.h"
#include "Constants.h"
#include <QSqlQuery>
#include <QSqlRecord>

//******** MODEL

CarCategoriesSqlQueryModel::CarCategoriesSqlQueryModel( QObject * parent ) : QSqlQueryModel( parent ) {
  setQuery( "SELECT autocategory_id, autocategory_symbol, autocategory_icon FROM cars.autocategories;",
	    QSqlDatabase::database( ConveyanceConstats::NAME_DB_ALL ) );
}

QVariant CarCategoriesSqlQueryModel::data( const QModelIndex & index, int role ) const {
  if ( !index.isValid( ) )
    return { };
  if ( role == Qt::DisplayRole ) {
    return record( index.row( ) ).value( "autocategory_symbol" ).toString( );
  }
  if ( role == Qt::DecorationRole ) {
    QPixmap pix( ":/img/CategoriesAuto/" + record( index.row( ) ).value( "autocategory_icon" ).toString( ) );
    QIcon ico { pix };
    return ico;
  }
  if ( role == Qt::UserRole ) {
    return record( index.row( ) ).value( "autocategory_id" );
  }
  return QSqlQueryModel::data( index, role );
}

// QVariant CarCategoriesSqlQueryModel::data( const QModelIndex & index, int role ) const {
//  if ( !index.isValid( ) )
//    return { };
//  QSqlRecord rec = record( index.row( ) );
//  if ( role == Qt::DisplayRole ) {
//    return rec.value( "autocategory_symbol" ).toString( );
//  }
//  if ( role == Qt::DecorationRole ) {
//    QPixmap pix( ":/img/CategoriesAuto/" + rec.value( "autocategory_icon" ).toString( ) );
//    QIcon ico { pix };
//    return ico;
//  }
//  if ( role == Qt::UserRole ) {
//    return rec.value( "autocategory_id" );
//  }
//  return QSqlQueryModel::data( index, role );
//}

//********COMBO BOX

ComboBoxCarCategories::ComboBoxCarCategories( QWidget *parent ) : QComboBox( parent ) {
  model = new CarCategoriesSqlQueryModel;
  setModel( model );
  setIconSize( QSize { 76, 24 } );
}

void ComboBoxCarCategories::update( ) {
  CarCategoriesSqlQueryModel * dMod = model;
  model = new CarCategoriesSqlQueryModel;
  dMod->deleteLater( );
  setModel( model );
}
