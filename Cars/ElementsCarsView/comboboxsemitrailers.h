#ifndef COMBOBOXSEMITRAILERS_H
#define COMBOBOXSEMITRAILERS_H

#include <QComboBox>
#include <QSqlQueryModel>

// ***** MODEL

enum SemitrailerRole { ID = Qt::UserRole, CARRYING, LENTH, WIDTH, HEIGHT, IMG, DESCRIPTION };

class ComboBoxSemitrailersSqlQueryModel : public QSqlQueryModel {
public:
  explicit ComboBoxSemitrailersSqlQueryModel( QObject * parent = nullptr );
  QVariant data( const QModelIndex & index, int role ) const override;
};

// ****** COMBOBOX

class ComboBoxSemitrailers : public QComboBox {
  Q_OBJECT
public:
  explicit ComboBoxSemitrailers( QWidget * parent = nullptr );

private:
  ComboBoxSemitrailersSqlQueryModel * _model;
};

#endif // COMBOBOXSEMITRAILERS_H
