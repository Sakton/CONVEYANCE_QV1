
-- ПРОСТРАНСТВО ИМЕН ДОКУМЕНТЫ - ИХ НАЛИЧИЕ ДВИЖЕНИЕ И ТД.
CREATE SCHEMA document;

CREATE TABLE document.documents (
    document_id SERIAL UNIQUE,
    document_postperiod VARCHAR(64),
    document_2copycmr INTEGER,
    document_original INTEGER,
    PRIMARY KEY ( document_id )
);

-- ПРОЦЕДУРА ВСТАВКИ В ТАБЛИЦУ
CREATE PROCEDURE document.insertDocuments ( postPeriod VARCHAR, copyCmr INTEGER, originalDocuments INTEGER ) LANGUAGE SQL AS
$$
    INSERT INTO document.documents (document_postperiod, document_2copycmr, document_original)
        VALUES ( postPeriod, copyCmr, originalDocuments );
$$;

-- ФУНКЦИЯ ПОЛУЧЕНИЯ ID ЕСЛИ ТАКЯ ЗАПИСЬ ЕСТЬ, ИЛИ ВСТАВКА ЗАПИСИ ЕСЛИ ТАКОЙ НЕТ
CREATE FUNCTION document.getDocumentId( postPeriod VARCHAR, copyCmr INTEGER, originalDocuments INTEGER ) RETURNS INTEGER LANGUAGE plpgsql AS
$$
    DECLARE id INTEGER DEFAULT NULL;
    BEGIN
        id = ( SELECT document_id FROM document.documents WHERE document_postperiod = postPeriod
                                                            AND document_2copycmr = copyCmr
                                                            AND document_original = originalDocuments );
        IF ( id IS NULL ) THEN
            BEGIN
                CALL document.insertDocuments( postPeriod, copyCmr, originalDocuments );
                id = ( SELECT lastval() );
            END;
        END IF;
        RETURN id;
    END;
$$;
