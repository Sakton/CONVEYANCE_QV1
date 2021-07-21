#ifndef EMPLOEETABLEVIEW_H
#define EMPLOEETABLEVIEW_H

#include <QWidget>

namespace Ui {
class EmploeeTableView;
}

class EmploeeSqlTableModel;

class EmploeeTableView : public QWidget {
  Q_OBJECT

public:
  explicit EmploeeTableView( QWidget * parent = nullptr );
  ~EmploeeTableView( );
  // QWidget interface
protected:
  void contextMenuEvent( QContextMenuEvent * event ) override;

private:
  Ui::EmploeeTableView * ui;
  EmploeeSqlTableModel * model;
};

#endif // EMPLOEETABLEVIEW_H
