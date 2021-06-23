#ifndef ADRESSVIEW_H
#define ADRESSVIEW_H

#include <QWidget>

class QSqlTableModel;

namespace Ui {
class AdressView;
}

class AdressView : public QWidget
{
  Q_OBJECT

public:
  explicit AdressView(QWidget *parent = nullptr);
  ~AdressView( );

private:
  void createModel( );

private:
  Ui::AdressView *ui;
  QSqlTableModel *model;
};

#endif // ADRESSVIEW_H
