#ifndef COMMONORDERFORM_H
#define COMMONORDERFORM_H

#include <QDialog>
#include <QSqlRecord>

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
  void slotCostChanged( double cost );    //соединение в форме
  void slotArrivalChanged( int arrival ); //соединение в форме
  void slotRouteChanged( int route );     //соединение в форме
  void readRecord( const QSqlRecord & rec );

private:
  void connects( );
  double ante( double cost, int path );

protected:
  Ui::CommonOrderForm * ui;
  Regim r;
};

#endif // COMMONORDERFORM_H
