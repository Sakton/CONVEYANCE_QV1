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
  explicit Adress(QWidget *parent = nullptr);
  ~Adress();

private:
  void createTableAdressModel( );

private:
  Ui::Adress *ui;
  QSqlTableModel *model;
};

#endif // ADRESS_H
