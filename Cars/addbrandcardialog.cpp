#include "addbrandcardialog.h"
#include "ui_addbrandcardialog.h"

#include <QFileDialog>

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
  qDebug( ) << "slotChangeLogo";
  QFileDialog file( this );
}
