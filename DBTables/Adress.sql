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


CREATE SCHEMA IF NOT EXISTS adres;


-- ТАБЛИЦА "СТРАНЫ"
CREATE TABLE adres.countrys (
    country_id SERIAL UNIQUE,                         -- PK
    vat_id INTEGER NOT NULL,                          -- FK на ID VAT(НДС)
    vatname_id INT NOT NULL,                          -- FK на ID абрревиатуры НДСов разных стран европы
    country_name VARCHAR(256) NOT NULL UNIQUE,        -- название страны
    country_abbreviated_2 VARCHAR(4) NOT NULL UNIQUE, -- аббревиатура из 2 символов
    country_abbreviated_3 VARCHAR(4) NOT NULL UNIQUE, -- аббревиатура из 3 символов
    country_icon VARCHAR(256),                        -- имя файла иконки для страны
    PRIMARY KEY ( country_id ),
    FOREIGN KEY ( vat_id ) REFERENCES vat.vats ( vat_id ) ON UPDATE SET NULL ON DELETE SET NULL,
    FOREIGN KEY ( vatname_id ) REFERENCES vat.vatnames ( vatname_id ) ON UPDATE SET NULL ON DELETE SET NULL
);


-- ВТАВКА СПРАСОЧНЫХ ДАННЫХ В ТАБЛИЦУ "СТРАНЫ" -- это константы
INSERT INTO adres.countrys ( vat_id, vatname_id, country_name, country_abbreviated_2, country_abbreviated_3, country_icon )
VALUES 
    ( ( SELECT vat.getVatId(  20::DECIMAL ) ), ( SELECT vat.getVatNames( 'USt'    ) ), 'Австрия', 'AT', 'AUT', 'austria.png' ), --1
    ( ( SELECT vat.getVatId(  20::DECIMAL ) ), ( SELECT vat.getVatNames( 'TVSH'   ) ), 'Белоруссия', 'BY', 'BLR', 'belarus.png' ), --2
    ( ( SELECT vat.getVatId(  21::DECIMAL ) ), ( SELECT vat.getVatNames( 'BTW/TVA') ), 'Бельгия', 'BE', 'BEL', 'belgium.png' ), --3
    ( ( SELECT vat.getVatId(  20::DECIMAL ) ), ( SELECT vat.getVatNames( 'DDS'    ) ), 'Болгария', 'BG', 'BGR', 'bulgaria.png' ), --4
    ( ( SELECT vat.getVatId(  20::DECIMAL ) ), ( SELECT vat.getVatNames( 'VAT'    ) ), 'Великобритания', 'GB', 'GBR', 'united_kingdom.png' ), --5
    ( ( SELECT vat.getVatId(  27::DECIMAL ) ), ( SELECT vat.getVatNames( 'AFA'    ) ), 'Венгрия', 'HU', 'HUN', 'hungary.png'), --6
    ( ( SELECT vat.getVatId(  19::DECIMAL ) ), ( SELECT vat.getVatNames( 'USt'	  ) ), 'Германия', 'DE', 'DEU', 'germany.png' ), --7
    ( ( SELECT vat.getVatId(  21::DECIMAL ) ), ( SELECT vat.getVatNames( 'BTW'	  ) ), 'Нидерланды', 'NL', 'NLD', 'netherlands.png' ), --8
    ( ( SELECT vat.getVatId(  24::DECIMAL ) ), ( SELECT vat.getVatNames( 'FPA'	  ) ), 'Греция', 'GR', 'GRC', 'greece.png' ), --9
    ( ( SELECT vat.getVatId(  25::DECIMAL ) ), ( SELECT vat.getVatNames( 'MOMS'	  ) ), 'Дания', 'DK', 'DNK', 'denmark.png' ), --10
    ( ( SELECT vat.getVatId(  21::DECIMAL ) ), ( SELECT vat.getVatNames( 'VAT'	  ) ), 'Ирландия', 'IE', 'IRL', 'ireland.png' ), --11
    ( ( SELECT vat.getVatId(  24::DECIMAL ) ), ( SELECT vat.getVatNames( 'VASK'	  ) ), 'Исландия', 'IS', 'ISL', 'iceland.png' ), --12
    ( ( SELECT vat.getVatId(  21::DECIMAL ) ), ( SELECT vat.getVatNames( 'IVA'	  ) ), 'Испания', 'ES', 'ESP', 'spain.png' ), --13
    ( ( SELECT vat.getVatId(  22::DECIMAL ) ), ( SELECT vat.getVatNames( 'IVA'	  ) ), 'Италия', 'IT', 'ITA', 'italy.png' ), --14
    ( ( SELECT vat.getVatId(  19::DECIMAL ) ), ( SELECT vat.getVatNames( 'FPA'	  ) ), 'Кипр', 'CY', 'CYP', 'cyprus.png' ), --	15
    ( ( SELECT vat.getVatId(  21::DECIMAL ) ), ( SELECT vat.getVatNames( 'PVN'	  ) ), 'Латвия', 'LV', 'LVA', 'latvia.png' ), --16
    ( ( SELECT vat.getVatId(  21::DECIMAL ) ), ( SELECT vat.getVatNames( 'PVM'	  ) ), 'Литва', 'LT', 'LTU', 'lithuania.png' ), --17
    ( ( SELECT vat.getVatId(   8::DECIMAL ) ), ( SELECT vat.getVatNames( 'MwSt'	  ) ), 'Лихтенштейн', 'LI', 'LIE', 'liechtenstein.png' ), --18
    ( ( SELECT vat.getVatId(  17::DECIMAL ) ), ( SELECT vat.getVatNames( 'MwSt'	  ) ), 'Люксембург', 'LU', 'LUX', 'luxembourg.png' ), --19
    ( ( SELECT vat.getVatId(  18::DECIMAL ) ), ( SELECT vat.getVatNames( 'VAT'	  ) ), 'Мальта', 'MT', 'MLT', 'malta.png'), --20
    ( ( SELECT vat.getVatId(  20::DECIMAL ) ), ( SELECT vat.getVatNames( 'TVA'	  ) ), 'Молдавия', 'MD', 'MDA', 'moldova.png' ), --21
    ( ( SELECT vat.getVatId(  25::DECIMAL ) ), ( SELECT vat.getVatNames( 'MVA'	  ) ), 'Норвегия', 'NO', 'NOR', 'norway.png' ), --22
    ( ( SELECT vat.getVatId(  23::DECIMAL ) ), ( SELECT vat.getVatNames( 'PTU/VAT') ), 'Польша', 'PL', 'POL', 'poland.png' ),--23
    ( ( SELECT vat.getVatId(  23::DECIMAL ) ), ( SELECT vat.getVatNames( 'IVA'	  ) ), 'Португалия', 'PT', 'PRT', 'portugal.png' ),--24
    ( ( SELECT vat.getVatId(  20::DECIMAL ) ), ( SELECT vat.getVatNames( 'НДС'	  ) ), 'Россия', 'RU', 'RUS', 'russia.png' ),--25
    ( ( SELECT vat.getVatId(  19::DECIMAL ) ), ( SELECT vat.getVatNames( 'TVA'	  ) ), 'Румыния', 'RO', 'ROU', 'romania.png' ),--26
    ( ( SELECT vat.getVatId(  20::DECIMAL ) ), ( SELECT vat.getVatNames( 'PDV'	  ) ), 'Сербия', 'RS', 'SRB', 'serbia.png' ),--27
    ( ( SELECT vat.getVatId(  20::DECIMAL ) ), ( SELECT vat.getVatNames( 'DPH'	  ) ), 'Словакия', 'SK', 'SVK', 'slovakia.png' ),--28
    ( ( SELECT vat.getVatId(  22::DECIMAL ) ), ( SELECT vat.getVatNames( 'DDV'	  ) ), 'Словения', 'SI', 'SVN', 'slovenia.png' ), --29
    ( ( SELECT vat.getVatId(  18::DECIMAL ) ), ( SELECT vat.getVatNames( 'KDV'	  ) ), 'Турция', 'TR', 'TUR', 'turkey.png'), --30
    ( ( SELECT vat.getVatId(  20::DECIMAL ) ), ( SELECT vat.getVatNames( 'ПДВ'	  ) ), 'Украина', 'UA', 'UKR', 'ukraine.png' ),--31
    ( ( SELECT vat.getVatId(  24::DECIMAL ) ), ( SELECT vat.getVatNames( 'ALV'	  ) ), 'Финляндия', 'FI', 'FIN', 'finland.png' ),--32
    ( ( SELECT vat.getVatId(  20::DECIMAL ) ), ( SELECT vat.getVatNames( 'TVA'	  ) ), 'Франция', 'FR', 'FRA', 'france.png' ), --33
    ( ( SELECT vat.getVatId(  25::DECIMAL ) ), ( SELECT vat.getVatNames( 'PDV'	  ) ), 'Хорватия', 'HR', 'HRV', 'croatia.png' ),--34
    ( ( SELECT vat.getVatId(  19::DECIMAL ) ), ( SELECT vat.getVatNames( 'PDV'	  ) ), 'Черногория', 'ME', 'MNE', 'montenegro.png' ),--35
    ( ( SELECT vat.getVatId(  21::DECIMAL ) ), ( SELECT vat.getVatNames( 'DPH'	  ) ), 'Чехия', 'CZ', 'CZE', 'czech_republic.png' ),--36
    ( ( SELECT vat.getVatId( 7.7::DECIMAL ) ), ( SELECT vat.getVatNames( 'MwSt'   ) ), 'Швейцария', 'CH', 'CHE', 'switzerland.png' ), --37
    ( ( SELECT vat.getVatId(  25::DECIMAL ) ), ( SELECT vat.getVatNames( 'MOMS'	  ) ), 'Швеция', 'SE', 'SWE', 'sweden.png' ),--38
    ( ( SELECT vat.getVatId(  20::DECIMAL ) ), ( SELECT vat.getVatNames( 'KM'	  ) ), 'Эстония', 'EE', 'EST', 'estonia.png' );--39


