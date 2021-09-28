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
  void slotCloseTab( int idx );
  void slotOrderWindow( );
  void slotCarsWindow( );
  void slotEmloeeWindow( );

private:
  void writeSettings( );
  void readSettings( );
  void createStatusBar( );
  void createDatabaseConnection( );
  void createConnections( );
  void createDatabase( );

private:
  Ui::MainWindow *ui;
  // QToolBar *tool;
};

#endif // MAINWINDOW_H
