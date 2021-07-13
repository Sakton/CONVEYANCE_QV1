#include "addcarmodeldialog.h"
#include "ui_addcarmodeldialog.h"
#include <QMessageBox>
#include <QSqlQuery>

AddCarModelDialog::AddCarModelDialog( QWidget * parent ) : QDialog( parent ), ui( new Ui::AddCarModelDialog ) {
  ui->setupUi( this );
  setWindowTitle( tr( "Добавить Марку Автомобиля" ) );
}

AddCarModelDialog::~AddCarModelDialog( ) { delete ui; }

void AddCarModelDialog::accept( ) {
  QString brandName = ui->comboBoxBrand->currentText( );
  QString categoryName = ui->comboBoxCategories->currentText( );
  QString markaName = ui->lineEditMarka->text( );
  qDebug( ) << brandName << " " << categoryName << " " << markaName;
  if( markaName.isEmpty( ) ) {
    QMessageBox::warning( this, tr( "ОШИБКА" ), tr( "ПОЛЕ \"МАРКА\" НЕ МОЖЕТ БЫТЬ ПУСТЫМ" ) );
    return; // NOTE фишка работы с диалоговым окном, так как метод перегружается, то тут прерывается его ход и выход из метода,
            // при этом окно открыто
  }
  QDialog::accept( );
}
