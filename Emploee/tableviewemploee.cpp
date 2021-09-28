#include "tableviewemploee.h"
#include <QMenu>
#include <QContextMenuEvent>


TableViewEmploee::TableViewEmploee(QWidget * parent) : QTableView(parent), contextMenu{ nullptr } {
}

void TableViewEmploee::setContextMenu( QMenu * cntxtMenu ) {
	if( cntxtMenu ) {
		contextMenu = cntxtMenu;
	}
}

void TableViewEmploee::contextMenuEvent(QContextMenuEvent * event) {
	if( contextMenu ) {
		contextMenu->exec( event->globalPos() );
	}
}
