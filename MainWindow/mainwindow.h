#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>

class QToolBar;

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
  void contextMenuEvent( QContextMenuEvent *event ) override;

public slots:

private:
  void writeSettings( );
  void readSettings( );
  void createToolBar( );
  void createStatusBar( );

  void createDatabaseConnection( );

private:
  Ui::MainWindow *ui;
  QToolBar *tool;
};

#endif // MAINWINDOW_H
