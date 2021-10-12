#include "newuserdatabasedialog.h"
#include "ui_newuserdatabasedialog.h"
#include <QSqlQuery>
#include <QSqlError>
#include "Constants.h"
#include "DataBase/databasecreator.h"

NewUserdataBaseDialog::NewUserdataBaseDialog(QWidget *parent) :
	QDialog(parent),
	ui(new Ui::NewUserdataBaseDialog) {
	ui->setupUi(this);
	createDefaultConnectToDb();
}

NewUserdataBaseDialog::~NewUserdataBaseDialog() {
	delete ui;
}

void NewUserdataBaseDialog::accept() {
	QString nameUser = ui->lineNameUser->text();
	QString pass = ui->linePassword->text();
	QString confirmPass = ui->lineEditConfirmPassword->text();
	if( pass == confirmPass ) {
		QSqlQuery query( QSqlDatabase::database( "POSTGRES" ) );
		QString qs = QString( "CREATE USER %1 WITH SUPERUSER PASSWORD '%2' ;" ).arg(nameUser, pass);
		if( !query.exec( qs ) ) {
			qDebug() << "Error create user" << query.lastError().text() << "\nlastQuery = " << query.lastQuery();
			return;
		}
	} else {
		qDebug() << "Пароли не совпадают";
	}
	QSqlDatabase::database( "NEW_USER" ).removeDatabase( "NEW_USER" );
	return QDialog::accept();
}

void NewUserdataBaseDialog::createDefaultConnectToDb() const {
	DatabaseCreator::defaultConnect();
}
