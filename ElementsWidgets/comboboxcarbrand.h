#ifndef COMBOBOXCARBRAND_H
#define COMBOBOXCARBRAND_H

#include <QWidget>

namespace Ui {
class comboBoxCarBrand;
}

class comboBoxCarBrand : public QWidget
{
  Q_OBJECT

public:
  explicit comboBoxCarBrand(QWidget *parent = nullptr);
  ~comboBoxCarBrand();

private:
  Ui::comboBoxCarBrand *ui;
};

#endif // COMBOBOXCARBRAND_H
