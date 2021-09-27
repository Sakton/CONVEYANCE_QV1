#ifndef CARSSTYLEDITEMDELEGATE_H
#define CARSSTYLEDITEMDELEGATE_H

#include <QStyledItemDelegate>

class CarsStyledItemDelegate : public QStyledItemDelegate {
  Q_OBJECT
public:
  explicit CarsStyledItemDelegate( QObject * parent = nullptr );
  QSize sizeHint( const QStyleOptionViewItem & option, const QModelIndex & index ) const override;
};

#endif // CARSSTYLEDITEMDELEGATE_H
