#include "adresscountrydelegate.h"

#include <QApplication>
#include <QImage>
#include <QLabel>
#include <QModelIndex>
#include <QPainter>
#include <QSqlRecord>
#include <QSqlTableModel>

void AdressCountryDelegate::paint( QPainter *painter, const QStyleOptionViewItem &option, const QModelIndex &index ) const {
  if ( index.column( ) == 2 ) {
    QStyleOptionViewItem viewItem = option;
    viewItem.text = index.model( )->data( index ).toString( );
    viewItem.icon = QIcon( ":/img/flagCountrys/belarus.png" );
    option.widget->style( )->drawControl( QStyle::CE_ItemViewItem, &viewItem, painter, option.widget );

    if ( option.state == QStyle::State_On ) {
      qDebug( ) << "SELECTED ";
    }

    //    painter->save( );

    //    painter->fillRect( option.rect, Qt::lightGray );
    //    const QSqlTableModel *m = qobject_cast< const QSqlTableModel * >( index.model( ) );
    //    QString fileName;
    //    if ( m ) {
    //      fileName = m->record( index.row( ) ).value( "country_icon" ).toString( );
    //    }
    //    QString pixFile = QString( ":/img/flagCountrys/%1" ).arg( fileName );
    //    QImage pix( pixFile );
    //    pix = pix.scaled( 32, 24 );
    //    int dY = ( option.rect.height( ) - pix.height( ) ) / 2;
    //    painter->drawImage( option.rect.x( ), option.rect.y( ) + dY, pix );
    //    QRect tt( option.rect.x( ) + pix.width( ), option.rect.y( ), option.rect.width( ) - pix.width( ), option.rect.height( ) );
    //    painter->drawText( tt, Qt::AlignCenter, index.model( )->data( index ).toString( ) );

    //    painter->restore( );
  } else {
    return QStyledItemDelegate::paint( painter, option, index );
  }
}
