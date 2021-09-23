CREATE SCHEMA wagons;

-- ТЯГАЧ
CREATE TABLE wagons.pullings (
    pulling_id SERIAL UNIQUE,
    pulling_name VARCHAR(128),
    pulling_vin VARCHAR(17),
    pulling_datawork DATE,
    pulling_datagto DATE,
    PRIMARY KEY( pulling_id )
);

-- ОПИСАНИЕ ПРИЦЕПА
CREATE TABLE wagons.description_semitrailers (
    description_semitrailer_id SERIAL UNIQUE,
    description_semitrailer_description TEXT,
    PRIMARY KEY(description_semitrailer_id)
);

-- ПРИЦЕП-ФУРА
CREATE TABLE wagons.semitrailers (
    semitrailer_id SERIAL UNIQUE,			    -- PK
    semitrailer_name VARCHAR(64),			    -- имя типа
    semitrailer_carrying NUMERIC(4, 2),			    -- грузоподьемность
    semitrailer_gabarit_lenth  NUMERIC(4, 2),		    -- длина
    semitrailer_gabarit_width  NUMERIC(4, 2),		    -- ширина
    semitrailer_gabarit_height NUMERIC(4, 2),		    -- высота
    semitrailer_img VARCHAR(64),			    -- имя файла картинки
    description_semitrailer_id INTEGER,			    -- описание типа
    PRIMARY KEY( semitrailer_id ),
    FOREIGN KEY( description_semitrailer_id ) REFERENCES cars.description_semitrailers ( description_semitrailer_id )
	ON UPDATE CASCADE ON DELETE SET NULL
);

CREATE TABLE wagons.pillings_semitrailers(
    pulling_id INTEGER,
    semitrailer_id INTEGER,
    FOREIGN KEY ( pulling_id ) REFERENCES wagons.pullings ( pulling_id )
	ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY ( semitrailer_id ) REFERENCES wagons.semitrailers ( semitrailer_id )
	ON DELETE CASCADE ON UPDATE CASCADE
);
