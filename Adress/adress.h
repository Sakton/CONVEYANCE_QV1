#ifndef ADRESS_H
#define ADRESS_H

#include <QWidget>

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
  Ui::Adress *ui;
};

#endif // ADRESS_H
