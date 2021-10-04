#include "autorizationdialog.h"
#include "ui_autorizationdialog.h"
#include <QSqlDatabase>
#include <QSqlError>

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
	QString dbName = ui->lineEditNameDb->text();
	QString host = ui->lineHost->text();
	QString userName = ui->lineEditUser->text();
	QString pass = ui->lineEditPass->text();


	QSqlDatabase db = QSqlDatabase::addDatabase("QPSQL");
	db.setDatabaseName(dbName);
	db.setHostName(host);
	db.setUserName(userName);
	db.setPassword(pass);
	if ( !db.open() ){
		qDebug() << "ERROR DB open: " << db.lastError().text();
		qDebug() << "Type Error = " << db.lastError().type();
	} else {
		QDialog::accept();
	}
}
