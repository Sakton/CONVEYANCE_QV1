#ifndef EMPLOEETABLEVIEW_H
#define EMPLOEETABLEVIEW_H

#include <QWidget>

namespace Ui {
class EmploeeTableView;
}

class EmploeeSqlTableModel;
class QAction;

class EmploeeTableView : public QWidget {
	Q_OBJECT

public:
	explicit EmploeeTableView( QWidget * parent = nullptr );
	~EmploeeTableView( );
//protected:
//	void contextMenuEvent( QContextMenuEvent * event ) override;

	private:
		void initMenus();

private:
	Ui::EmploeeTableView * ui;
	EmploeeSqlTableModel * model;
	QAction * add;
	QAction * upd;
	QAction * del;
};

#endif // EMPLOEETABLEVIEW_H
