-- отправитель грузов (shipper)

-- СОЗДАТЬ ОБЛАТЬ ИМЕН "ГРУЗОТПРАВИТЕЛЬ"
CREATE SCHEMA IF NOT EXISTS shipper;


-- ТАБЛИЦА "ГРУЗОТПРАВИТЕЛИ"
CREATE TABLE shipper.shippers (
shipper_id SERIAL UNIQUE, -- PK
shipper_name VARCHAR(200) -- наименование заказчика ( грузоотправитель )
);


-- ПРОЦЕДУРА ВСТАВКИ В БАЗУ ГРУЗОТПРАВИТЕЛЯ, ЕСЛИ ТАКОЙ УЖЕ ЕСТЬ ТО ИГНОРИРОВАТЬ ВСТАВКУ
CREATE PROCEDURE shipper.addShipper() LANGUAGE SQL AS
$$

$$;

--тестировать
-- ФУНКЦИЯ ПОЛУЧЕНИЯ ID ОТПРАВИТЕЛЯ ПО ИМЕНИ, ЕСЛИ ТАКОГО ОПРАВИТЕЛЯ НЕТ ТО ЕГО ВСТАВКА В БАЗУ
CREATE OR REPLACE FUNCTION shipper.getShipper_id( shipperName VARCHAR ) RETURNS INTEGER AS
$$
DECLARE id INTEGER;
BEGIN
id = ( SELECT shipper_id FROM shipper.shippers WHERE  shipper_name = shipperName );
IF ( id IS NULL ) THEN
BEGIN
INSERT INTO shipper.shippers ( shipper_name ) VALUES ( shipperName );
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
