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
  explicit AdressDialog( QSqlTableModel * tView, QWidget * parent = nullptr );
  ~AdressDialog( );

public slots:
  void slotAddCity( );
  void slotSetCountry( const QString & countryName );
  void slotCountryIndexChanged( int idx );

private:
  Ui::AdressDialog * ui;
  QSqlTableModel * tVw;
};

#endif // ADRESSDIALOG_H
