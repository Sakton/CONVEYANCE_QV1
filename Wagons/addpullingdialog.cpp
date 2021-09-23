#include "addpullingdialog.h"
#include "ui_addpullingdialog.h"

AddPullingDialog::AddPullingDialog( QWidget * parent ) : QDialog( parent ), ui( new Ui::AddPullingDialog ) { ui->setupUi( this ); }

AddPullingDialog::~AddPullingDialog( ) { delete ui; }
