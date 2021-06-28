#ifndef ADRESSVIEW_H
#define ADRESSVIEW_H

#include <QWidget>

class QSqlTableModel;
class QSqlRelationalTableModel;
class QModelIndex;
class QMenu;

namespace Ui {
class AdressView;
}

class AdressView : public QWidget
{
  Q_OBJECT

public:
  explicit AdressView(QWidget *parent = nullptr);
  ~AdressView( );

public slots:
  void slotSelectedRow( const QModelIndex & indexRowSelected );
  void slotEditActionContextMenu( bool );
  void slotAddActionContextMenu( bool );
  void slotDelActionContextMenu( bool );
  void updateModel( );

private:
  void createModel( );

  // QWidget interface
protected:
  void contextMenuEvent( QContextMenuEvent * event ) override;

private:
  Ui::AdressView *ui;
  QSqlTableModel * model;
  // QSqlRelationalTableModel *rmodel;
  // QModelIndex * selectedIndex;
  // QMenu * contextMenu;
};

#endif // ADRESSVIEW_H
