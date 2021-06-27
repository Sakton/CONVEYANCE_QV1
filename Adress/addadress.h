#ifndef ADDADRESS_H
#define ADDADRESS_H

// TODO + ВАЛИДАТОРЫ

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

public slots:
  // QDialog interface
  void accept( ) override;
  void reject( ) override;
  void slotAccept( );
  void slotSelectCountry( int idx );
  void slotClickedAddCityButton( );
  void slotFinishedAddingCity( int resAdding );
  void slotFactIndexAddingCity( int factIndexAdding );

private:
  void connecteds( );

private:
  Ui::AddAdress *ui;
  QSqlQueryModel *modelCounrys;
  QSqlQueryModel * modelCities;
};

// sdfsdfsf

#endif // ADDADRESS_H
