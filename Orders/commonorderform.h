#ifndef COMMONORDERFORM_H
#define COMMONORDERFORM_H

#include <QDialog>

namespace Ui {
class CommonOrderForm;
}

class CommonOrderForm : public QDialog {
  Q_OBJECT

public:
  enum class Regim { ADD, UPD };
  explicit CommonOrderForm( Regim regim = Regim::ADD, QWidget * parent = nullptr );
  ~CommonOrderForm( );

public slots:
  void slotAddShipper( );
  void slotAddDriver( );
  void slotCostChanged( double cost );
  void slotArrivalChanged( int arrival );
  void slotRouteChanged( int route );

private:
  void connects( );
  double ante( double cost, int path );

protected:
  Ui::CommonOrderForm * ui;
  Regim r;
};

#endif // COMMONORDERFORM_H
