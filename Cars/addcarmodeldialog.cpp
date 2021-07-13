#include "addcarmodeldialog.h"
#include "Constants.h"
#include "ui_addcarmodeldialog.h"
#include <QMessageBox>
#include <QSqlError>
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
  QSqlQuery query( QSqlDatabase::database( NAME_DB_ALL ) );
  QString qs = QString { "CALL auto.add_carmodel ('%1', '%2', '%3');" }.arg( brandName, categoryName, markaName );
  qDebug( ) << qs;
  if( !query.exec( qs ) )
    QMessageBox::warning( this, tr( "ОШИБКА" ), QString { "ВСТАВКА: что то пошло не так: " } + query.lastError( ).text( ) );
  QDialog::accept( );
}
