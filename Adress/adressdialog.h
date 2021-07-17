/*
Далоговое окно добавления адреса
Класс принимает в конструкторе SQL модель
*/

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
  AdressDialog( /*QSqlTableModel *model,*/ QWidget * parent = nullptr );
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

private:
  Ui::AdressDialog * ui;
  // QSqlTableModel *model;
};

#endif // ADRESSDIALOG_H
