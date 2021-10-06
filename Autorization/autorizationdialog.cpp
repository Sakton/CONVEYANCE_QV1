#include "autorizationdialog.h"
#include "ui_autorizationdialog.h"
#include <QSqlDatabase>
#include <QSqlError>
#include "Constants.h"

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
	QSqlDatabase db = QSqlDatabase::addDatabase("QPSQL", ConveyanceConstats::NAME_DATABASE_IN_SUBD );
	db.setDatabaseName( ConveyanceConstats::NAME_DATABASE_IN_SUBD );
	if ( !db.open( ui->lineEditUser->text(), ui->lineEditPass->text() ) ) {
		qDebug() << "ERROR DB autorization: " << db.lastError().text();
		return;
	}
		return QDialog::accept();
}
