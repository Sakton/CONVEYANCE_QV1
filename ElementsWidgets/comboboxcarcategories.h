#ifndef COMBOBOXCARCATEGORIES_H
#define COMBOBOXCARCATEGORIES_H

#include <QComboBox>

#include <QSqlQueryModel>

class CarCategoriesSqlQueryModel : public QSqlQueryModel {
  Q_OBJECT
public:
  explicit CarCategoriesSqlQueryModel( QObject * parent = nullptr );

  // QAbstractItemModel interface
public:
  QVariant data( const QModelIndex & index, int role ) const override;
};

class ComboBoxCarCategories : public QComboBox {
  Q_OBJECT
public:
  explicit ComboBoxCarCategories( QWidget * parent = nullptr );
  void update( );

private:
  CarCategoriesSqlQueryModel * model { nullptr };
};

#endif // COMBOBOXCARCATEGORIES_H
