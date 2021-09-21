#include "comboboxcarbrand.h"
#include "Constants.h"
#include <QDir>
#include <QMessageBox>
#include <QSqlError>
#include <QSqlQuery>
#include <QSqlRecord>

CarBrandSqlQueryModel::CarBrandSqlQueryModel( QObject * parent ) : QSqlQueryModel( parent ) {
  setQuery( "SELECT autobrand_id, autobrand_name, autobrand_icon FROM cars.autobrands;", QSqlDatabase::database( ConveyanceConstats::NAME_DB_ALL ) );
}

QVariant CarBrandSqlQueryModel::data( const QModelIndex & index, int role ) const {
  if ( !index.isValid( ) )
    return { };

  if ( role == Qt::DisplayRole ) {
    return record( index.row( ) ).value( "autobrand_name" ).toString( );
  }
  if ( role == Qt::DecorationRole ) {
    QString fileName = record( index.row( ) ).value( "autobrand_icon" ).toString( );
    QString pathPix;
    ( fileName != QLatin1String( ConveyanceConstats::NAME_EMPTY_IMG_ICON ) )
	? pathPix = QString( QDir::currentPath( ) + "/" + ConveyanceConstats::NAME_DIR_LOGOBRANDS + "/" + fileName )
	: pathPix = QString( ":/img/No_image.png" );
    return QIcon( pathPix );
  }
  if ( role == Qt::UserRole ) {
    return record( index.row( ) ).value( "autobrand_id" );
  }
  return QSqlQueryModel::data( index, role );
}

ComboBoxCarBrand::ComboBoxCarBrand( QWidget * parent ) : QComboBox( parent ) {
  // init( );
  model = new CarBrandSqlQueryModel;
  setModel( model );
  setIconSize( { 48, 48 } );
}

void ComboBoxCarBrand::update( ) {
  CarBrandSqlQueryModel * delMod = model;
  model = new CarBrandSqlQueryModel;
  setModel( model );
  delMod->deleteLater( );
}
