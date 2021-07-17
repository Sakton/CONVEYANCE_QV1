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


CREATE SCHEMA adres;


-- ***********
CREATE TABLE adres.streets (
	street_id SERIAL UNIQUE,
	street_name VARCHAR ( 256 ) NOT NULL UNIQUE
);


-- ***********
CREATE TABLE adres.countrys (
	country_id SERIAL UNIQUE,
	vat_id INTEGER NOT NULL,
	vatname_id INT NOT NULL,
	country_name VARCHAR(256) NOT NULL UNIQUE,
	country_abbreviated_2 VARCHAR(4) NOT NULL UNIQUE,
	country_abbreviated_3 VARCHAR(4) NOT NULL UNIQUE,
	country_icon VARCHAR(256),
	PRIMARY KEY ( country_id ),
	FOREIGN KEY ( vat_id ) REFERENCES vat.vats ( vat_id ) ON UPDATE SET NULL ON DELETE SET NULL,
	FOREIGN KEY ( vatname_id ) REFERENCES vat.vatnames ( vatname_id ) ON UPDATE SET NULL ON DELETE SET NULL
);


-- ***********
INSERT INTO adres.countrys ( vat_id, vatname_id, country_name, country_abbreviated_2, country_abbreviated_3, country_icon )
VALUES 
      ( ( SELECT vat.getVatId(  20::DECIMAL ) ), ( SELECT vat.getVatNames( 'USt'    ) ), 'Австрия', 'AT', 'AUT', 'austria.png' ), --1
	  ( ( SELECT vat.getVatId(  20::DECIMAL ) ), ( SELECT vat.getVatNames( 'TVSH'   ) ), 'Белоруссия', 'BY', 'BLR', 'belarus.png' ), --2
	  ( ( SELECT vat.getVatId(  21::DECIMAL ) ), ( SELECT vat.getVatNames( 'BTW/TVA') ), 'Бельгия', 'BE', 'BEL', 'belgium.png' ), --3
	  ( ( SELECT vat.getVatId(  20::DECIMAL ) ), ( SELECT vat.getVatNames( 'DDS'    ) ), 'Болгария', 'BG', 'BGR', 'bulgaria.png' ), --4
	  ( ( SELECT vat.getVatId(  20::DECIMAL ) ), ( SELECT vat.getVatNames( 'VAT'    ) ), 'Великобритания', 'GB', 'GBR', 'united_kingdom.png' ), --5
	  ( ( SELECT vat.getVatId(  27::DECIMAL ) ), ( SELECT vat.getVatNames( 'AFA'    ) ), 'Венгрия', 'HU', 'HUN', 'hungary.png'), --6
	  ( ( SELECT vat.getVatId(  19::DECIMAL ) ), ( SELECT vat.getVatNames( 'USt'	) ), 'Германия', 'DE', 'DEU', 'germany.png' ), --7
	  ( ( SELECT vat.getVatId(  21::DECIMAL ) ), ( SELECT vat.getVatNames( 'BTW'	) ), 'Нидерланды', 'NL', 'NLD', 'netherlands.png' ), --8
	  ( ( SELECT vat.getVatId(  24::DECIMAL ) ), ( SELECT vat.getVatNames( 'FPA'	) ), 'Греция', 'GR', 'GRC', 'greece.png' ), --9
	  ( ( SELECT vat.getVatId(  25::DECIMAL ) ), ( SELECT vat.getVatNames( 'MOMS'	) ), 'Дания', 'DK', 'DNK', 'denmark.png' ), --10
	  ( ( SELECT vat.getVatId(  21::DECIMAL ) ), ( SELECT vat.getVatNames( 'VAT'	) ), 'Ирландия', 'IE', 'IRL', 'ireland.png' ), --11
	  ( ( SELECT vat.getVatId(  24::DECIMAL ) ), ( SELECT vat.getVatNames( 'VASK'	) ), 'Исландия', 'IS', 'ISL', 'iceland.png' ), --12
	  ( ( SELECT vat.getVatId(  21::DECIMAL ) ), ( SELECT vat.getVatNames( 'IVA'	) ), 'Испания', 'ES', 'ESP', 'spain.png' ), --13
	  ( ( SELECT vat.getVatId(  22::DECIMAL ) ), ( SELECT vat.getVatNames( 'IVA'	) ), 'Италия', 'IT', 'ITA', 'italy.png' ), --14
	  ( ( SELECT vat.getVatId(  19::DECIMAL ) ), ( SELECT vat.getVatNames( 'FPA'	) ), 'Кипр', 'CY', 'CYP', 'cyprus.png' ), --	15
	  ( ( SELECT vat.getVatId(  21::DECIMAL ) ), ( SELECT vat.getVatNames( 'PVN'	) ), 'Латвия', 'LV', 'LVA', 'latvia.png' ), --16
	  ( ( SELECT vat.getVatId(  21::DECIMAL ) ), ( SELECT vat.getVatNames( 'PVM'	) ), 'Литва', 'LT', 'LTU', 'lithuania.png' ), --17
	  ( ( SELECT vat.getVatId(   8::DECIMAL ) ), ( SELECT vat.getVatNames( 'MwSt'	) ), 'Лихтенштейн', 'LI', 'LIE', 'liechtenstein.png' ), --18
	  ( ( SELECT vat.getVatId(  17::DECIMAL ) ), ( SELECT vat.getVatNames( 'MwSt'	) ), 'Люксембург', 'LU', 'LUX', 'luxembourg.png' ), --19
	  ( ( SELECT vat.getVatId(  18::DECIMAL ) ), ( SELECT vat.getVatNames( 'VAT'	) ), 'Мальта', 'MT', 'MLT', 'malta.png'), --20
	  ( ( SELECT vat.getVatId(  20::DECIMAL ) ), ( SELECT vat.getVatNames( 'TVA'	) ), 'Молдавия', 'MD', 'MDA', 'moldova.png' ), --21
	  ( ( SELECT vat.getVatId(  25::DECIMAL ) ), ( SELECT vat.getVatNames( 'MVA'	) ), 'Норвегия', 'NO', 'NOR', 'norway.png' ), --22
	  ( ( SELECT vat.getVatId(  23::DECIMAL ) ), ( SELECT vat.getVatNames( 'PTU/VAT') ), 'Польша', 'PL', 'POL', 'poland.png' ),--23
	  ( ( SELECT vat.getVatId(  23::DECIMAL ) ), ( SELECT vat.getVatNames( 'IVA'	) ), 'Португалия', 'PT', 'PRT', 'portugal.png' ),--24
	  ( ( SELECT vat.getVatId(  20::DECIMAL ) ), ( SELECT vat.getVatNames( 'НДС'	) ), 'Россия', 'RU', 'RUS', 'russia.png' ),--25
	  ( ( SELECT vat.getVatId(  19::DECIMAL ) ), ( SELECT vat.getVatNames( 'TVA'	) ), 'Румыния', 'RO', 'ROU', 'romania.png' ),--26	
	  ( ( SELECT vat.getVatId(  20::DECIMAL ) ), ( SELECT vat.getVatNames( 'PDV'	) ), 'Сербия', 'RS', 'SRB', 'serbia.png' ),--27
	  ( ( SELECT vat.getVatId(  20::DECIMAL ) ), ( SELECT vat.getVatNames( 'DPH'	) ), 'Словакия', 'SK', 'SVK', 'slovakia.png' ),--28
	  ( ( SELECT vat.getVatId(  22::DECIMAL ) ), ( SELECT vat.getVatNames( 'DDV'	) ), 'Словения', 'SI', 'SVN', 'slovenia.png' ), --29	
	  ( ( SELECT vat.getVatId(  18::DECIMAL ) ), ( SELECT vat.getVatNames( 'KDV'	) ), 'Турция', 'TR', 'TUR', 'turkey.png'), --30
	  ( ( SELECT vat.getVatId(  20::DECIMAL ) ), ( SELECT vat.getVatNames( 'ПДВ'	) ), 'Украина', 'UA', 'UKR', 'ukraine.png' ),--31
	  ( ( SELECT vat.getVatId(  24::DECIMAL ) ), ( SELECT vat.getVatNames( 'ALV'	) ), 'Финляндия', 'FI', 'FIN', 'finland.png' ),--32
	  ( ( SELECT vat.getVatId(  20::DECIMAL ) ), ( SELECT vat.getVatNames( 'TVA'	) ), 'Франция', 'FR', 'FRA', 'france.png' ), --33
	  ( ( SELECT vat.getVatId(  25::DECIMAL ) ), ( SELECT vat.getVatNames( 'PDV'	) ), 'Хорватия', 'HR', 'HRV', 'croatia.png' ),--34
	  ( ( SELECT vat.getVatId(  19::DECIMAL ) ), ( SELECT vat.getVatNames( 'PDV'	) ), 'Черногория', 'ME', 'MNE', 'montenegro.png' ),--35
	  ( ( SELECT vat.getVatId(  21::DECIMAL ) ), ( SELECT vat.getVatNames( 'DPH'	) ), 'Чехия', 'CZ', 'CZE', 'czech_republic.png' ),--36
	  ( ( SELECT vat.getVatId( 7.7::DECIMAL ) ), ( SELECT vat.getVatNames( 'MwSt' 	) ), 'Швейцария', 'CH', 'CHE', 'switzerland.png' ), --37
	  ( ( SELECT vat.getVatId(  25::DECIMAL ) ), ( SELECT vat.getVatNames( 'MOMS'	) ), 'Швеция', 'SE', 'SWE', 'sweden.png' ),--38
	  ( ( SELECT vat.getVatId(  20::DECIMAL ) ), ( SELECT vat.getVatNames( 'KM'		) ), 'Эстония', 'EE', 'EST', 'estonia.png' );--39


