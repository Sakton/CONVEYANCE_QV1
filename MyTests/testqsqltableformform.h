#ifndef TESTQSQLTABLEFORMFORM_H
#define TESTQSQLTABLEFORMFORM_H

#include <QWidget>

namespace Ui {
class TestQSqlTableFormForm;
}

class TestQSqlTableFormForm : public QWidget
{
  Q_OBJECT

public:
  explicit TestQSqlTableFormForm(QWidget *parent = nullptr);
  ~TestQSqlTableFormForm();

private:
  Ui::TestQSqlTableFormForm *ui;
};

#endif // TESTQSQLTABLEFORMFORM_H
