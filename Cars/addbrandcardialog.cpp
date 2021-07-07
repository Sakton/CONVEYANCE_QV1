#include "addbrandcardialog.h"
#include "Constants.h"
#include "ui_addbrandcardialog.h"

#include <QDir>
#include <QFileDialog>
#include <QMessageBox>
#include <QSqlError>
#include <QSqlQuery>

AddBrandCarDialog::AddBrandCarDialog( QWidget *parent ) : QDialog( parent ), ui( new Ui::AddBrandCarDialog ) {
  ui->setupUi(this);
  setWindowTitle( tr( "ДОБАВИТЬ МАРКУ АВТОМОБИЛЯ" ) );
  connect( ui->pushButtonChangeLogo, QOverload< bool >::of( &QPushButton::clicked ), this, QOverload<>::of( &AddBrandCarDialog::slotChangeLogo ) );
  init( );
}

AddBrandCarDialog::~AddBrandCarDialog( ) {
  delete ui;
}

void AddBrandCarDialog::init( ) {
  QPixmap pix( QString { ":/img/No_image.png" } );
  pix = pix.scaled( pix.size( ) / 2 );
  ui->labelLogo->setPixmap( pix );
}

void AddBrandCarDialog::slotChangeLogo( ) {
  QString imgFile = QFileDialog::getOpenFileName( this, tr( "ОТКРЫТЬ ФАЙЛ" ), "../", tr( "Image(*.png, *.jpg)" ) );
  if ( !imgFile.isEmpty( ) ) {
    QPixmap imgPix( imgFile );
    imgPix = imgPix.scaled( ui->labelLogo->sizeHint( ) );
    ui->labelLogo->setPixmap( imgPix );
    ui->labelLogo->setProperty( "ImgPath", imgFile );
    update( );
  }
}

void AddBrandCarDialog::accept( ) {
  QString nameBrand = ui->lineEditBrand->text( );
  if ( nameBrand.isEmpty( ) ) {
    QMessageBox::critical( this, tr( "ПУСТОЕ ПОЛЕ" ), tr( "ПОЛЕ БРЕНД НЕ МОЖЕТ БЫТЬ ПУСТЫМ" ) );
    return QDialog::accept( );
  }
  QString imgPath = ui->labelLogo->property( "ImgPath" ).toString( );
  QString fileNameIcon { "" };
  if ( !imgPath.isEmpty( ) ) {
    QFileInfo fInfo( imgPath );
    fileNameIcon = fInfo.fileName( );
    QDir dir;
    if ( !dir.exists( QDir::currentPath( ) + "/" + NAME_DIR_LOGOBRANDS ) ) {
      dir.mkdir( QDir::currentPath( ) + "/" + NAME_DIR_LOGOBRANDS );
    }
    QString path = QDir::currentPath( ) + "/" + NAME_DIR_LOGOBRANDS + "/" + fileNameIcon;
    bool ok = ui->labelLogo->pixmap( ).save( QDir::currentPath( ) + "/" + NAME_DIR_LOGOBRANDS + "/" + fileNameIcon );
    if ( !ok ) {
      QMessageBox::warning( this, tr( "ОШИБКА СОХРАНЕНИЯ" ), tr( "ОШИБКА СОХРАНЕНИЯ ФАЙЛА процесс прерван" ) );
      return QDialog::accept( );
    }
  }
  insertDb( nameBrand, fileNameIcon );
  QDialog::accept( );
}

void AddBrandCarDialog::insertDb( const QString &nameBrand, const QString &fileNameIcon ) {
  QString qs = QString( "INSERT INTO auto.autobrands (autobrand_name, autobrand_icon) VALUES ('%1', '%2')" ).arg( nameBrand ).arg( fileNameIcon );
  QSqlQuery query( QSqlDatabase::database( NAME_DB_ALL ) );
  if ( !query.exec( qs ) ) {
    QMessageBox::critical( this, tr( "ОШИБКА ВСТАВКИ В БД" ), query.lastError( ).text( ) );
  }
}
