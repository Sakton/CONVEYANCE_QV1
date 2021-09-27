#ifndef ALLCARSWIEWFORM_H
#define ALLCARSWIEWFORM_H

#include <QWidget>

class QMenu;

namespace Ui {
class AllCarsWiewForm;
}

class AllCarsWiewForm : public QWidget {
  Q_OBJECT

public:
  explicit AllCarsWiewForm( QWidget * parent = nullptr );
  ~AllCarsWiewForm( );

  void initButton( );

public slots:
  void slotPushButtonAdd( );

signals:
  void signalPushButtonAdd( );

private:
  QAction * add;
  QAction * del;
  QMenu * contextMenu;

  Ui::AllCarsWiewForm * ui;
};

#endif // ALLCARSWIEWFORM_H
