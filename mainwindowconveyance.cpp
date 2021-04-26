#include "mainwindowconveyance.h"
#include "ui_mainwindowconveyance.h"

MainWindowConveyance::MainWindowConveyance(QWidget *parent)
    : QMainWindow(parent)
    , ui(new Ui::MainWindowConveyance)
{
    ui->setupUi(this);
}

MainWindowConveyance::~MainWindowConveyance()
{
    delete ui;
}

