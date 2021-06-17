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
  setWindowTitle( tr( "Добавить Адрес" ) );
  setsComboBoxCounry( );

  modelCities = new QSqlQueryModel( this );
  modelCities->setQuery( "SELECT city_name FROM cities ORDER BY city_name", QSqlDatabase::database( "DB" ) );
  ui->comboBoxCity->setModel( modelCities );

  ui->comboBoxType->addItems( QStringList( ) << tr( "Фактический" ) << tr( "Юридический" ) );
}

AddAdress::~AddAdress()
{
  delete ui;
}

// Deutschland, 74321, Bietigheim-Bissingen, Stuttgarter Straße 59

void AddAdress::accept( ) {
  QSqlDatabase db = QSqlDatabase::database( "DB" );
  QString country = ui->comboBoxCountry->currentText( );
  QString city = ui->comboBoxCity->currentText( );
  QString adress = ui->lineEditAdress->text( );
  QString index = ui->lineEditIndex->text( );
  int ind = ui->comboBoxType->currentIndex( );
  QString type = "FACT";
  if ( ind )
    type = "LEGAL";

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
  // this->deleteLater( );
}

void AddAdress::setsComboBoxCounry( ) {
  //  modelCounrys = new QSqlQueryModel( this );
  //  modelCounrys->setQuery( "SELECT country_name, country_id FROM countrys ORDER BY country_name", QSqlDatabase::database( "DB" ) );
  //  ui->comboBoxCountry->setModel( modelCounrys );
}
