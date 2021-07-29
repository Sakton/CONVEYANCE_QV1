#ifndef MAINWINDOWTABWIDGET_H
#define MAINWINDOWTABWIDGET_H

#include <QTabWidget>

class MainWindowTabWidget : public QTabWidget
{
  Q_OBJECT
public:
  explicit MainWindowTabWidget( QWidget * parent );

public slots:
  void slotClosetab( int index );
  // QWidget interface

private:
  void createConnected( );

protected:
  void showEvent( QShowEvent * event ) override;
};

#endif // MAINWINDOWTABWIDGET_H
