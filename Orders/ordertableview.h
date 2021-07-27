#ifndef ORDERTABLEVIEW_H
#define ORDERTABLEVIEW_H

#include <QTableView>

class OrderTableView : public QTableView
{
  Q_OBJECT
public:
  explicit OrderTableView( QWidget * parent = nullptr );

  // QWidget interface
protected:
  void contextMenuEvent( QContextMenuEvent * event ) override;
};

#endif // ORDERTABLEVIEW_H
