#ifndef AUTORIZATIONDIALOG_H
#define AUTORIZATIONDIALOG_H

#include <QDialog>

namespace Ui {
	class AutorizationDialog;
}

class AutorizationDialog : public QDialog {
		Q_OBJECT

	public:
		explicit AutorizationDialog(QWidget *parent = nullptr);
		~AutorizationDialog();

	public slots:
		void accept() override;
		void registerNewUser();
		void reject() override;

	private:
		Ui::AutorizationDialog *ui;
};

#endif // AUTORIZATIONDIALOG_H
