-- маршрут

CREATE SCHEMA IF NOT EXISTS route;


-- ***********
CREATE TABLE route.routes (
	route_id SERIAL UNIQUE, --PK
--	adres_id INTEGER, -- адрес старта
--	adres_id INTEGER, -- адрес прибытия
	route_arrival INTEGER, -- доезд ( прибытие ) км.
	route_route INTEGER, -- маршрут ( путь ) км.
 	route_ante MONEY -- ставка ( усл. ед. )
);


-- ***********
CREATE OR REPLACE PROCEDURE route.insertRoute(arrival INTEGER, rout INTEGER, ante NUMERIC) LANGUAGE SQL AS
$$
	INSERT INTO route.routes(route_arrival, route_route, route_ante) VALUES (arrival, rout, ante::MONEY);
$$;


-- ***********
CALL route.insertRoute( 100, 200, 300.25);


-- ***********
CREATE OR REPLACE FUNCTION route.getRout_id ( arrival INTEGER, route INTEGER, ante NUMERIC ) RETURNS INTEGER AS
$$
DECLARE id INTEGER DEFAULT NULL;
	BEGIN
		id = ( SELECT route_id FROM route.routes WHERE route_arrival = arrival
													AND route_route = route
													AND route_ante = ante::MONEY);
		IF ( id IS NULL ) THEN
			BEGIN
				CALL route.insertRoute(arrival, route, ante);
				id = ( SELECT lastval() );
			END;
		END IF;
	RETURN id;
	END;
$$ LANGUAGE plpgsql;


--test
/*
SELECT route.getRout_id ( 1, 2, 3.3 );
SELECT route.getRout_id ( 11, 12, 13.3 );
*/





