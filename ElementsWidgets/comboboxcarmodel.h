#ifndef COMBOBOXCARMODEL_H
#define COMBOBOXCARMODEL_H

#include <QComboBox>

#include <QSqlQueryModel>

// ************ MODEL

enum CarModelRole {};

class CarModelSqlQueryModel : public QSqlQueryModel {
public:
  explicit CarModelSqlQueryModel( QObject * parent = nullptr );
  // QAbstractItemModel interface
public:
  QVariant data( const QModelIndex & index, int role ) const override;
};

// ************ COMBOBOX

class ComboBoxCarModel : public QComboBox {
  Q_OBJECT
public:
  ComboBoxCarModel( QWidget *parent = nullptr );
  void init( );
  void update( );
};

#endif // COMBOBOXCARMODEL_H
