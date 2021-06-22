#ifndef CITYDIALOG_H
#define CITYDIALOG_H

#include <QDialog>

namespace Ui {
class CityDialog;
}

class CityDialog : public QDialog
{
  Q_OBJECT

public:
  explicit CityDialog(QWidget *parent = nullptr);
  ~CityDialog();

private:
  Ui::CityDialog *ui;
};

#endif // CITYDIALOG_H
