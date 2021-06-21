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
  connected( );
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

void AddAdress::slotSelectsItemsComboBox( int idx ) {
  qDebug( ) << "index = " << idx;
  int id = ui->comboBoxCountry->itemData( idx ).toInt( );
  qDebug( ) << "id = " << id;
}

void AddAdress::setsComboBoxCity( int id ) {
  QSqlQuery query( QSqlDatabase::database( "DB" ) );
  QSqlQueryModel modelCity;
}

void AddAdress::connected( ) {
  connect( ui->comboBoxCountry, QOverload< int >::of( &QComboBox::currentIndexChanged ), this,
           QOverload< int >::of( &AddAdress::slotSelectsItemsComboBox ) );
}
