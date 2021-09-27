#ifndef TABLEWIEWCARS_H
#define TABLEWIEWCARS_H

class QMenu;
class CarSqlTableModel;
// class QSortFilterProxyModel;

#include <QTableView>

class TableWiewCars : public QTableView {
  Q_OBJECT

public:
  explicit TableWiewCars( QWidget * parent = nullptr );
  void setContextMenu( QMenu * menu );

public slots:
  void updateModel( );
  void slotDeleteRecord( );

protected:
  void contextMenuEvent( QContextMenuEvent * event ) override;

private:
  QMenu * contextMenu { nullptr };
  CarSqlTableModel * _model;
};

#endif // TABLEWIEWCARS_H
