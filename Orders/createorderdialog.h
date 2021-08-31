#ifndef CREATEORDERDIALOG_H
#define CREATEORDERDIALOG_H

#include "commonorderform.h"

class CreateOrderDialog : public CommonOrderForm {
  Q_OBJECT

public:
  explicit CreateOrderDialog( QWidget * parent = nullptr );

public slots:
  void accept( ) override;
};

#endif // CREATEORDERDIALOG_H
