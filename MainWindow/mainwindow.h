#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>

class QToolBar;
class QSignalMapper;

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
	void slotCreateTabWidget( const QString & typeNameWidget );
//  void slotOrderWindow( );
//  void slotCarsWindow( );
//  void slotEmloeeWindow( );

private:
	QPair<bool, int> isAbsentTab( const QString & typeNameWidget ); //проверка наличия, и вернет индекс заодно
	QWidget * fabriqueCreateWindow( const QString &nameWindow );
	void autorizationUser() const;

private:
  void writeSettings( );
  void readSettings( );
  void createStatusBar( );
//  void createDatabaseConnection( );
  void createConnections( );
  void createDatabase( );
	void initSignalMapper( );

private:
  Ui::MainWindow *ui;
	QSignalMapper *map;
};

#endif // MAINWINDOW_H
