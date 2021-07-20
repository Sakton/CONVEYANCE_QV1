#ifndef ADDEMPLOEEDIALOG_H
#define ADDEMPLOEEDIALOG_H

#include <QDialog>

namespace Ui {
class AddEmploeeDialog;
}

class AddEmploeeDialog : public QDialog {
  Q_OBJECT

public:
  explicit AddEmploeeDialog( QWidget * parent = nullptr );
  ~AddEmploeeDialog( );

  // QDialog interface
public slots:
  void accept( ) override;

private:
  Ui::AddEmploeeDialog * ui;
};

#endif // ADDEMPLOEEDIALOG_H
