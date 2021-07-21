#ifndef ADDFUNCTIONEMPLOEEDIALOG_H
#define ADDFUNCTIONEMPLOEEDIALOG_H

#include <QDialog>

namespace Ui {
class AddFunctionEmploeeDialog;
}

class AddFunctionEmploeeDialog : public QDialog {
  Q_OBJECT

public:
  explicit AddFunctionEmploeeDialog( QWidget * parent = nullptr );
  ~AddFunctionEmploeeDialog( );

  // QDialog interface
public slots:
  void accept( ) override;

private:
  Ui::AddFunctionEmploeeDialog * ui;
};

#endif // ADDFUNCTIONEMPLOEEDIALOG_H
