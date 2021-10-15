#include "autorizationdialog.h"
#include "ui_autorizationdialog.h"
#include "newuserdatabasedialog.h"
#include <QSqlDatabase>
#include <QSqlError>
#include "Constants.h"
#include <QDebug>

AutorizationDialog::AutorizationDialog(QWidget *parent) :
	QDialog(parent),
	ui(new Ui::AutorizationDialog) {
	ui->setupUi(this);
}

AutorizationDialog::~AutorizationDialog() {
	delete ui;
}

void AutorizationDialog::accept() {
	QSqlDatabase db = QSqlDatabase::database(ConveyanceConstats::NAME_DB_ALL);
	if( !db.isValid() ){
		db = QSqlDatabase::addDatabase("QPSQL", ConveyanceConstats::NAME_DB_ALL );
	}
	db.setDatabaseName( ConveyanceConstats::NAME_DATABASE_IN_SUBD );
	db.setHostName( "127.0.0.1" );
	if ( !db.open( ui->lineEditUser->text().toLower(), ui->lineEditPass->text().toLower() ) ) {
		qDebug() << "ERROR DB autorization: " << db.lastError().text();
		return;
	}
	return QDialog::accept();
}

void AutorizationDialog::registerNewUser() {
	NewUserdataBaseDialog newUserDialog( this );
	newUserDialog.exec();
}

void AutorizationDialog::reject() {
	exit(0);
}
