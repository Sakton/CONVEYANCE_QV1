#ifndef CREATEORDERDIALOG_H
#define CREATEORDERDIALOG_H

#include <QDialog>

namespace Ui {
class CreateOrderDialog;
}

class CreateOrderDialog : public QDialog {
  Q_OBJECT

public:
  explicit CreateOrderDialog( QWidget *parent = nullptr );
  ~CreateOrderDialog( );

  // QDialog interface
public slots:
  void accept( ) override;

private:
  Ui::CreateOrderDialog *ui;
};

#endif // CREATEORDERDIALOG_H
