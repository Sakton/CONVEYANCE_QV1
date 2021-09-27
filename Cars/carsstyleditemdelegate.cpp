#include "carsstyleditemdelegate.h"

CarsStyledItemDelegate::CarsStyledItemDelegate( QObject * parent ) : QStyledItemDelegate( parent ) {}

QSize CarsStyledItemDelegate::sizeHint( const QStyleOptionViewItem & option, const QModelIndex & index ) const {
  if ( index.column( ) == 7 ) {
    return option.widget->sizeHint( ) / 2;
  }
  return QStyledItemDelegate::sizeHint( option, index );
}
