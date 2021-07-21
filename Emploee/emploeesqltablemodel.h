#ifndef EMPLOEESQLTABLEMODEL_H
#define EMPLOEESQLTABLEMODEL_H

#include <QSqlTableModel>

class EmploeeSqlTableModel : public QSqlTableModel {
  Q_OBJECT
public:
  explicit EmploeeSqlTableModel( QObject * parent = nullptr, const QSqlDatabase & db = QSqlDatabase( ) );

  // QAbstractItemModel interface
public:
  QVariant data( const QModelIndex & index, int role ) const override;
};

#endif // EMPLOEESQLTABLEMODEL_H