-- ***********
CREATE TABLE adres.сities (
	city_id SERIAL UNIQUE,
	city_name VARCHAR( 256 ) NOT NULL UNIQUE,
	country_id INTEGER,
	PRIMARY KEY ( city_id )
);


-- ***********
CREATE TABLE adres.adress (
	adres_id SERIAL UNIQUE,
	country_id INTEGER,
	city_id INTEGER,
	street_id INTEGER,
	adres_type Type_Adress, -- тип адреса (физический, юридический)
	PRIMARY KEY ( adres_id ),
	FOREIGN KEY ( country_id ) REFERENCES adres.countrys ( country_id ) ON DELETE SET NULL,
	FOREIGN KEY ( city_id ) REFERENCES adres.cities ( city_id ) ON DELETE SET NULL,
	FOREIGN KEY ( street_id ) REFERENCES adres.streets ( street_id ) ON DELETE SET NULL,
	CHECK ( adres_type IN ( 'Физический', 'Юридический') )
);


-- ***********
CREATE OR REPLACE MATERIALIZED VIEW adres.adressView AS
	SELECT ad.adres_id, cntr.country_icon, cntr.country_name, ad.adres_index, ct.city_name, st.street_name
FROM adres.adress AS ad 
	LEFT JOIN adres.countrys AS cntr ON ad.country_id = cntr.country_id
	LEFT JOIN adres.cities AS ct ON ad.city_id = ct.city_id
	LEFT JOIN adres.streets AS st ON ad.street_id = st.street_id;
	

