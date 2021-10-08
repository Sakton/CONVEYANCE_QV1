#ifndef WAITWIDGET_H
#define WAITWIDGET_H

#include <QWidget>

namespace Ui {
	class WaitWidget;
}

class WaitWidget : public QWidget {
		Q_OBJECT

	public:
		explicit WaitWidget( QWidget* parent = nullptr, Qt::WindowFlags f = Qt::WindowFlags() );
		~WaitWidget();

	private:
		Ui::WaitWidget *ui;
};

#endif // WAITWIDGET_H
