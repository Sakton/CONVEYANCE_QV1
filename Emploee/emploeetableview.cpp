#include "emploeetableview.h"
#include "Constants.h"
#include "emploeesqltablemodel.h"
#include "ui_emploeetableview.h"

#include <QContextMenuEvent>
#include <QMenu>

EmploeeTableView::EmploeeTableView( QWidget * parent )
	: QWidget( parent ),
		ui( new Ui::EmploeeTableView ),
		add { new QAction( tr( "Добавить" ) ) },
		upd { new QAction( tr( "Измениь" ) ) },
		del { new QAction(tr( "Удалить" ) ) } {
	ui->setupUi( this );

	model = new EmploeeSqlTableModel( this, QSqlDatabase::database( ConveyanceConstats::NAME_DB_ALL ) );
	ui->tableView->setModel( model );
	ui->tableView->setColumnHidden( 0, true );
	ui->tableView->setColumnHidden( 4, true );
	ui->tableView->horizontalHeader( )->setSectionResizeMode( QHeaderView::ResizeMode::Stretch );

	initMenus();
}

EmploeeTableView::~EmploeeTableView( ) { delete ui; }

void EmploeeTableView::initMenus()
{
	ui->pushButtonAdd->setAction( add );
	ui->pushButtonUpd->setAction( upd );
	ui->pushButtonDel->setAction( del );

	contextMenu = new QMenu( this );

	contextMenu->addAction( add );
	contextMenu->addAction( upd );
	contextMenu->addAction( del );

	ui->tableView->setContextMenu( contextMenu );
}

