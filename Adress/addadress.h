#ifndef ADDADRESS_H
#define ADDADRESS_H

#include <QDialog>

class QSqlQueryModel;

namespace Ui {
class AddAdress;
}

class AddAdress : public QDialog
{
  Q_OBJECT

public:
  explicit AddAdress(QWidget *parent = nullptr);
  ~AddAdress( );

  // QDialog interface
public slots:
  void accept( ) override;
  void reject( ) override;
  void slotSelectCountry( int idx );

private:
  void connected( );

private:
  Ui::AddAdress *ui;
  QSqlQueryModel *modelCounrys;
  QSqlQueryModel *modelCities;
};

// sdfsdfsf

#endif // ADDADRESS_H