-- ТАБЛИЦА "ГОРОДА"
CREATE TABLE adres.сities (
    city_id SERIAL UNIQUE,                      -- РК
    city_name VARCHAR( 256 ) NOT NULL UNIQUE,   -- название города
    country_id INTEGER,                         -- FK на ID страны
    PRIMARY KEY ( city_id ),
    FOREIGN KEY ( country_id ) REFERENCES adres.countrys ( country_id ) ON DELETE RESTRICT
);


-- ТАБЛИЦА "УЛИЦА"
CREATE TABLE adres.streets (
    street_id SERIAL UNIQUE,                     -- PK
    street_name VARCHAR ( 256 ) NOT NULL UNIQUE, -- улица ( предполагается временно: улица, дом, номер дома и тд. )
    PRIMARY KEY ( street_id )
);


-- ТАБЛИЦА "АДРЕС"
CREATE TABLE adres.adress (
    adres_id SERIAL UNIQUE,                                                                 -- PK
    -- country_id INTEGER,                                                                  -- FK на ID страны ( этот ключ не нужен, так как он есть в таблице "ГОРОДА" )
    city_id INTEGER NOT NULL,                                                               -- FK на ID "ГОРОД"
    street_id INTEGER NOT NULL,                                                             -- FK на ID "УЛИЦА" ( одинаковая ( улица ) адрес может быть в разных городах )
    adres_index VARCHAR( 20 ),                                                              -- почтовый индекс
    adres_type VARCHAR( 20 ) NOT NULL,                                                      -- тип адреса (физический, юридический)
    PRIMARY KEY ( adres_id ),
    -- FOREIGN KEY ( country_id ) REFERENCES adres.countrys ( country_id ) ON DELETE SET NULL,
    FOREIGN KEY ( city_id ) REFERENCES adres.сities ( city_id ) ON DELETE SET NULL,
    FOREIGN KEY ( street_id ) REFERENCES adres.streets ( street_id ) ON DELETE SET NULL,
    CHECK ( adres_type IN ( 'Фактический', 'Юридический') )                                  -- доменное ограничение по полю "тип адреса"
);


