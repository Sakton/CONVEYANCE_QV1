#ifndef UPDATECITYDIALOG_H
#define UPDATECITYDIALOG_H

#include <QDialog>

namespace Ui {
class UpdateCityDialog;
}

class UpdateCityDialog : public QDialog
{
  Q_OBJECT

public:
  explicit UpdateCityDialog( const QString &cityName, QWidget *parent = nullptr );
  ~UpdateCityDialog();

  // QDialog interface
public slots:
  void accept( ) override;

private:
  Ui::UpdateCityDialog *ui;
  QString curCity;
};

#endif // UPDATECITYDIALOG_H
