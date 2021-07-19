/*
Производный класс, для поправки метода data() в части выравнивания данных в представлении
*/

#ifndef ADRESSSQLTABLEMODEL_H
#define ADRESSSQLTABLEMODEL_H

#include <QSqlTableModel>

class AdressSqlTableModel : public QSqlTableModel {
  Q_OBJECT
public:
  explicit AdressSqlTableModel( QObject *parent = nullptr, const QSqlDatabase &db = QSqlDatabase( ) );
  // QAbstractItemModel interface
public:
  QVariant data( const QModelIndex &index, int role ) const override;

  //  // QSqlTableModel interface
  // public slots:
  //  bool select( ) override;
};

#endif // ADRESSSQLTABLEMODEL_H
