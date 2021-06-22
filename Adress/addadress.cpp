#include "addadress.h"
#include "Constants.h"
#include "ui_addadress.h"

#include "citydialog.h"
#include <QMessageBox>
#include <QSqlDatabase>
#include <QSqlQuery>
#include <QSqlQueryModel>
#include <algorithm>

AddAdress::AddAdress(QWidget *parent) :
      QDialog(parent),
      ui(new Ui::AddAdress)
{
  ui->setupUi(this);
  setWindowTitle( tr( "Добавить Адрес" ) );
  connecteds( );
  ui->comboBoxType->addItems( QStringList( ) << tr( "Фактический" ) << tr( "Юридический" ) );
  ui->comboBoxCity->getCity( ui->comboBoxCountry->itemData( 0 ).toInt( ) ); //сразу выбираем города по 0 индексу
}

AddAdress::~AddAdress()
{
  delete ui;
}

// Deutschland, 74321, Bietigheim-Bissingen, Stuttgarter Straße 59

void AddAdress::slotAccept( ) {
  QSqlDatabase db = QSqlDatabase::database( NAME_DB_ALL );
  QString country = ui->comboBoxCountry->currentText( );
  QString city = ui->comboBoxCity->currentText( );
  QString adress = ui->lineEditAdress->text( ).simplified( );
  QString index = ui->lineEditIndex->text( ).simplified( );
  int ind = ui->comboBoxType->currentIndex( );
  QString type = "FACT";
  if ( ind )
    type = "LEGAL";

  QSqlQuery query( db );
  query.prepare( "SELECT insert_adress(:country, :city, :adress, :adress_index, :type);" );
  query.bindValue( ":country", country );
  query.bindValue( ":city", city );
  query.bindValue( ":adress", adress );
  query.bindValue( ":adress_index", index );
  query.bindValue( ":type", type );
  if ( !query.exec( ) )
    QMessageBox::warning( this, "ERROR", "Error add adress", QMessageBox::StandardButton::Ok );
}

void AddAdress::slotSelectCountry( int idx ) {
  ui->comboBoxCity->getCity( ui->comboBoxCountry->itemData( idx ).toInt( ) );
}

void AddAdress::slotClickedAddCityButton( ) {
  CityDialog addDialog( ui->comboBoxCountry->currentIndex( ), this );
  connect( &addDialog, QOverload< int >::of( &CityDialog::finished ), this, QOverload< int >::of( &AddAdress::slotFinishedAddingCity ) );
  connect( &addDialog, QOverload< int >::of( &CityDialog::signalChangedIndex ), this, QOverload< int >::of( &AddAdress::slotFactIndexAddingCity ) );
  addDialog.setWindowModality( Qt::ApplicationModal );
  addDialog.exec( );
}

void AddAdress::slotFinishedAddingCity( int resAdding ) {
  qDebug( ) << "resAdding = " << resAdding;
}

void AddAdress::slotFactIndexAddingCity( int factIndexAdding ) {
  ui->comboBoxCountry->setCurrentIndex( factIndexAdding );
  ui->comboBoxCity->getCity( ui->comboBoxCountry->itemData( factIndexAdding ).toInt( ) );
}

void AddAdress::connecteds( ) {
  connect( ui->buttonBox, QOverload<>::of( &QDialogButtonBox::accepted ), this, QOverload<>::of( &AddAdress::slotAccept ) );
  connect( ui->comboBoxCountry, QOverload< int >::of( &QComboBox::currentIndexChanged ), this,
           QOverload< int >::of( &AddAdress::slotSelectCountry ) );
  connect( ui->pushButtonAddCity, QOverload< bool >::of( &QPushButton::clicked ), this, QOverload<>::of( &AddAdress::slotClickedAddCityButton ) );
}
