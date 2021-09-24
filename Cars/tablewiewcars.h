#ifndef TABLEWIEWCARS_H
#define TABLEWIEWCARS_H

class QMenu;

#include <QTableView>

class TableWiewCars : public QTableView {
  Q_OBJECT

public:
  explicit TableWiewCars( QWidget * parent = nullptr );
  void setContextMenu( QMenu * menu );
  // QWidget interface
protected:
  void contextMenuEvent( QContextMenuEvent * event ) override;

private:
  QMenu * contextMenu { nullptr };
};

#endif // TABLEWIEWCARS_H
