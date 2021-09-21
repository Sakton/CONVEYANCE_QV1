#include "commoncardialog.h"
#include "ElementsWidgets/comboboxcarcategories.h"
#include "ui_commoncardialog.h"
#include <QComboBox>
#include <QModelIndex>

CommonCarDialog::CommonCarDialog( QWidget * parent ) : QDialog( parent ), ui( new Ui::CommonCarDialog ) { ui->setupUi( this ); }

CommonCarDialog::~CommonCarDialog( ) { delete ui; }

void CommonCarDialog::slotDescriptionCategoryCar( int indexComboBox ) {
  ui->labelCategoryName->setText( ui->comboBoxCarCategories->itemData( indexComboBox, Qt::UserRole + 1 ).toString( ) );
}