-- ПРЕДСТАВЛЕНИЕ АДРЕСА
/*
CREATE MATERIALIZED VIEW adres.adressView AS
    SELECT ad.adres_id, tmp.country_icon, tmp.country_name, ad.adres_index, ct.city_name, st.street_name -- как бэ интерфейс тот-же
    FROM adres.adress AS ad
    LEFT JOIN adres.сities AS ct ON ad.city_id = ct.city_id
    LEFT JOIN adres.streets AS st ON ad.street_id = st.street_id
    LEFT JOIN (
                SELECT cn.country_id, cn.country_icon, cn.country_name
                FROM adres.countrys AS cn
                INNER JOIN adres.сities AS ct
                ON cn.country_id = ct.country_id
              ) AS tmp ON tmp.country_id = ct.country_id;
*/

CREATE VIEW adres.adressView AS
    SELECT ad.adres_id, tmp.country_icon, tmp.country_name, ad.adres_index, ct.city_name, st.street_name, ad.adres_type -- как бэ интерфейс тот-же
    FROM adres.adress AS ad
    LEFT JOIN adres.сities AS ct ON ad.city_id = ct.city_id
    LEFT JOIN adres.streets AS st ON ad.street_id = st.street_id
    LEFT JOIN (
                SELECT cn.country_id, cn.country_icon, cn.country_name
                FROM adres.countrys AS cn
                INNER JOIN adres.сities AS ct
                ON cn.country_id = ct.country_id
              ) AS tmp ON tmp.country_id = ct.country_id;

