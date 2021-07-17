-- работник ( не только водитель кто угодно )
CREATE SCHEMA IF NOT EXISTS emploee;


-- ***********
CREATE TABLE emploee.emploees (
	emploee_id SERIAL UNIQUE, -- PK
	emploee_name VARCHAR(200) --имя работника
);


-- ***********
CREATE OR REPLACE FUNCTION emploee.getEmploee_id ( nameEmploee VARCHAR ) RETURNS INTEGER AS
$$
	DECLARE id INTEGER DEFAULT NULL;
	BEGIN
		id = ( SELECT emploee_id FROM emploee.emploees WHERE  emploee_name = nameEmploee );
		IF ( id IS NULL ) THEN
			BEGIN
				INSERT INTO emploee.emploees ( emploee_name ) VALUES ( nameEmploee );
				id = ( SELECT lastval() );
			END;
		END IF;
		RETURN id;
	END;
$$ LANGUAGE plpgsql;

-- test
SELECT emploee.getEmploee_id ( 'Васька Пупочек' );
SELECT emploee.getEmploee_id ( 'Васька Пупочек Пупочек' );