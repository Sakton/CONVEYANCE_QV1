#ifndef UPDATEORDERDIALOG_H
#define UPDATEORDERDIALOG_H

#include "commonorderform.h"
#include <QSqlRecord>

class UpdateOrderDialog : public CommonOrderForm {
  Q_OBJECT
public:
  UpdateOrderDialog( const QSqlRecord & rec, QWidget * parent = nullptr );

  void initForm( );

private:
  QSqlRecord rec;
};

#endif // UPDATEORDERDIALOG_H
