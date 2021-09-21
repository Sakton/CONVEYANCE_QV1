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

-- ОБЛАСТЬ ИМЕН МАШИНЫ
CREATE SCHEMA IF NOT EXISTS cars; -- Пространство имен для таблиц авто

-- ТАБЛИЦА БРЕНДЫ АВТОМОБИЛЬНЫЕ
CREATE TABLE cars.autobrands (
    autobrand_id SERIAL UNIQUE,				    -- PK
    autobrand_name VARCHAR(256) UNIQUE NOT NULL,	    -- ИМЯ БРЕНДА
    autobrand_icon VARCHAR(256) DEFAULT ('no_icon.png'),    -- ИМЯ ФАЙЛА ИКОНКИ БРЕНДА
    PRIMARY KEY ( autobrand_id )
);

-- СПРАВОЧНАЯ ТАБЛИЦА КАТЕГОРИИ АВТО
CREATE TABLE cars.autocategories (
    autocategory_id SERIAL UNIQUE,			    -- PK
    autocategory_name VARCHAR(256) NOT NULL,		    -- ИМЯ КАТЕГОРИИ
    autocategory_symbol VARCHAR(5) NOT NULL,		    -- ОБОЗНАЧЕНИЕ КАТЕГОРИИ
    autocategory_icon VARCHAR(64),			    -- ИМЯ ФАЙЛА ПИКТОГРАММЫ КАТЕГОРИИ
    autocategory_description TEXT,			    -- КРАТКОЕ ОПИСАНИЕ КАТЕГОРИИ ( справочная информация для оператора не знакомого с этим )
    PRIMARY KEY ( autocategory_id )
);

/*
-- СПРАВОЧНАЯ ТАБЛИЦА ГАБАРИТОВ
CREATE TABLE cars.gabarites (
    gabarit_id SERIAL UNIQUE,
    gabarit_lenth  NUMERIC(4, 2),
    gabarit_width  NUMERIC(4, 2),
    gabarit_height NUMERIC(4, 2)
	-- semitrailer_volume NUMERIC(4,2),		    -- обьем ( вычисляемое )
	-- semitrailer_count_europalett INTEGER,	    -- количество палет ( вычисляемое )
);
*/

CREATE TABLE cars.paletypes (
    paletype_id SERIAL UNIQUE,
    paletype_name  VARCHAR( 96 ),			    --ТИП ПАЛЕТ
    paletype_lenth NUMERIC(4, 2),			    --длина
    paletype_width NUMERIC(4, 2),			    --ширина
    PRIMARY KEY(paletype_id)
);

CREATE TABLE cars.description_semitrailers (
    description_semitrailer_id SERIAL UNIQUE,
    description_semitrailer_description TEXT,
    PRIMARY KEY(description_semitrailer_id)
);

-- ТАБЛИЦА ТИПОВ ПОЛУПРИЦЕПОВ
CREATE TABLE cars.semitrailers (
    semitrailer_id SERIAL UNIQUE,			    -- PK
    semitrailer_name VARCHAR(64),			    -- имя типа
    semitrailer_carrying NUMERIC(4, 2),			    -- грузоподьемность
    semitrailer_gabarit_lenth  NUMERIC(4, 2),		    -- длина
    semitrailer_gabarit_width  NUMERIC(4, 2),		    -- ширина
    semitrailer_gabarit_height NUMERIC(4, 2),		    -- высота
    semitrailer_img VARCHAR(64),			    -- имя файла картинки
    description_semitrailer_id INTEGER,			    -- описание типа
    PRIMARY KEY( semitrailer_id ),
    FOREIGN KEY( description_semitrailer_id ) REFERENCES cars.description_semitrailers ( description_semitrailer_id )
	ON UPDATE CASCADE ON DELETE SET NULL
);

-- ТАБЛИЦА МОДЕЛИ АВТОМОБИЛЕЙ
CREATE TABLE cars.carsmodels (
    carsmodel_id SERIAL UNIQUE,								-- PK
    autobrand_id INTEGER NOT NULL,							-- FK КАКОМУ БРЕНДУ ПРИНАДЛЕЖИТ
    autocategory_id INTEGER NOT NULL,							-- FK К КАКОЙ КАТЕГОРИИ ОТНОСИТСЯ
    carsmodel_name VARCHAR ( 200 ),							-- ИМЯ МОДЕЛИ
    semitrailer_id INTEGER,								-- ПОЛУПРИЦЕП
    PRIMARY KEY ( carsmodel_id	  ),
    FOREIGN KEY ( autobrand_id	  ) REFERENCES cars.autobrands ( autobrand_id ),	-- NO ACTION по умолчанию
    FOREIGN KEY ( autocategory_id ) REFERENCES cars.autocategories ( autocategory_id )  -- NO ACTION по умолчанию
);

