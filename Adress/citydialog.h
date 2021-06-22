#ifndef CITYDIALOG_H
#define CITYDIALOG_H

#include <QDialog>

// TODO + ВАЛИДАТОР

namespace Ui {
class CityDialog;
}

class CityDialog : public QDialog
{
  Q_OBJECT

public:
  explicit CityDialog( int indexList = 0, QWidget *parent = nullptr );
  ~CityDialog( );

public slots:
  void slotAccepted( );

private:
  void connecteds( );
  void podgotovkaNameCity( QString &s );
  // void setsValidator( );

signals:
  void signalChangedIndex( int changedIndexFact );
  //В случае, если комбобокс редактируемый, то пользователь может сметить страну, и ввести город
  //этот сигнал испускается с фактическим измененным индексом

private:
  Ui::CityDialog *ui;
};

#endif // CITYDIALOG_H
