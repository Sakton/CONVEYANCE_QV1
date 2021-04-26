#ifndef MAINWINDOWCONVEYANCE_H
#define MAINWINDOWCONVEYANCE_H

#include <QMainWindow>

QT_BEGIN_NAMESPACE
namespace Ui { class MainWindowConveyance; }
QT_END_NAMESPACE

class MainWindowConveyance : public QMainWindow
{
    Q_OBJECT

public:
    MainWindowConveyance(QWidget *parent = nullptr);
    ~MainWindowConveyance();

private:
    Ui::MainWindowConveyance *ui;
};
#endif // MAINWINDOWCONVEYANCE_H
