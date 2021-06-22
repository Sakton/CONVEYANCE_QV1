#ifndef ADRESS_H
#define ADRESS_H

#include <QWidget>

class QSqlTableModel;

namespace Ui {
class Adress;
}

class Adress : public QWidget
{
  Q_OBJECT

public:
  enum Regim { INSERT, UPDATE };
  explicit Adress( QWidget *parent = nullptr );
  explicit Adress( int id, QWidget *parent = nullptr );
  ~Adress();

private:
  void createTableAdressModel( );
  void connecteds( );

private:
  Ui::Adress *ui;
  QSqlTableModel *model;
};

#endif // ADRESS_H
