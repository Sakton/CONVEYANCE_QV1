CREATE SCHEMA wagons;

CREATE TABLE wagons.autos (
    auto_id SERIAL UNIQUE,
    auto_brand VARCHAR(64),
    auto_vin VARCHAR(17) UNIQUE,
    auto_lenthtrailer NUMERIC(4,2),
    auto_widthtrailer NUMERIC(4,2),
    auto_heighttrailer NUMERIC(4,2),
    auto_datawork DATE,
    auto_datagto DATE,
    PRIMARY KEY( auto_id )
);
