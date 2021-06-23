#include "adresscountrydelegate.h"

#include <QLabel>

AdressCountryDelegate::AdressCountryDelegate( QObject *parent ) : QStyledItemDelegate( parent ) {
}

QWidget *AdressCountryDelegate::createEditor( QWidget *parent, const QStyleOptionViewItem &option, const QModelIndex &index ) const {
  //  QLabel *label = new QLabel( parent );
  //  label->setPixmap( QPixmap( "qrc:/img/flagCountrys/austria.png" ) );
  //  label->setText( "ABCTРИЯ" );
  //  return label;
  return new QLabel( "<img source = \":/img/flagCountrys/austria.png\"><H3>AUSTRIA</H3></img>" );
}

// void AdressCountryDelegate::paint( QPainter *painter, const QStyleOptionViewItem &option, const QModelIndex &index ) const {
//  if ( !index.isValid( ) )
//    return;
//  QStyleOptionViewItem op = option;
//}
