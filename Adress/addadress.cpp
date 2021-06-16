#include "addadress.h"
#include "ui_addadress.h"

#include <QSqlDatabase>
#include <QSqlQuery>
#include <QSqlQueryModel>

AddAdress::AddAdress(QWidget *parent) :
      QDialog(parent),
      ui(new Ui::AddAdress)
{
  ui->setupUi(this);
  modelCounrys = new QSqlQueryModel( this );
  modelCounrys->setQuery( "SELECT country_name FROM countrys ORDER BY countrys", QSqlDatabase::database( "DB" ) );
  // TODO ТУТ
  ui->comboBoxType->addItems( QStringList( ) << tr( "Фактический" ) << tr( "Юридический" ) );
}

AddAdress::~AddAdress()
{
  delete ui;
}

// Deutschland, 74321, Bietigheim-Bissingen, Stuttgarter Straße 59

void AddAdress::accept( ) {
  QSqlDatabase db = QSqlDatabase::database( "DB" );
  QString country = ui->lineCountry->text( );
  QString city = ui->lineEditCity->text( );
  QString adress = ui->lineEditAdress->text( );
  QString index = ui->lineEditIndex->text( );
  int ind = ui->comboBoxType->currentIndex( );
  QString type = "FACT";
  if ( ind )
    type = "LEGAL";

  //  QSqlQuery addCountryQuery( db );
  //  addCountryQuery.prepare( "INSERT INTO countrys ( country_name ) VALUES (:country)" );
  //  addCountryQuery.bindValue( ":country", country );
  //  addCountryQuery.exec( );

  //  QSqlQuery addCityQuery( db );
  //  addCityQuery.prepare( "INSERT INTO cities ( city_name ) VALUES (:city)" );
  //  addCityQuery.bindValue( ":city", city );
  //  addCityQuery.exec( );

  //  QSqlQuery addStreetQuery( db );
  //  addStreetQuery.prepare( "INSERT INTO streets ( street_name ) VALUES (:adres)" );
  //  addStreetQuery.bindValue( ":adres", adress );
  //  addStreetQuery.exec( );

  QSqlQuery query( db );
  query.prepare( "SELECT insert_adress(:country, :city, :adress, :type);" );
  query.bindValue( ":country", country );
  query.bindValue( ":city", city );
  query.bindValue( ":adress", adress );
  query.bindValue( ":type", type );
  if ( !query.exec( ) )
    qDebug( ) << "Choto ne tak";
}

void AddAdress::reject( ) {
  qDebug( ) << "regect";
  this->deleteLater( );
}
