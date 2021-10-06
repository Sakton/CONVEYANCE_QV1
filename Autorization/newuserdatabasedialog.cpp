#include "newuserdatabasedialog.h"
#include "ui_newuserdatabasedialog.h"
#include <QSqlQuery>
#include <QSqlError>

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
	static int i = 0;
	qDebug() << "i = " << i++;
	QString nameUser = ui->lineNameUser->text();
	QString pass = ui->linePassword->text();
	QString confirmPass = ui->lineEditConfirmPassword->text();
	if( pass == confirmPass ) {
		QSqlQuery query( QSqlDatabase::database( "POSTGRES" ) );
		QString qs = QString( "CREATE USER %1 WITH PASSWORD '%2';" ).arg(nameUser).arg(pass);
//		query.prepare("CREATE USER :name WITH PASSWORD :password");
//		query.bindValue( ":name", nameUser );
//		query.bindValue( ":password", pass );
		if( !query.exec( qs ) ) {
			qDebug() << "Error create user" << query.lastError().text() << "\nlastQuery = " << query.lastQuery();
			return;
		}
	} else {
		qDebug() << "Пароли не совпадают";
	}
	return QDialog::accept();
}
