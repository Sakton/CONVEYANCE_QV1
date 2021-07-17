-- НДС с названиями по странам

CREATE SCHEMA IF NOT EXISTS vat;

-- ***********
CREATE TABLE vat.vats (
    vat_id SERIAL UNIQUE,
    vat_stavka decimal(4, 2) NOT NULL UNIQUE,
    CONSTRAINT vats_valid CHECK ( vat_stavka > 0 AND vat_stavka < 100 ),
    PRIMARY KEY ( vat_id )
);

-- ***********
INSERT INTO vat.vats ( vat_stavka )
VALUES (20), (13), (10),(0.5),(12),(6),(9),(5),(27),(18),(19),(7),(24),(25),(13.5),(4.8),(11),(4),(8),(3.8),(2.5),(17),
       (14), (3), (15), (23), (9.5), (1), (5.5), (2.1), (7.7), (3.7), (22), (21)
ON CONFLICT ( vat_stavka ) DO NOTHING; --ничего не делать если уже есть такая запись

-- ***********
CREATE TABLE vat.vatnames (
    vatname_id SERIAL UNIQUE,
    vatname_name VARCHAR( 10 ) UNIQUE,
    PRIMARY KEY ( vatname_id )
);

-- ***********
INSERT INTO vat.vatnames( vatname_name )
VALUES ('USt'),('TVSH'),('BTW/TVA'),('DDS'),('VAT'),('AFA'),('USt'),('BTW'),('FPA'),('MOMS'),('VAT'),('VASK'),('IVA'),('IVA'),('FPA'),
       ('PVN'),('PVM'),('MwSt'),('MwSt'),('VAT'),('TVA'),( 'MVA'),('PTU/VAT'),('IVA'),('НДС'),('TVA'),('PDV'),('DPH'),('DDV'),('KDV'),
       ('ПДВ'),('ALV'),('TVA'),('PDV'),('PDV'),('DPH'),('MwSt'),('MOMS'),('KM')
ON CONFLICT ( vatname_name ) DO NOTHING;

-- ***********
CREATE OR REPLACE FUNCTION vat.getVatId ( vat_st DECIMAL ) RETURNS INTEGER AS
$$
    SELECT vat_id FROM vat.vats WHERE vat_stavka = vat_st;
$$ LANGUAGE SQL;

-- ***********
CREATE OR REPLACE FUNCTION vat.getVatNames ( nm VARCHAR ) RETURNS INTEGER AS
$$
    SELECT vatname_id FROM vat.vatnames WHERE vatname_name = nm;
$$ LANGUAGE SQL;