-- ***********
CREATE FUNCTION adres.getCountryId ( cntr VARCHAR ) RETURNS INTEGER AS
$$
	SELECT country_id FROM adres.countrys WHERE country_name = cntr;
$$ LANGUAGE SQL;


-- ***********
CREATE FUNCTION adres.getCityId ( ct VARCHAR ) RETURNS INTEGER AS 
$$ 
	SELECT city_id FROM adres.cities WHERE city_name = ct;
$$ LANGUAGE SQL;


-- ***********
CREATE FUNCTION adres.getStreetId( st VARCHAR ) RETURNS INTEGER AS 
$$ 
	DECLARE id INTEGER IS NULL;
	BEGIN
		id = ( SELECT street_id FROM adres.streets WHERE street_name = st );
		IF ( id IS NULL ) THEN
			INSERT INTO adres.streets ( street_name ) VALUES ( 'st' ); 
			id = ( SELECT lastval() );
		END IF;
	RETURN id;
	END;
$$ LANGUAGE SQL;


-- ***********
CREATE OR REPLACE PROCEDURE insertAdress ( cntr VARCHAR, ct VARCHAR, strt VARCHAR, idx VARCHAR, type_adress VARCHAR ) LANGUAGE SQL AS 
$$
	INSERT INTO adres.adress ( country_id, city_id, street_id, adres_index, adres_type )
	VALUES (  
			  ( SELECT adres.getCountryId( cntr ) ),
			  ( SELECT adres.getCityId( ct ) ), 
			  ( SELECT adres.getStreetId( strt ) ), 
			  idx, 
			  type_adress
		   );
$$;




