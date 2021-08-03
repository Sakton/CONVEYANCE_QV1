#include "actionpushbutton.h"

#include <QAction>

ActionPushButton::ActionPushButton( QWidget * parent ) : QPushButton( parent ), action { nullptr } {}

void ActionPushButton::setAction( QAction * act ) {
  if ( !act )
    return;
  action = act;
  setIcon( act->icon( ) );
  setText( act->text( ) );
  connect( this, QOverload< bool >::of( &QPushButton::clicked ), action, QOverload< bool >::of( &QAction::triggered ) );
}
