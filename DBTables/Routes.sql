-- маршрут

CREATE SCHEMA IF NOT EXISTS route;


-- ТАБЛИЦА "МАРШРУТ"
CREATE TABLE route.routes (
	route_id SERIAL UNIQUE,		-- PK
--	adres_id INTEGER,		-- АДРЕС ОТКУДА
--	adres_id INTEGER,		-- АДРЕС КУДА
	route_arrival INTEGER,		-- ДОЕХАТЬ ДО МЕСТА ЗАГРУЗКИ (ОТКУДА)
	route_route INTEGER,		-- МАРШРУТ (КМ)
	PRIMARY KEY ( route_id )	-- PK
);


-- ВРЕМЕННАЯ ПРОЦЕДУРА ВСТВКИ МАРШРУТА
CREATE OR REPLACE PROCEDURE route.insertRoute( arrival INTEGER, rout INTEGER ) LANGUAGE SQL AS
$$
    INSERT INTO route.routes( route_arrival, route_route ) VALUES ( arrival, rout );
$$;


-- ФУНКЦИЯ ВСТАВКИ ПУТИ И ВОЗВРАТА ID (  )
CREATE OR REPLACE FUNCTION route.getRouteId ( arrival INTEGER, route INTEGER ) RETURNS INTEGER LANGUAGE plpgsql AS
$$
DECLARE id INTEGER DEFAULT NULL;
    BEGIN
	id = ( SELECT route_id FROM route.routes WHERE route_arrival = arrival
						 AND route_route = route );
	IF ( id IS NULL ) THEN
	    BEGIN
		CALL route.insertRoute( arrival, route );
		id = ( SELECT lastval() );
	    END;
	END IF;
    RETURN id;
    END;
$$;







