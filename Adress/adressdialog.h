#ifndef ADRESSDIALOG_H
#define ADRESSDIALOG_H

#include <QDialog>

namespace Ui {
class AdressDialog;
}

class QTableView;
class QSqlTableModel;

class AdressDialog : public QDialog
{
  Q_OBJECT

public:
  enum Regim { ADD, UPDATE };
  explicit AdressDialog( QSqlTableModel *tView, Regim rg = ADD, QWidget *parent = nullptr );
  ~AdressDialog( );

public slots:
  void slotAddCity( );
  void slotSetCountry( const QString & countryName );
  void slotCountryIndexChanged( int idx );
  // QDialog interface
  void accept( ) override;
  void reject( ) override;

private:
  void addRecord( );
  void updateRecord( );
  void readForm( );
  void setRegimWindowTitle( );

signals:
  void signalUpdateTableToDb( );

private:
  Ui::AdressDialog * ui;
  QSqlTableModel *tVw;
  Regim regim;
  QStringList poles;
};

#endif // ADRESSDIALOG_H
