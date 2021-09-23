#include "commoncardialog.h"
#include "Constants.h"
#include "ElementsWidgets/comboboxcarcategories.h"
#include "addbrandcardialog.h"
#include "ui_commoncardialog.h"
#include <QComboBox>
#include <QModelIndex>
#include <QSqlQuery>

CommonCarDialog::CommonCarDialog( QWidget * parent ) : QDialog( parent ), ui( new Ui::CommonCarDialog ) {
  ui->setupUi( this );
  ui->groupBoxSemitrailers->hide( );
}

CommonCarDialog::~CommonCarDialog( ) { delete ui; }

void CommonCarDialog::accept( ) {
  // read data
  QString vin = ui->lineEditVin->text( );

  // *****
  // QString qs = QString( "INSERT INTO cars." );
  QSqlQuery query( QSqlDatabase::database( ConveyanceConstats::NAME_DB_ALL ) );
  query.prepare( "INSERT INTO cars." );
  // query.bindValue();
}

void CommonCarDialog::slotDescriptionCategoryCar( ) {
  ui->labelCategoryName->setText( ui->comboBoxCarCategories->currentData( CarCategoriesRoles::AUTOCATEGORY_NAME ).toString( ) );
  QString symbol = ui->comboBoxCarCategories->currentData( CarCategoriesRoles::AUTOCATEGORY_SYMBOL ).toString( );
  if ( symbol == "C" || symbol == "C1" || symbol == "C1E" || symbol == "CE" ) {
    ui->groupBoxSemitrailers->show( );
  } else {
    ui->groupBoxSemitrailers->hide( );
  }
}

void CommonCarDialog::slotClickedButtonAddBrandCar( ) {
  AddBrandCarDialog addDialog;
  if ( addDialog.exec( ) )
    ui->comboBoxCarBrand->update( );
}
