#ifndef CREATEORDERDIALOG_H
#define CREATEORDERDIALOG_H

#include "commomorderform.h"
// #include <QDialog>

// namespace Ui {
// class CreateOrderDialog;
//}

class CreateOrderDialog : public CommomOrderForm {
  Q_OBJECT

public:
  explicit CreateOrderDialog( QWidget * parent = nullptr );

public slots:
  void accept( ) override;
};

#endif // CREATEORDERDIALOG_H
