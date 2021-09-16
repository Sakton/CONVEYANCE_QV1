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
    gabarit_lenth  NUMERIC(4, 2),
    gabarit_width  NUMERIC(4, 2),
    gabarit_height NUMERIC(4, 2),
    description_semitrailer_id INTEGER,			    -- описание типа
    PRIMARY KEY( semitrailer_id ),
    FOREIGN KEY( description_semitrailer_id ) REFERENCES cars.description_semitrailers ( description_semitrailer_id )
	ON UPDATE CASCADE ON DELETE SET NULL
);

/*
https://profi-prim.ru/article/kategorii-prav#:~:text=%D0%B2%20%D1%81%D0%B5%D0%B3%D0%BE%D0%B4%D0%BD%D1%8F%D1%88%D0%BD%D0%B5%D0%BC%20%D1%82%D0%B5%D0%BA%D1%81%D1%82%D0%B5.-,%D0%92%20%D0%A0%D0%BE%D1%81%D1%81%D0%B8%D0%B8%20%D1%81%D1%83%D1%89%D0%B5%D1%81%D1%82%D0%B2%D1%83%D0%B5%D1%82%2010%20%D0%BA%D0%B0%D1%82%D0%B5%D0%B3%D0%BE%D1%80%D0%B8%D0%B9%20%D0%BF%D1%80%D0%B0%D0%B2%3A%20%D0%9C%20%E2%80%94%20%D0%BC%D0%BE%D0%BF%D0%B5%D0%B4%D1%8B%20%D0%B8%20%D0%BB%D0%B5%D0%B3%D0%BA%D0%B8%D0%B5,%D1%82%D0%BE%D0%BD%D0%BD%3B%20%D0%A1%D0%95%20%E2%80%94%20%D0%B3%D1%80%D1%83%D0%B7%D0%BE%D0%B2%D1%8B%D0%B5%20%D0%B0%D0%B2%D1%82%D0%BE%D0%BC%D0%BE%D0%B1%D0%B8%D0%BB%D0%B8%20%D1%81
*/

-- ВСТАВКА СПРАВОЧНЫХ ДАННЫХ
INSERT INTO cars.paletypes ( paletype_name, paletype_lenth, paletype_width )
VALUES ('Финский', 1.2, 1),
       ('Американский', 1.2, 1.2),
       ('Европейский', 1.2, 0.8);

INSERT INTO cars.description_semitrailers( description_semitrailer_description )
VALUES ('Стандартный полуприцеп с ровным полом.'),
       ('Конструкция полуприцепа с ломаным полом, уменьшенный диаметр колёс.'),
       ('Стандартный полуприцеп увеличенной высоты с ровным полом.'),
       ('Автопоезд - грузовик с прицепом увеличенной высоты и уменьшенным диаметром колёс.'),
       ('Автопоезд - грузовик с прицепом.');


