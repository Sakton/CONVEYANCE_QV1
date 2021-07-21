#include "comboboxdrivers.h"

#include <QSqlQuery>

ComboBoxDrivers::ComboBoxDrivers( QWidget * parent ) : QComboBox( parent ) {}

void ComboBoxDrivers::init( ) {
  QSqlQuery query;
  QString qs = QString { "SELECT " };
}
