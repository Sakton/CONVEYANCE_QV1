#include "commoncardialog.h"
#include "ui_commoncardialog.h"

CommonCarDialog::CommonCarDialog( QWidget * parent ) : QDialog( parent ), ui( new Ui::CommonCarDialog ) { ui->setupUi( this ); }

CommonCarDialog::~CommonCarDialog( ) { delete ui; }

void CommonCarDialog::slotDescriptionCategoryCar( int indexComboBox ) {
  qDebug( ) << "CommonCarDialog::slotDescriptionCategoryCar id = " << indexComboBox;
}
