#ifndef COMBOBOXCARCATEGORIES_H
#define COMBOBOXCARCATEGORIES_H

#include <QComboBox>

#include <QSqlQueryModel>

// ************ MODEL
enum CarCategoriesRoles { AUTOCATEGORY_ID = Qt::UserRole, AUTOCATEGORY_NAME, AUTOCATEGORY_SYMBOL };

class CarCategoriesSqlQueryModel : public QSqlQueryModel {
  Q_OBJECT
public:
  explicit CarCategoriesSqlQueryModel( QObject * parent = nullptr );
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
