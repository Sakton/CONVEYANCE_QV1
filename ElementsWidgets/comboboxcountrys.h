/* Это комбо-бокс для списка стран из таблицы БД с иконками
читает данные из базы. И имена файлов иконок.
Сами файлы иконок в ресурсах приложения.
*/

#ifndef COMBOBOXCOUNTRYS_H
#define COMBOBOXCOUNTRYS_H

#include <QComboBox>

class ComboBoxCountrys : public QComboBox
{
  Q_OBJECT
public:
  ComboBoxCountrys( QWidget *parent = nullptr );
};

#endif // COMBOBOXCOUNTRYS_H
