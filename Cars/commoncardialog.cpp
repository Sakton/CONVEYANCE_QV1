#include "commoncardialog.h"
#include "ui_commoncardialog.h"

CommonCarDialog::CommonCarDialog( QWidget * parent ) : QDialog( parent ), ui( new Ui::CommonCarDialog ) {
  ui->setupUi( this );
  ui->groupBoxSemitrailers->hide( );
}

CommonCarDialog::~CommonCarDialog( ) { delete ui; }


void CommonCarDialog::slotDescriptionCategoryCar( ) {
  ui->labelCategoryName->setText( ui->comboBoxCarCategories->currentData( CarCategoriesRoles::AUTOCATEGORY_NAME ).toString( ) );
  qDebug( ) << ui->comboBoxCarCategories->currentData( CarCategoriesRoles::AUTOCATEGORY_SYMBOL ).toString( );
  QString symbol = ui->comboBoxCarCategories->currentData( CarCategoriesRoles::AUTOCATEGORY_SYMBOL ).toString( );
  if ( symbol == "C" || symbol == "C1" || symbol == "C1E" || symbol == "CE" ) {
    ui->groupBoxSemitrailers->show( );
  } else {
    ui->groupBoxSemitrailers->hide( );
  }

}

void CommonCarDialog::slotClickedButtonAddBrandCar( ) { qDebug( ) << "CommonCarDialog::slodClickedButtonAddBrandCar()"; }
