#ifndef ACTIONPUSHBUTTON_H
#define ACTIONPUSHBUTTON_H

#include <QPushButton>

/*
  QPushButton не позволяет настраивать себя с помощью QAction .
  В случае, когда вам нужно поделиться QAction между различными компонентами, такими как меню, кнопки и т. Д.
  расширить класс QPushButton.
*/

class QAction;

class ActionPushButton : public QPushButton
{
  Q_OBJECT
public:
  explicit ActionPushButton( QWidget * parent = nullptr );
  void setAction( QAction * act );

private:
  QAction * action;
};

#endif // ACTIONPUSHBUTTON_H
