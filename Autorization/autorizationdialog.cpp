#include "autorizationdialog.h"
#include "ui_autorizationdialog.h"
#include <QSqlDatabase>

AutorizationDialog::AutorizationDialog(QWidget *parent) :
	QDialog(parent),
	ui(new Ui::AutorizationDialog)
{
	ui->setupUi(this);
}

AutorizationDialog::~AutorizationDialog()
{
	delete ui;
}

void AutorizationDialog::accept()
{
	QString name = ui->lineEditUser->text();
	QString pass = ui->lineEditPass->text();

	QSqlDatabase db = QSqlDatabase::addDatabase("QPSQL");
	// db.hostName();

}
