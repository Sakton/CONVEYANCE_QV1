#ifndef LOGING_H
#define LOGING_H
#include <QMessageLogContext>
#include <QFile>
#include <QTextStream>

void myMessageHandler ( QtMsgType type, const QMessageLogContext &, const QString & message ) {
	QFile file( "logfile.txt" );
	file.open( QFile::Text | QFile::Append );
	QTextStream out( &file );

	switch (type) {
		case QtInfoMsg:     out << "INFO     : "; break;
		case QtDebugMsg:    out << "DEBUG    : "; break;
		case QtWarningMsg:  out << "WARNING  : "; break;
		case QtCriticalMsg: out << "CRITICAL : "; break;
		case QtFatalMsg:    out << "FATAL    : "; break;
	}

	out << message << '\n';
	out.flush();
}

#endif // LOGING_H