INSERT INTO cars.autocategories ( autocategory_name, autocategory_symbol, autocategory_icon, autocategory_description )
VALUES ( 'Мопеды и Легкие квадрициклы','M','M.png','Категория М дает право водить мопеды и легкие квадрициклы.
Особенность управления этими ТС в том, что ими можно управлять
имея любую другую категорию водительских прав. За исключением
удостоверения тракториста-машиниста и наличия иностранных водительских прав.
Важно! Чтобы водить квадроцикл или снегоход,
эта категория прав не подходит.
Для управления этими ТС нужно иметь удостоверение тракториста-машиниста
категории А1 — внедорожные транспортные средства.
При этом А1 относится не к автомобильным категориям прав,
а к категориям управления специальной техникой.' ),
( 'Мотоциклы', 'A', 'A.png', 'Категория A дает право управлять любыми мотоциклами' ),
( 'Легкие мотоциклы', 'A1', 'A1.png', 'Позволяет управлять мотоциклами с объемом двигателя, не превышающим 125 куб. см и максимальной мощностью не более 11 киловатт.' ),
( 'Легковые автомобили и небольшие грузовики', 'B', 'B.png', 'Автомобили, масса которых не превышает 3,5 тонны, а число сидячих мест
(помимо сиденья водителя) не превышает восьми;
автомобили, сцепленные с прицепом, разрешенная масса которого не более 750 кг;
автомобили, сцепленные с прицепом, разрешенная максимальная масса которого превышает 750 кг,
но не превышает массы автомобиля без нагрузки, при условии, что общая максимальная масса такого
состава транспортных средств не превышает 3,5 тонны.
К перечисленным выше условиям могут относиться не только легковые автомобили,
но и небольшие грузовики, микроавтобусы и джипы.' ),
( 'Трициклы и квадрициклы', 'B1', 'B1.png', 'Дает право на управление трициклами и квадрициклами. Это транспортные средства с тремя и четырьмя колесами соответственно.' ),
( 'Легковые автомобили с прицепом', 'BE', 'BE.png', 'Позволяет управлять автомобилем категории В с тяжелым прицепом:
разрешенная максимальная масса которого превышает 750 кг и превышает массу автомобиля без нагрузки;
разрешенная максимальная масса которого превышает 750 кг,
при условии, что общая разрешенная максимальная масса такого
состава транспортных средств превышает 3,5 тонны.' ),
( 'Грузовые автомобили от 3,5 тонн', 'C', 'C.png', 'Позволяют управлять автомобилями, максимальная масса которых превышает 3,5 тонны, за исключением машин категории D;
автомобилями, сцепленными с прицепами, разрешенная максимальная масса которых не превышает 750 кг.' ),
( 'Средние грузовики (от 3,5 до 7,5 тонн)', 'C1', 'C1.png', 'Дает право управлять автомобилем, разрешенная максимальная масса которого превышает 3,5 тонны,
но не превышает 7,5 тонн, за исключение автомобилей категории D.
автомобилем с прицепом, разрешенная максимальная масса которого не более 750 кг.' ),
( 'Средние грузовые автомобили с прицепом', 'C1E', 'C1E.png', 'Позволяет управлять:
автомобилями подкатегории С1, сцепленными с тяжелым прицепом (более 750 кг).
При условии, что общая масса этого состава ТС не более 12 тонн.' ),
( 'Грузовые автомобили с прицепом', 'CE', 'CE.png', 'Дает возможность управлять автомобилями категории С, сцепленными прицепами,
разрешенная максимальная масса которых превышает 750 кг.' ),
( 'Автобусы, имеющие более 8 сидячих мест', 'D', 'D.png', 'Дает право управлять:
автомобилями для перевозки пассажиров и имеющими более 8 сидячих мест, помимо сиденья водителя;
автобусами с прицепом, вес которого не превышает 750 кг.
То есть к этой категории относятся как маленькие, так и большие туристические автобусы.
Единственное исключение — автобусы с «гармошкой».' ),
( 'Небольшие автобусы', 'D1', 'D1.png', 'Позволяет управлять небольшими автобусами, которые имеют от 9 до 16 сидячих мест, помимо сиденья водителя.
Также дает право использовать легкий прицеп до 750 кг.' ),
( 'Небольшие автобусы с прицепом', 'D1E', 'D1E.png', 'Дает право управлять автомобилем подкатегории D1, сцепленными с прицепом, разрешенная масса
которого превышает 750 кг, но не превышает массу автомобиля без нагрузки.
Суммарный вес такого ТС не должен превышать 12 тонн, а прицеп не должен быть предназначен для перевозки пассажиров.
Важно! Водители, имеющие права категории D, могут управлять автобусами подкатегории D1, а категория DE дает возможность
управлять автобусами с прицепом подкатегории D1Е.' ),
( 'Автобусы с прицепом', 'DE', 'DE.png', 'Дает возможность управлять сочленными автобусами и буксировать прицепы весом более 750 кг.' ),
( 'Троллейбусы', 'Tb', 'Tb.png', 'Дают право управлять троллейбусами' ),
( 'Трамваи', 'Tm', 'Tm.png', 'Дают право управлять трамваями' );

-- ТАБЛИЦА МОДЕЛИ АВТОМОБИЛЕЙ
CREATE TABLE cars.carsmodels (
    carsmodel_id SERIAL UNIQUE,								-- PK
    autobrand_id INTEGER NOT NULL,							-- FK КАКОМУ БРЕНДУ ПРИНАДЛЕЖИТ
    autocategory_id INTEGER NOT NULL,							-- FK К КАКОЙ КАТЕГОРИИ ОТНОСИТСЯ
    carsmodel_name VARCHAR ( 200 ),							-- ИМЯ МОДЕЛИ
    semitrailer_id INTEGER,	-- ?????						-- ПОЛУПРИЦЕП
    PRIMARY KEY ( carsmodel_id	  ),
    FOREIGN KEY ( autobrand_id	  ) REFERENCES cars.autobrands ( autobrand_id ),	-- NO ACTION по умолчанию
    FOREIGN KEY ( autocategory_id ) REFERENCES cars.autocategories ( autocategory_id )  -- NO ACTION по умолчанию
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






























