#include "adresssqltablemodel.h"

#include <QSqlQuery>

AdressSqlTableModel::AdressSqlTableModel( QObject *parent, const QSqlDatabase &db ) : QSqlTableModel( parent, db ) {
  qDebug( ) << "AdressSqlTableModel::db open = " << db.isOpen( );
}

QVariant AdressSqlTableModel::data( const QModelIndex &index, int role ) const {
  if ( role == Qt::TextAlignmentRole )
    return Qt::AlignCenter;
  return QSqlTableModel::data( index, role );
}

// bool AdressSqlTableModel::select( ) {
//  QSqlQuery query;
//  QString qs { "SELECT * FROM adres.adressView;" };
//  return query.exec( qs );
//}
