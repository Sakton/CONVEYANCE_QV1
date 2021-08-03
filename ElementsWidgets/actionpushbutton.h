#ifndef ACTIONPUSHBUTTON_H
#define ACTIONPUSHBUTTON_H

#include <QPushButton>

/*
  QPushButton не позволяет настраивать себя с помощью QAction .
  Расширение QPushButton.
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
