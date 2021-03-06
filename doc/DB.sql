/*
-- чистовик
CREATE DATABASE demo_coveyance_db;

CREATE TABLE vats (
	vat_id SERIAL UNIQUE,
	vat_stavka decimal(4, 2) NOT NULL UNIQUE,
	CONSTRAINT vats_valid CHECK ( vat_stavka > 0 AND vat_stavka < 100 ),
	PRIMARY KEY ( vat_id )
);

CREATE TABLE vatnames (
	vatname_id SERIAL UNIQUE,
	vatname_name VARCHAR( 10 ),
	PRIMARY KEY ( vatname_id )
);

CREATE TABLE сities (
	city_id SERIAL UNIQUE,
	city_name VARCHAR( 256 ) NOT NULL UNIQUE,
	country_id INT,
	PRIMARY KEY ( city_id )
);

CREATE TABLE streets (
	street_id SERIAL UNIQUE,
	street_name varchar ( 256 ) NOT NULL UNIQUE
);



CREATE TABLE countrys (
	country_id SERIAL UNIQUE,
	vat_id INT NOT NULL,
	vatname_id INT NOT NULL,
	country_name VARCHAR(256) NOT NULL UNIQUE,
	country_abbreviated_2 VARCHAR(4) NOT NULL UNIQUE,
	country_abbreviated_3 VARCHAR(4) NOT NULL UNIQUE,
	country_icon VARCHAR(256),
	PRIMARY KEY ( country_id ),
	FOREIGN KEY ( vat_id ) REFERENCES vats ( vat_id )
		ON UPDATE SET NULL ON DELETE SET NULL,
	FOREIGN KEY ( vatname_id ) REFERENCES vatnames ( vatname_id )
		ON UPDATE SET NULL ON DELETE SET NULL
);




CREATE OR REPLACE FUNCTION get_vat_id ( vat_st DECIMAL ) RETURNS INT AS
	' SELECT vat_id FROM vats WHERE vat_stavka = vat_st; '
LANGUAGE SQL;


CREATE OR REPLACE VIEW adress_view AS
 SELECT ad.adres_id,
        cntr.country_icon,
		cntr.country_name,
		ad.adres_index,
		ct.city_name,
		st.street_name
   FROM adress ad
     LEFT JOIN countrys cntr ON ad.country_id = cntr.country_id
     LEFT JOIN cities ct ON ad.city_id = ct.city_id
     LEFT JOIN streets st ON ad.street_id = st.street_id;
	 


--ALTER TABLE adress ADD COLUMN adres_index VARCHAR(10);

CREATE FUNCTION id_country ( cntr VARCHAR ) RETURNS INT AS 
	'SELECT country_id FROM countrys WHERE country_name = cntr' LANGUAGE SQL;

	
CREATE FUNCTION id_city ( ct VARCHAR ) RETURNS INT AS 
	' SELECT city_id FROM cities WHERE city_name = ct ' LANGUAGE SQL;

CREATE FUNCTION id_street( st VARCHAR ) RETURNS INT AS
	'SELECT street_id FROM streets WHERE street_name = st' LANGUAGE SQL;
		


CREATE OR REPLACE PROCEDURE insert_adress ( cntr VARCHAR, ct VARCHAR, strt VARCHAR, type_adress Type_Adress DEFAULT 'FACT' ) LANGUAGE SQL AS 
$$
	INSERT INTO adress ( country_id, city_id, street_id, adres_type )
	VALUES (  ( SELECT id_country( cntr ) ), ( SELECT id_city( ct ) ), ( SELECT id_street( strt ) ), type_adress );
$$;
*/

/*
CREATE OR REPLACE FUNCTION id_vatnames ( nm VARCHAR ) RETURNS INT AS
    ' SELECT vatname_id FROM vatnames WHERE vatname_name = nm '
LANGUAGE SQL;
*/

/*
CREATE OR REPLACE FUNCTION get_id_country ( nm VARCHAR ) RETURNS INT AS
 'SELECT country_id FROM countrys WHERE country_name = nm'
LANGUAGE SQL;
*/

-- *************
CREATE FUNCTION insertOrIgnoreStreet( strt VARCHAR ) RETURNS VOID AS
$$
BEGIN
	IF ( SELECT street_id FROM streets WHERE street_name = 'strt' ) IS NULL
	THEN  INSERT INTO streets ( street_name ) VALUES ( 'strt' );
	RETURN;
	END IF;
END;
$$
LANGUAGE plpgsql;
--**************


-- *************
CREATE OR REPLACE FUNCTION insertOrIgnoreStreet( strt VARCHAR ) RETURNS BOOL AS
$$
BEGIN
	IF(  SELECT street_id FROM streets WHERE street_name = strt ) IS NULL
		THEN  INSERT INTO streets ( street_name ) VALUES ( strt );
			RETURN TRUE;
		ELSE 
			RETURN FALSE;
	END IF;
END;
$$
LANGUAGE plpgsql;
--**************


CREATE OR REPLACE FUNCTION cast_TypeAdress ( nameTypeAdress VARCHAR ) RETURNS VOID AS
$$
BEGIN
	SELECT CASE nameTypeAdress WHEN 'Фактический' THEN 'FACT'::Type_Adress ELSE 'LEGAL'::Type_Adress END;
END;
$$
LANGUAGE SQL;





























