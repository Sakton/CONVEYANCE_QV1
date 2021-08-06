#include "createorderdialog.h"
#include "Emploee/adddriverdialog.h"
#include "Shippers/addshipperdialog.h"
#include "ui_createorderdialog.h"

#include "Constants.h"
#include <QMessageBox>
#include <QSpinBox>
#include <QSqlError>
#include <QSqlQuery>

CreateOrderDialog::CreateOrderDialog( QWidget* parent )
    : QDialog( parent )
    , ui( new Ui::CreateOrderDialog )
{
    ui->setupUi( this );
    ui->dateEdit->setDate( QDate::currentDate( ) );
    connects( );
}

CreateOrderDialog::~CreateOrderDialog( )
{
    delete ui;
}

void CreateOrderDialog::accept( )
{
    //**** ЧАСТЬ ОРДЕР
    QDate data = ui->dateEdit->date( );
    QString numberContract = ui->lineEditnumberContract->text( );
    if ( numberContract.isEmpty( ) ) {
        QMessageBox::warning( this, tr( "Пустое поле" ), tr( "ПОЛЕ \"ДОГОВОР\": НЕ МОЖЕТ БЫТЬ ПУСТЫМ" ) );
        return;
    }
    int idShipper = ui->comboBoxShippers->currentData( ).toInt( );
    int idDriver = ui->comboBoxDriver->currentData( ).toInt( );
    //**** заметки
    QString text = ui->plainTextEditNote->toPlainText( );

    //**** ЧАСТЬ ОПЛАТА
    double cost = ui->doubleSpinBoxCost->value( );
    QString paymentPeriod = ui->comboBoxPaymentPeriod->currentText( );
    QString currency = ui->comboBoxCurrency->currentText( );

    //**** ЧАСТЬ МАРШРУТ
    int arrival = ui->spinBoxArrival->value( );
    int route = ui->spinBoxRoute->value( );
    //double ante = ui->doubleSpinBoxAnte->value( );
    double ante = ui->labelAnte->text( ).toDouble( );

    //**** ЧАСТЬ ДОКУМЕНТЫ
    QString postPeriod = ui->comboBoxPostPeriad->currentText( );
    Qt::CheckState twoCopyCMR = ui->checkBox2CopyCMR->checkState( );
    Qt::CheckState originalContract = ui->checkBoxOriginalContract->checkState( );

    QSqlDatabase db = QSqlDatabase::database( NAME_DB_ALL );
    QSqlQuery query( db );
    QString qsToPayment = QString( "SELECT payment.getPayment_id(%1, '%2', '%3') AS idpayment;" ).arg( cost ).arg( paymentPeriod, currency );
    QString qsToRoute = QString( "SELECT route.getRouteId(%1, %2, %3) AS idroute;" ).arg( arrival ).arg( route ).arg( ante );
    QString qsDocuments = QString( "SELECT document.getDocumentId ('%1', %2, %3) AS iddocument;" ).arg( postPeriod ).arg( twoCopyCMR ).arg( originalContract );

    db.transaction( ); //ТРАНЗАКЦИЯ
    query.exec( qsToPayment );
    query.next( );
    int idPayment = query.value( "idpayment" ).toInt( );
    query.exec( qsToRoute );
    query.next( );
    int idRoute = query.value( "idroute" ).toInt( );
    query.exec( qsDocuments );
    query.next( );
    int idDocument = query.value( "iddocument" ).toInt( );
    QString qsInsertOrder = QString( "CALL orders.addOrder(%1, %2, %3, %4, %5, '%6', '%7', '%8');" )
                                .arg( idShipper )
                                .arg( idDriver )
                                .arg( idPayment )
                                .arg( idRoute )
                                .arg( idDocument )
                                .arg( data.toString( ), numberContract, text );
    if ( !query.exec( qsInsertOrder ) ) {
        qDebug( ) << query.lastError( ).text( );
        db.rollback( ); //ОТМЕНИТЬ ТРАНЗАКЦИЮ
    }
    db.commit( ); //ПРИНЯТЬ ТРАНЗАКЦИЮ (функции получения id автоматически вставляют в базу, то есть эта транзакция частично вносит измемнения )
    // TODO тут возможно изменение поведения
    QDialog::accept( );
}

void CreateOrderDialog::slotAddShipper( )
{
    AddShipperDialog dialogAddShipper;
    if ( dialogAddShipper.exec( ) )
        ui->comboBoxShippers->init( );
}

void CreateOrderDialog::slotAddDriver( )
{
    AddDriverDialog dd;
    if ( dd.exec( ) == QDialog::Accepted ) {
        ui->comboBoxDriver->init( );
    }
}

void CreateOrderDialog::slotCostChanged( double cost )
{
    double arrival = ui->spinBoxArrival->value( );
    double route = ui->spinBoxRoute->value( );
    ui->label->setText( QString::number( ante( cost, arrival + route ) ) );
}

void CreateOrderDialog::slotArrivalChanged( int arrival )
{
}

void CreateOrderDialog::slotRouteChanged( int arrival )
{
}

void CreateOrderDialog::connects( )
{
    connect( ui->pushButtonAddShipper, QOverload< bool >::of( &QPushButton::clicked ), this, QOverload<>::of( &CreateOrderDialog::slotAddShipper ) );
    connect( ui->pushButtonAddDriver, QOverload< bool >::of( &QPushButton::clicked ), this, QOverload<>::of( &CreateOrderDialog::slotAddDriver ) );
    connect( ui->doubleSpinBoxCost, QOverload< double >::of( &QDoubleSpinBox::valueChanged ), this, QOverload< double >::of( &CreateOrderDialog::slotCostChanged ) );
    connect( ui->spinBoxArrival, QOverload< int >::of( &QSpinBox::valueChanged ), this, QOverload< int >::of( &CreateOrderDialog::slotArrivalChanged ) );
    connect( ui->spinBoxRoute, QOverload< int >::of( &QSpinBox::valueChanged ), this, QOverload< int >::of( &CreateOrderDialog::slotRouteChanged ) );
}

double CreateOrderDialog::ante( double cost, int path )
{
    return cost / path;
}
