#ifndef SEMITRAILERSVIEW //---_H
#define SEMITRAILERSVIEW //---_H

#include <QSqlQueryModel>
#include <QWidget>

namespace Ui {
class SemitrailersView;
}

class SemitrailersView : public QWidget {
  Q_OBJECT

public:
  explicit SemitrailersView( QWidget * parent = nullptr );
  ~SemitrailersView( );
  int currentId( ) const;

private slots:
  void slotCurrentIndexChanged( );

private:
  Ui::SemitrailersView * ui;
};

#endif // SEMITRAILERSVIEW---_H