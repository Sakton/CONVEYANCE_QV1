#ifndef TABLEVIEWEMPLOEE_H
#define TABLEVIEWEMPLOEE_H

#include <QTableView>

class TableViewEmploee : public QTableView
{
		Q_OBJECT
	public:
		TableViewEmploee( QWidget * parent = nullptr );
		void setContextMenu( QMenu * cntxtMenu );
	protected:
		void contextMenuEvent(QContextMenuEvent * event) override;

	private:
		QMenu * contextMenu;
};

#endif // TABLEVIEWEMPLOEE_H
