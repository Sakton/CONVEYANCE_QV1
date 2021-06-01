#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>

namespace Ui {
class MainWindow;
}

class MainWindow : public QMainWindow
{
  Q_OBJECT
  
 public:
  explicit MainWindow( QWidget *parent = nullptr );
  ~MainWindow( );

  // QWidget interface
protected:
  void closeEvent( QCloseEvent *event ) override;

  // public:
  //  QMenu *createPopupMenu( ) override;

public slots:

private:
  void writeSettings( );
  void readSettings( );

private:
  Ui::MainWindow *ui;
};

#endif // MAINWINDOW_H
