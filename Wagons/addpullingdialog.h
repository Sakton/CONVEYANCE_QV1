#ifndef ADDPULLINGDIALOG_H
#define ADDPULLINGDIALOG_H

#include <QDialog>

namespace Ui {
class AddPullingDialog;
}

class AddPullingDialog : public QDialog {
  Q_OBJECT

public:
  explicit AddPullingDialog( QWidget * parent = nullptr );
  ~AddPullingDialog( );

private:
  Ui::AddPullingDialog * ui;
};

#endif // ADDPULLINGDIALOG_H
