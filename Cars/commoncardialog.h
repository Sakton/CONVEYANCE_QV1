#ifndef COMMONCARDIALOG_H
#define COMMONCARDIALOG_H

#include <QDialog>

namespace Ui {
class CommonCarDialog;
}

class CommonCarDialog : public QDialog {
  Q_OBJECT

public:
  explicit CommonCarDialog( QWidget * parent = nullptr );
  ~CommonCarDialog( );
  void connections( );

public slots:
  void slotDescriptionCategoryCar( int indexComboBox );

private:
  Ui::CommonCarDialog * ui;
};

#endif // COMMONCARDIALOG_H
