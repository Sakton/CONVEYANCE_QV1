#include "adddriverdialog.h"
#include "Emploee/addemploeedialog.h"
#include "ui_addemploeedialog.h"

AddDriverDialog::AddDriverDialog( QWidget * parent ) : AddEmploeeDialog( parent ) {
  ui->pushButtonAddFunction->setEnabled( false );
  ui->comboBoxFunctionWork->setCurrentIndex( ui->comboBoxFunctionWork->findText( "Водитель" ) );
  ui->comboBoxFunctionWork->setEnabled( false );
}
