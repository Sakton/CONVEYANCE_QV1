#include "mainwindowconveyance.h"

#include <QApplication>

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    MainWindowConveyance w;
    w.show();
    return a.exec();
}
