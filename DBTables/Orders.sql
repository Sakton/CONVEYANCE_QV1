-- ОРДЕРА

CREATE SCHEMA IF NOT EXISTS orders;

-- ТАБЛИЦА "ОРДЕРА"
CREATE TABLE orders.orders (
        order_id SERIAL UNIQUE,                                                 -- PK
        shipper_id INTEGER,                                                     -- FK отправитель грузов (shipper)
        emploee_id INTEGER,                                                     -- FK работник ( в т.ч. водители )
        payment_id INTEGER,                                                     -- FK оплата
	route_id INTEGER,                                                       -- FK маршрут ( их храним )
        document_id INTEGER,                                                    -- FK документы
        order_data DATE,                                                        -- дата создания ордера
	order_contractNumber VARCHAR( 200 ) UNIQUE,                             -- номер договора - основания
	order_note TEXT,	                                                -- заметки по договору

/*
	order_post_period VARCHAR( 10 ),					-- **** период отправки
	order_2copy_cmr INTEGER,						-- **** 2копии ЦМР
	order_original_contract INTEGER,					-- **** оригинал контракта
*/

	PRIMARY KEY ( order_id   ),						-- PK
	FOREIGN KEY ( shipper_id ) REFERENCES shipper.shippers ( shipper_id ),  -- FK NO ACTION по умолчанию
	FOREIGN KEY ( emploee_id ) REFERENCES emploee.emploees ( emploee_id ),  -- FK NO ACTION по умолчанию
	FOREIGN KEY ( payment_id ) REFERENCES payment.payments ( payment_id ),	-- FK NO ACTION по умолчанию
	FOREIGN KEY ( route_id   ) REFERENCES route.routes     ( route_id   )     -- FK NO ACTION по умолчанию
);
-- **** - возможно переедут в отдельную сущность

-- ПРОЦЕДУРА ВСТАВКИ В ТАБЛИЦУ
CREATE PROCEDURE orders.addOrder(
			    idShipper INTEGER,
			    idEmploee INTEGER,
			    idPayment INTEGER,
			    idRoute INTEGER,
			    idDocuments INTEGER,
			    dataOrder DATE,
			    contractNumber VARCHAR,
			    noteOrder TEXT) LANGUAGE SQL AS
$$
    INSERT INTO orders.orders( shipper_id, emploee_id, payment_id, route_id, document_id, order_data, order_contractNumber, order_note )
        VALUES ( idShipper, idEmploee, idPayment, idRoute, idDocuments, dataOrder, contractNumber, noteOrder );
$$;

-- ПРЕДСТАВЛЕНИЕ ОРДЕРА 1
CREATE OR REPLACE VIEW orders.ordersView AS
    SELECT ord.order_data, ord.order_contractNumber,
	   shp.shipper_name,
	   emp.emploee_name,
	   pay.payment_cost, pay.payment_currency, pay.payment_period,
	   rou.route_arrival, rou.route_route,
			CASE
			    WHEN (rou.route_arrival + rou.route_route) = 0 THEN 0
			    ELSE ( pay.payment_cost / ( rou.route_arrival + rou.route_route ) )
			END
			    AS stavka,
	   doc.document_original, doc.document_2copycmr, doc.document_postperiod,
	   ord.order_note,
	   -- iDys
	   ord.order_id, ord.shipper_id, ord.emploee_id, ord.payment_id, ord.route_id, ord.document_id
    FROM orders.orders AS ord
	INNER JOIN shipper.shippers   AS shp ON ord.shipper_id  = shp.shipper_id
	INNER JOIN emploee.emploees   AS emp ON ord.emploee_id  = emp.emploee_id
	INNER JOIN payment.payments   AS pay ON ord.payment_id  = pay.payment_id
	INNER JOIN route.routes	      AS rou ON ord.route_id    = rou.route_id
	INNER JOIN document.documents AS doc ON ord.document_id = doc.document_id;


CREATE PROCEDURE orders.addToOrder(
			     orderDate VARCHAR,
			     orderNumber VARCHAR,
			     shipperId INTEGER,
			     emploeeId INTEGER, -- 1
			     paymentCost NUMERIC,
			     paymentPeriod VARCHAR,
			     paymentCurrency VARCHAR, --2
			     routesArrival INTEGER,
			     routesRoute INTEGER, --3
			     documentPostPeriod VARCHAR,
			     document2CopyCmr INTEGER,
			     documentOriginal INTEGER, --4
			     oderNote VARCHAR) LANGUAGE SQL AS
$$
    INSERT INTO orders.orders ( shipper_id, emploee_id, payment_id, route_id, document_id, order_data, order_contractNumber, order_note )
    VALUES ( shipperId, emploeeId,
				    ( SELECT payment.getPayment_id( paymentCost, paymentPeriod, paymentCurrency ) ),
				    ( SELECT route.getRouteId( routesArrival, routesRoute ) ),
				    ( SELECT document.getDocumentId( documentPostPeriod, document2CopyCmr, documentOriginal ) ),
	    orderDate::date, orderNumber, oderNote );
$$;

CREATE PROCEDURE orders.updateOrder(
			    orderId INTEGER,
			    orderDate VARCHAR,
			    orderNumber VARCHAR,
			    shipperId INTEGER,
			    emploeeId INTEGER, -- 1
			    paymentCost NUMERIC,
			    paymentPeriod VARCHAR,
			    paymentCurrency VARCHAR, --2
			    routesArrival INTEGER,
			    routesRoute INTEGER, --3
			    documentPostPeriod VARCHAR,
			    document2CopyCmr INTEGER,
			    documentOriginal INTEGER, --4
			    oderNote VARCHAR) LANGUAGE SQL AS
$$
    UPDATE orders.orders
    SET shipper_id  = shipperId,
	emploee_id  = emploeeId,
	payment_id  = ( SELECT payment.getPayment_id( paymentCost, paymentPeriod, paymentCurrency ) ),
	route_id    = ( SELECT route.getRouteId( routesArrival, routesRoute ) ),
	document_id = ( SELECT document.getDocumentId( documentPostPeriod, document2CopyCmr, documentOriginal ) ),
	order_data  = orderDate::date,
	order_contractNumber = orderNumber,
	order_note  = oderNote
    WHERE order_id  = orderId;
$$;

