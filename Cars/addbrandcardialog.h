#ifndef ADDBRANDCARDIALOG_H
#define ADDBRANDCARDIALOG_H

#include <QDialog>

namespace Ui {
class AddBrandCarDialog;
}

class AddBrandCarDialog : public QDialog {
  Q_OBJECT

public:
  explicit AddBrandCarDialog( QWidget *parent = nullptr );
  ~AddBrandCarDialog( );

  void init( );

public slots:
  void slotChangeLogo( );
  // QDialog interface
  void accept( ) override;

private:
  void insertDb( const QString &nameBrand, const QString &fileNameIcon );

private:
  Ui::AddBrandCarDialog *ui;
};

#endif // ADDBRANDCARDIALOG_H
