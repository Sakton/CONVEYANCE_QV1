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
	order_contractNumber VARCHAR( 200 ),                                    -- номер договора - основания
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
        FOREIGN KEY ( route_id   ) REFERENCES route.routes ( route_id )     -- FK NO ACTION по умолчанию
);
-- **** - возможно переедут в отдельную сущность

-- ПРОЦЕДУРА ВСТАВКИ В ТАБЛИЦУ
CREATE PROCEDURE orders.addOrder( idShipper INTEGER,
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
