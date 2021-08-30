#ifndef CREATEORDERDIALOG_H
#define CREATEORDERDIALOG_H

#include <QDialog>

namespace Ui {
class CreateOrderDialog;
}

class CreateOrderDialog : public QDialog {
  Q_OBJECT

public:
  explicit CreateOrderDialog( QWidget * parent = nullptr );
  ~CreateOrderDialog( );

public slots:
  void accept( ) override;
  void slotAddShipper( );
  void slotAddDriver( );
  void slotCostChanged( double cost );
  void slotArrivalChanged( int arrival );
  void slotRouteChanged( int arrival );

  private:
  void connects( );
  double ante( double cost, int path );

private:
  Ui::CreateOrderDialog * ui;
};

#endif // CREATEORDERDIALOG_H