-- ФУНКЦИЯ ПОЛУЧЕНИЯ ID СТРАНЫ ПО НАЗВАНИЮ
CREATE FUNCTION adres.getCountryId ( cntr VARCHAR ) RETURNS INTEGER AS
$$
    SELECT country_id FROM adres.countrys WHERE country_name = cntr;
$$ LANGUAGE SQL;


-- ПРОЦЕДУРА ВСТАВКИ ГОРОДА ПО ИМЕНИ И ID СТРАНЫ
CREATE PROCEDURE adres.addCity( nameCity VARCHAR, idCountry INTEGER ) LANGUAGE SQL AS
$$
    INSERT INTO adres.сities ( city_name, country_id ) VALUES ( nameCity, idCountry );
$$;


-- ФУНКЦИЯ ПОЛУЧЕНИЯ ID ГОРОДА ПО НАЗВАНИЮ
CREATE FUNCTION adres.getCityId ( ct VARCHAR ) RETURNS INTEGER AS 
$$ 
    SELECT city_id FROM adres.сities WHERE city_name = ct;
$$ LANGUAGE SQL;


-- ФУНКЦИЯ ПОЛУЧЕНИЯ ID УЛИЦЫ ( ПОДАДРЕСА ( УЛИЦА-ДОМ-ОФИС№ И Т.Д. ) ),
-- ЕСЛИ ТАКОЙ УЛИЦЫ НЕТ ТО ВСТАВКА ЕЕ И ВОЗВРАТ ID
-- ЕСЛИ ЕСТЬ ТО ПРОСТО ВОЗВРАТ ID
CREATE OR REPLACE FUNCTION adres.getStreetId( st VARCHAR ) RETURNS INTEGER AS
$$ 
DECLARE id INTEGER DEFAULT NULL;
    BEGIN
        id = ( SELECT street_id FROM adres.streets WHERE street_name = st );
        IF ( id IS NULL ) THEN
            BEGIN
                INSERT INTO adres.streets ( street_name ) VALUES ( st );
                id = ( SELECT lastval() );
            END;
        END IF;
    RETURN id;
    END;
$$ LANGUAGE plpgsql;


-- ПРОЦЕДУРА ВСТАВКИ ВСЕГО АДРЕСА: ГОРОД, УЛИЦА, ИНДЕКС, ТИП
-- СТРАНА ДОСТУПНА ИЗ ТАБЛИЦЫ "ГОРОДА"
CREATE OR REPLACE PROCEDURE adres.insertAdress ( ct VARCHAR, strt VARCHAR, idx VARCHAR, type_adress VARCHAR ) LANGUAGE SQL AS
$$
    INSERT INTO adres.adress ( city_id, street_id, adres_index, adres_type )
    VALUES (
        ( SELECT adres.getCityId( ct ) ),
        ( SELECT adres.getStreetId( strt ) ),
        idx,
        type_adress
    );
$$;






