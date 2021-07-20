#include "addemploeedialog.h"
#include "ui_addemploeedialog.h"

AddEmploeeDialog::AddEmploeeDialog( QWidget * parent ) : QDialog( parent ), ui( new Ui::AddEmploeeDialog ) { ui->setupUi( this ); }

AddEmploeeDialog::~AddEmploeeDialog( ) { delete ui; }

void AddEmploeeDialog::accept( ) { QDialog::accept( ); }
