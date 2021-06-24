#ifndef ADRESSCOUNTRYDELEGATE_H
#define ADRESSCOUNTRYDELEGATE_H

#include <QStyledItemDelegate>

class AdressCountryDelegate : public QStyledItemDelegate
{
  Q_OBJECT
  // QAbstractItemDelegate interface
public:
  void paint( QPainter *painter, const QStyleOptionViewItem &option, const QModelIndex &index ) const override;
};

#endif // ADRESSCOUNTRYDELEGATE_H
