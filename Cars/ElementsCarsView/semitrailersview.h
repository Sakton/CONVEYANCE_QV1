#ifndef SEMITRAILERSVIEW_H
#define SEMITRAILERSVIEW_H

#include <QSqlQueryModel>
#include <QWidget>

// ******** VIEW
namespace Ui {
class SemitrailersView;
}

class SemitrailersView : public QWidget {
  Q_OBJECT

public:
  explicit SemitrailersView( QWidget * parent = nullptr );
  ~SemitrailersView( );

private slots:
  void slotCurrentIndexChanged( );

private:
  Ui::SemitrailersView * ui;
};

#endif // SEMITRAILERSVIEW_H
