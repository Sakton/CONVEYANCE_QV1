-- ОПЛАТА

CREATE SCHEMA IF NOT EXISTS payment;


-- ТАБЛИЦА ОПЛАТА
CREATE TABLE payment.payments (
	payment_id SERIAL UNIQUE,	    -- PK
	payment_cost NUMERIC(32, 2),	    -- ОПЛАТА ( деньги )
	payment_period VARCHAR( 64 ),	    -- ПЕРИОД ОПЛАТЫ ( поле под замену на FK ( пока для теста ) )
	payment_currency VARCHAR( 64 ),	    -- ВАЛЮТА ОПЛАТЫ ( поле под замену на FK ( пока для теста ) )
	PRIMARY KEY( payment_id )
);


-- ФУНКЦИЯ ВСТАВКИ ОПЛАТЫ
CREATE OR REPLACE PROCEDURE payment.insertPayment ( cost NUMERIC, period VARCHAR, currency VARCHAR ) LANGUAGE SQL AS
$$
	INSERT INTO payment.payments ( payment_cost, payment_period, payment_currency )
	VALUES ( cost, period, currency );
$$;


-- ФУНКЦИЯ ВОЗВРАТА ID ОПЛАТЫ
CREATE OR REPLACE FUNCTION payment.getPayment_id ( cost NUMERIC, period VARCHAR, currency VARCHAR ) RETURNS INTEGER LANGUAGE plpgsql AS
$$
    DECLARE id INTEGER DEFAULT NULL;
	BEGIN
	    id = ( SELECT payment_id FROM payment.payments WHERE payment_cost = cost
							   AND payment_period = period
							   AND payment_currency = currency );
		IF ( id IS NULL ) THEN
			BEGIN
				CALL payment.insertPayment( cost, period, currency );
				id = ( SELECT lastval() );
			END;
		END IF;
	RETURN id;
	END;
$$;













