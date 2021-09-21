#ifndef COMBOBOXCARCATEGORIES_H
#define COMBOBOXCARCATEGORIES_H

#include <QComboBox>

#include <QSqlQueryModel>

// ************ MODEL

class CarCategoriesSqlQueryModel : public QSqlQueryModel {
  Q_OBJECT
public:
  enum CarCategoriesRoles { AUTOCATEGORY_ID = Qt::UserRole, AUTOCATEGORY_NAME };

  explicit CarCategoriesSqlQueryModel( QObject * parent = nullptr );

  // QAbstractItemModel interface
public:
  QVariant data( const QModelIndex & index, int role ) const override;
};

// ************* COMBOBOX

class ComboBoxCarCategories : public QComboBox {
  Q_OBJECT
public:
  explicit ComboBoxCarCategories( QWidget * parent = nullptr );
  void update( );

private:
  CarCategoriesSqlQueryModel * _model { nullptr };
};

#endif // COMBOBOXCARCATEGORIES_H
