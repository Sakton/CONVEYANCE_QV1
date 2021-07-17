-- отправитель грузов (shipper)

CREATE SCHEMA IF NOT EXISTS shipper;


-- ***********
CREATE TABLE shipper.shippers (
	shipper_id SERIAL UNIQUE, -- PK
	shipper_name VARCHAR(200)
);


--тестировать
-- ***********
CREATE OR REPLACE FUNCTION shipper.getShipper_id( shipperName VARCHAR ) RETURNS INTEGER AS
$$
DECLARE id INTEGER;
	BEGIN
		id = ( SELECT shipper_id FROM shipper.shippers WHERE  shipper_name = shipperName );
		IF ( id IS NULL ) THEN
			BEGIN
				INSERT INTO shipper.shippers ( shipper_name ) VALUES (shipperName);
				id = ( SELECT lastval( ) ) ;
			END;
		END IF;
		RETURN id;
	END;
$$
LANGUAGE plpgsql;

--test
/*
SELECT shipper.getShipper_id('R & K');
SELECT shipper.getShipper_id('Красное - Белое');
*/