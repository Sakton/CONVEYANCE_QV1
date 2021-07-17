-- оплата

CREATE SCHEMA IF NOT EXISTS payment;


-- ***********
CREATE TABLE payment.payments (
	payment_id SERIAL UNIQUE, -- PK
	payment_cost MONEY, -- оплата ( деньги )
	payment_period VARCHAR(10), -- период оплаты ( поле под замену на FK ( пока для теста ) )
	payment_currency VARCHAR(10) -- валюта оплаты ( поле под замену на FK ( пока для теста ) )
);


-- ***********
CREATE PROCEDURE payment.insertPayment ( cost NUMERIC, period VARCHAR, currency VARCHAR ) LANGUAGE SQL AS
$$
	INSERT INTO payment.payments ( payment_cost, payment_period, payment_currency )
	VALUES ( cost::MONEY, 'period', 'currency' );
$$;


-- ***********
CREATE FUNCTION payment.getPayment_id ( cost NUMERIC, period VARCHAR, currency VARCHAR ) RETURNS INTEGER AS
$$
	DECLARE id INTEGER DEFAULT NULL;
	BEGIN
		id = ( SELECT payment_id FROM payment.payments WHERE payment_cost = cost::MONEY
                                                                AND payment_period = period,
                                                                AND payment_currency = currency );
		IF ( id IS NULL ) THEN
			BEGIN
				CALL payment.insertPayment( cost, period, currency );
				id = ( SELECT lastval() );
			END;
		END IF;
	RETURN id;
	END;
$$ LANGUAGE plpgsql;













