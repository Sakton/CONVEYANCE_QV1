#include "waitwidget.h"
#include "ui_waitwidget.h"

WaitWidget::WaitWidget( QWidget* parent, Qt::WindowFlags f ) : QWidget( parent, f ), ui(new Ui::WaitWidget) {
	ui->setupUi(this);
}

WaitWidget::~WaitWidget() {
	delete ui;
}
