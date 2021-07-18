-- ордера

CREATE SCHEMA IF NOT EXISTS orders;

-- ***********
CREATE TABLE orders (
        order_id SERIAL UNIQUE,                                                 -- PK
        shipper_id INTEGER,                                                     -- FK отправитель грузов (shipper)
        emploee_id INTEGER,                                                     -- FK работник ( в т.ч. водители )
        payment_id INTEGER,                                                     -- FK оплата
        route_id INTEGER,                                                       -- FK маршрут ( их храним )
        order_date DATE,                                                        -- дата создания ордера
        order_contractNumber VARCHAR(200),                                      -- номер договора - основания
        order_note TEXT                                                         -- заметки по договору
        FOREIGN KEY ( shipper_id ) REFERENCES shipper.shippers ( shipper_id ),  -- NO ACTION по умолчанию
        FOREIGN KEY ( emploee_id ) REFERENCES emploee.emploees ( emploee_id ),  -- NO ACTION по умолчанию
	FOREIGN KEY ( payment_id ) REFERENCES 
        FOREIGN KEY ( route_id ) REFERENCES route.routes ( route_id )           -- NO ACTION по умолчанию
);

