#ifndef COMBOBOXCARBRAND_H
#define COMBOBOXCARBRAND_H

#include <QComboBox>
#include <QSqlQueryModel>

class CarBrandSqlQueryModel : public QSqlQueryModel {
public:
  explicit CarBrandSqlQueryModel( QObject * parent = nullptr );

  // QAbstractItemModel interface
public:
  QVariant data( const QModelIndex & index, int role ) const override;
};

// *********** COMBOBOX


class ComboBoxCarBrand : public QComboBox {
  Q_OBJECT
public:
  explicit ComboBoxCarBrand( QWidget * parent = nullptr );
  void init( );
  void update( );

private:
  CarBrandSqlQueryModel * model { nullptr };
};

#endif // COMBOBOXCARBRAND_H
