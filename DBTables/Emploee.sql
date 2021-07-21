/*
NO ACTION
Выдать ошибку, показывающую, что при удалении или изменении записи
произойдёт нарушение ограничения внешнего ключа. Для отложенных ограничений
ошибка произойдёт в момент проверки ограничения, если строки, ссылающиеся на эту запись,
по-прежнему будут существовать. Этот вариант действия подразумевается по умолчанию.

RESTRICT
Выдать ошибку, показывающую, что при удалении или изменении записи
произойдёт нарушение ограничения внешнего ключа. Этот вариант подобен NO ACTION, но эта проверка будет неоткладываемой.

CASCADE
Удалить все строки, ссылающиеся на удаляемую запись, либо поменять
значения в ссылающихся столбцах на новые значения во внешних столбцах, в соответствии с операцией.

SET NULL
Установить ссылающиеся столбцы равными NULL.

SET DEFAULT
Установить в ссылающихся столбцах значения по умолчанию.
(Если эти значения не равны NULL, во внешней таблице должна быть строка,
соответствующая набору значений по умолчанию; в противном случае операция завершится ошибкой.)
*/

-- работник ( не только водитель кто угодно )
CREATE SCHEMA IF NOT EXISTS emploee;


-- ТАБЛИЦА ДОЛЖНОСТЬ НА ФИРМЕ
CREATE TABLE emploee.functionWorker (
    functionWorker_id SERIAL UNIQUE,		-- PK
    functionWorker_name	VARCHAR(128) UNIQUE,	-- Наименование должности
    PRIMARY KEY( functionWorker_id )
);


cars.autocategories
-- ТАБЛИЦА СОТРУДНИКИ
CREATE TABLE emploee.emploees (
	emploee_id SERIAL UNIQUE,		-- PK
	functionWorker_id INTEGER NOT NULL,	-- FK
	autocategory_id INTEGER,		-- Категория прав
	emploee_name VARCHAR(200),		-- имя работника
	PRIMARY KEY (emploee_id),
	FOREIGN KEY ( functionWorker_id ) REFERENCES emploee.functionWorker ( functionWorker_id )
	    ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY ( autocategory_id )  REFERENCES cars.autocategories ( autocategory_id ) ON DELETE SET NULL
);


-- ФУНКЦИЯ ВОЗВРАЩАЕТ ID СОТРУДНИКА ПО ИМЕНИ
CREATE FUNCTION emploee.getFunctionWorkerId( functionWorkerName VARCHAR ) RETURNS INTEGER LANGUAGE SQL AS
$$
    SELECT functionWorker_id FROM emploee.functionWorker WHERE functionWorker_name = functionWorkerName;
$$;


-- ПРОЦЕДУРА ВСТАВКИ ДАННЫХ В ТАБЛИЦУ СОТРУДНИК
CREATE PROCEDURE emploee.addEmploee ( functionWorkerName VARCHAR, autocategoryName VARCHAR, emploeeName VARCHAR ) LANGUAGE SQL AS
$$
    INSERT INTO emploee.emploees ( functionWorker_id, autocategory_id, emploee_name )
	VALUES ( ( SELECT emploee.getFunctionWorkerId( functionWorkerName ) ), ( SELECT cars.getAutocategory_id( autocategoryName ) ), emploeeName );
$$;

-- ПРОЦЕДУРА ВСТАВКИ ДАННЫХ В ТАБЛИЦУ СОТРУДНИК ( ПЕРЕГРУЗКА )
-- связано с тем что в обьекте списка хранится еще id и его можно взять
CREATE PROCEDURE emploee.addEmploee ( functionWorkerId INTEGER, autocategoryId INTEGER, emploeeName VARCHAR ) LANGUAGE SQL AS
$$
    INSERT INTO emploee.emploees ( functionWorker_id, autocategory_id, emploee_name )
	VALUES ( functionWorkerId, autocategoryId, emploeeName );
$$;

-- ПРЕДСТАВЛЕНИЕ
CREATE VIEW emploee.emploeeView AS
    SELECT e.emploee_id, e.emploee_name, fw.functionWorker_name, cr.autocategory_symbol, cr.autocategory_icon
    FROM emploee.emploees AS e
	INNER JOIN emploee.functionWorker AS fw
	    ON e.functionWorker_id = fw.functionWorker_id
	INNER JOIN cars.autocategories AS cr
	    ON e.autocategory_id = cr.autocategory_id;


-- test
SELECT emploee.getEmploee_id ( 'Васька Пупочек' );
SELECT emploee.getEmploee_id ( 'Васька Пупочек Пупочек' );
