#include "newuserdatabasedialog.h"
#include "ui_newuserdatabasedialog.h"

NewUserdataBaseDialog::NewUserdataBaseDialog(QWidget *parent) :
	QDialog(parent),
	ui(new Ui::NewUserdataBaseDialog)
{
	ui->setupUi(this);
}

NewUserdataBaseDialog::~NewUserdataBaseDialog()
{
	delete ui;
}

void NewUserdataBaseDialog::accept()
{
	QString nameUser = ui->lineNameUser->text();
	QString pass = ui->linePassword->text();
	QString confirmPass = ui->lineEditConfirmPassword->text();
	if( pass == confirmPass ) {
		QString qs = QString( "CREATE USER %1 WITH " ).arg(nameUser);
	} else {
		qDebug() << "Пароли не совпадают";
	}
}
