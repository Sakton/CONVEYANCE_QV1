#ifndef UPDATEADRESSDIALOG_H
#define UPDATEADRESSDIALOG_H

#include <QDialog>

namespace Ui {
class UpdateAdressDialog;
}

class QSqlQueryModel;

class UpdateAdressDialog : public QDialog
{
  Q_OBJECT

public:
  explicit UpdateAdressDialog( int id, QSqlQueryModel *m, QWidget *parent = nullptr );
  ~UpdateAdressDialog( );

  // QDialog interface
public slots:
  void accept( ) override;
  void slotEditCity( );

private:
  void init( );

private:
  Ui::UpdateAdressDialog *ui;
  QSqlQueryModel *model;
  int curId;
};

#endif // UPDATEADRESSDIALOG_H
