#ifndef NEWUSERDATABASEDIALOG_H
#define NEWUSERDATABASEDIALOG_H

#include <QDialog>

namespace Ui {
	class NewUserdataBaseDialog;
}

class NewUserdataBaseDialog : public QDialog
{
		Q_OBJECT

	public:
		explicit NewUserdataBaseDialog(QWidget *parent = nullptr);
		~NewUserdataBaseDialog();

	public slots:
		void accept() override;


	private:
		Ui::NewUserdataBaseDialog *ui;
};

#endif // NEWUSERDATABASEDIALOG_H
