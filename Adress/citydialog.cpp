#include "citydialog.h"
#include "Constants.h"
#include "ui_citydialog.h"

#include <QMessageBox>
#include <QRegularExpressionValidator>
#include <QSqlError>
#include <QSqlQuery>

CityDialog::CityDialog( int indexList, QWidget *parent ) : QDialog( parent ), ui( new Ui::CityDialog ) {
  ui->setupUi(this);
  setWindowTitle( tr( "ДОБАВИТЬ ГОРОД" ) );
  ui->comboBoxCountrys->setCurrentIndex( indexList );
}

CityDialog::~CityDialog( ) {
  delete ui;
}

void CityDialog::accept( ) {
  QString city = ui->lineEditEnterCity->text( ).simplified( );
  podgotovkaNameCity( city );
  int idCountry = ui->comboBoxCountrys->itemData( ui->comboBoxCountrys->currentIndex( ) ).toInt( );
  QSqlQuery query( QSqlDatabase::database( NAME_DB_ALL ) );
  QString qs = QString( "SELECT addCity('%1', %2);" ).arg( city ).arg( idCountry );
  if( !query.exec( qs ) ) {
    QMessageBox::warning( this, "ERROR INSERT", "Error insert city", QMessageBox::StandardButton::Ok );
  }
  emit signalChangedIndex( ui->comboBoxCountrys->currentData( ).toInt( ) );
  //если в вызванном дилоге пользователь меняет город на другой, сообщаем это родительскому виджету
  QDialog::accept( );
}

void CityDialog::reject( ) {
  QDialog::reject( );
}

void CityDialog::podgotovkaNameCity( QString &s ) {
  std::transform( s.begin( ), s.end( ), s.begin( ), []( QChar ch ) { return ch.toLower( ); } );
  s.front( ) = s.front( ).toUpper( );
}