CREATE TABLE cars.cars (
    car_id SERIAL UNIQUE,
    car_vin VARCHAR(64) UNIQUE NOT NULL,
    car_date_release DATE,
    car_date_gto DATE,
    carsmodel_id INTEGER,
    PRIMARY KEY( car_id ),
    FOREIGN KEY (carsmodel_id) REFERENCES cars.carsmodels (carsmodel_id)
	ON DELETE SET NULL ON UPDATE CASCADE
);

-- NO ACTION - не даст удалить связанную строку из базовой тавблицы

-- ФУНКЦИЯ ВОЗВРАЩАЕТ ID БРЕНДА ПО ЕГО ИМЕНИ
-- Так как данные берутся из comboBox, а они из БД, то такие записи существуют
CREATE OR REPLACE FUNCTION cars.getAutobrand_id ( nameBrand VARCHAR ) RETURNS INTEGER LANGUAGE SQL AS
$$
SELECT autobrand_id FROM cars.autobrands WHERE autobrand_name = nameBrand;
$$;

-- ФУНКЦИЯ ВОЗВРАЩАЕТ ID КАТЕГОРИИ ПО ЕЕ ИМЕНИ
CREATE OR REPLACE FUNCTION cars.getAutocategory_id ( symbolCategory VARCHAR ) RETURNS INTEGER LANGUAGE SQL AS
$$
SELECT autocategory_id FROM cars.autocategories WHERE autocategory_symbol = symbolCategory;
$$;

-- ПРОЦЕДУРА ДОБАВЛЕНИЯ МОДЕЛИ
CREATE OR REPLACE PROCEDURE cars.add_carmodel ( nameBrand VARCHAR, symbolCategory VARCHAR, carModel VARCHAR ) LANGUAGE SQL AS
$$
INSERT INTO cars.carsmodels ( autobrand_id, autocategory_id, carsmodel_name )
VALUES ( ( SELECT cars.getAutobrand_id( nameBrand ) ), ( SELECT cars.getAutocategory_id( symbolCategory ) ), carModel );
$$;

-- ПРЕДСТАВЛЕНИЕ ПРИЦЕПОВ
CREATE VIEW cars.semitrailers_view AS
    SELECT semitrailer_id AS id,
	   semitrailer_name AS name,
	   semitrailer_carrying AS carrying,
	   semitrailer_gabarit_lenth AS lenth,
	   semitrailer_gabarit_width AS width,
	   semitrailer_gabarit_height AS height,
	   semitrailer_img AS img,
	   description_semitrailer_description AS description
    FROM cars.semitrailers AS st
    INNER JOIN cars.description_semitrailers AS ds
	ON st.description_semitrailer_id = ds.description_semitrailer_id;

-- ПРЕДСТАВЛЕНИЕ АВТОМОБИЛЯ
CREATE VIEW cars.automobiles AS
SELECT cr.car_id,
       cr.car_vin,
       cr.car_date_release,
       cr.car_date_gto,
       cm.carsmodel_id,
       cm.autobrand_id,
       cm.autocategory_id,
       cm.carsmodel_name,
       cm.semitrailer_id, --1
       ab.autobrand_name,
       ab.autobrand_icon,
       ac.autocategory_name,
       ac.autocategory_symbol,
       ac.autocategory_icon,
       ac.autocategory_description, --2
       smt.semitrailer_name,
       smt.semitrailer_carrying,
       smt.semitrailer_gabarit_lenth,
       smt.semitrailer_gabarit_width,
       smt.semitrailer_gabarit_height,
       smt.description_semitrailer_id
FROM cars.cars AS cr
INNER JOIN cars.carsmodels AS cm ON cr.carsmodel_id = cm.carsmodel_id
INNER JOIN cars.autobrands AS ab ON ab.autobrand_id = cm.autobrand_id
INNER JOIN cars.autocategories AS ac ON ac.autocategory_id = cm.autocategory_id
INNER JOIN cars.semitrailers AS smt ON smt.semitrailer_id = cm.semitrailer_id
INNER JOIN cars.description_semitrailers AS dscr
    ON smt.description_semitrailer_id = dscr.description_semitrailer_id;

