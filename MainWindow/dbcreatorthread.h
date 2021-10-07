#ifndef DBCREATORTHREAD_H
#define DBCREATORTHREAD_H

#include <QThread>

class DbCreatorThread : public QThread
{
		Q_OBJECT
	public:
		explicit DbCreatorThread( QObject *parent = nullptr );

	protected:
		void run() override;
};

#endif // DBCREATORTHREAD_H
