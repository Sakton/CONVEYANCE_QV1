#ifndef COMMONCARDIALOG //---_H
#define COMMONCARDIALOG //---_H

#include <QDialog>

namespace Ui {
class CommonCarDialog;
}

class CommonCarDialog : public QDialog {
  Q_OBJECT

public:
  explicit CommonCarDialog( QWidget * parent = nullptr );
  ~CommonCarDialog( );

  void accept( ) override;

public slots:
  void slotDescriptionCategoryCar( );
  void slotClickedButtonAddBrandCar( );

private:
  Ui::CommonCarDialog * ui;
};

#endif // COMMONCARDIALOG---_H
