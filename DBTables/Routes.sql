-- маршрут

CREATE SCHEMA IF NOT EXISTS route;


-- ТАБЛИЦА "МАРШРУТ"
CREATE TABLE route.routes (
	route_id SERIAL UNIQUE,		-- PK
--	adres_id INTEGER,		-- АДРЕС ОТКУДА
--	adres_id INTEGER,		-- АДРЕС КУДА
	route_arrival INTEGER,		-- ДОЕХАТЬ ДО МЕСТА ЗАГРУЗКИ (ОТКУДА)
	route_route INTEGER,		-- МАРШРУТ (КМ)
	route_ante MONEY,		-- ставка ( усл. ед. )
	PRIMARY KEY ( route_id )	-- PK
);


-- ВРЕМЕННАЯ ПРОЦЕДУРА ВСТВКИ МАРШРУТА
CREATE OR REPLACE PROCEDURE route.insertRoute( arrival INTEGER, rout INTEGER, ante NUMERIC ) LANGUAGE SQL AS
$$
    INSERT INTO route.routes( route_arrival, route_route, route_ante ) VALUES ( arrival, rout, ante::MONEY );
$$;


-- пробная ( стереть )
CALL route.insertRoute( 100, 200, 300.25 );


-- ФУНКЦИЯ ВСТАВКИ ПУТИ И ВОЗВРАТА ID (  )
CREATE OR REPLACE FUNCTION route.getRouteId ( arrival INTEGER, route INTEGER, ante NUMERIC ) RETURNS INTEGER LANGUAGE plpgsql AS
$$
DECLARE id INTEGER DEFAULT NULL;
    BEGIN
	id = ( SELECT route_id FROM route.routes WHERE route_arrival = arrival
						 AND route_route = route
						 AND route_ante = ante::MONEY );
	IF ( id IS NULL ) THEN
	    BEGIN
		CALL route.insertRoute( arrival, route, ante );
		id = ( SELECT lastval() );
	    END;
	END IF;
    RETURN id;
    END;
$$;


--test
/*
SELECT route.getRout_id ( 1, 2, 3.3 );
SELECT route.getRout_id ( 11, 12, 13.3 );
*/






