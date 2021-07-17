CREATE SCHEMA IF NOT EXISTS contract;

CREATE TABLE contracts (
	contract_id SERIAL UNIQUE, -- 
	shipper_id INTEGER, -- отправитель грузов (shipper)
	emploee_id INTEGER, -- работник ( в т.ч. водители )
	routes_id INTEGER, -- маршрут ( их храним )
	contract_date DATE, -- дата создания договора
	contract_number VARCHAR(200), -- номер договора
	
	contract_note TEXT --заметки по договору
);
