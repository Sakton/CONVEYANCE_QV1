--
-- PostgreSQL database dump
--

-- Dumped from database version 13.1
-- Dumped by pg_dump version 13.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: adres; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA adres;


ALTER SCHEMA adres OWNER TO postgres;

--
-- Name: cars; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA cars;


ALTER SCHEMA cars OWNER TO postgres;

--
-- Name: document; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA document;


ALTER SCHEMA document OWNER TO postgres;

--
-- Name: emploee; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA emploee;


ALTER SCHEMA emploee OWNER TO postgres;

--
-- Name: orders; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA orders;


ALTER SCHEMA orders OWNER TO postgres;

--
-- Name: payment; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA payment;


ALTER SCHEMA payment OWNER TO postgres;

--
-- Name: route; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA route;


ALTER SCHEMA route OWNER TO postgres;

--
-- Name: shipper; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA shipper;


ALTER SCHEMA shipper OWNER TO postgres;

--
-- Name: vat; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA vat;


ALTER SCHEMA vat OWNER TO postgres;

--
-- Name: wagons; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA wagons;


ALTER SCHEMA wagons OWNER TO postgres;

--
-- Name: addcity(character varying, integer); Type: PROCEDURE; Schema: adres; Owner: postgres
--

CREATE PROCEDURE adres.addcity(namecity character varying, idcountry integer)
    LANGUAGE sql
    AS $$
    INSERT INTO adres.сities ( city_name, country_id ) VALUES ( nameCity, idCountry );
$$;


ALTER PROCEDURE adres.addcity(namecity character varying, idcountry integer) OWNER TO postgres;

--
-- Name: getcityid(character varying); Type: FUNCTION; Schema: adres; Owner: postgres
--

CREATE FUNCTION adres.getcityid(ct character varying) RETURNS integer
    LANGUAGE sql
    AS $$ 
    SELECT city_id FROM adres.сities WHERE city_name = ct;
$$;


ALTER FUNCTION adres.getcityid(ct character varying) OWNER TO postgres;

--
-- Name: getcountryid(character varying); Type: FUNCTION; Schema: adres; Owner: postgres
--

CREATE FUNCTION adres.getcountryid(cntr character varying) RETURNS integer
    LANGUAGE sql
    AS $$
    SELECT country_id FROM adres.countrys WHERE country_name = cntr;
$$;


ALTER FUNCTION adres.getcountryid(cntr character varying) OWNER TO postgres;

--
-- Name: getstreetid(character varying); Type: FUNCTION; Schema: adres; Owner: postgres
--

CREATE FUNCTION adres.getstreetid(st character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$ 
DECLARE id INTEGER DEFAULT NULL;
    BEGIN
        id = ( SELECT street_id FROM adres.streets WHERE street_name = st );
        IF ( id IS NULL ) THEN
            BEGIN
                INSERT INTO adres.streets ( street_name ) VALUES ( st );
                id = ( SELECT lastval() );
            END;
        END IF;
    RETURN id;
    END;
$$;


ALTER FUNCTION adres.getstreetid(st character varying) OWNER TO postgres;

--
-- Name: insertadress(character varying, character varying, character varying, character varying); Type: PROCEDURE; Schema: adres; Owner: postgres
--

CREATE PROCEDURE adres.insertadress(ct character varying, strt character varying, idx character varying, type_adress character varying)
    LANGUAGE sql
    AS $$
    INSERT INTO adres.adress ( city_id, street_id, adres_index, adres_type )
    VALUES (
        ( SELECT adres.getCityId( ct ) ),
        ( SELECT adres.getStreetId( strt ) ),
        idx,
        type_adress
    );
$$;


ALTER PROCEDURE adres.insertadress(ct character varying, strt character varying, idx character varying, type_adress character varying) OWNER TO postgres;

--
-- Name: add_carmodel(character varying, character varying, character varying); Type: PROCEDURE; Schema: cars; Owner: postgres
--

CREATE PROCEDURE cars.add_carmodel(namebrand character varying, symbolcategory character varying, carmodel character varying)
    LANGUAGE sql
    AS $$
	INSERT INTO cars.carsmodels ( autobrand_id, autocategory_id, carsmodel_name )
	    VALUES ( ( SELECT cars.getAutobrand_id(nameBrand) ), ( SELECT cars.getAutocategory_id(symbolCategory) ), carModel );
$$;


ALTER PROCEDURE cars.add_carmodel(namebrand character varying, symbolcategory character varying, carmodel character varying) OWNER TO postgres;

--
-- Name: getautobrand_id(character varying); Type: FUNCTION; Schema: cars; Owner: postgres
--

CREATE FUNCTION cars.getautobrand_id(namebrand character varying) RETURNS integer
    LANGUAGE sql
    AS $$
	SELECT autobrand_id FROM cars.autobrands WHERE autobrand_name = nameBrand;
$$;


ALTER FUNCTION cars.getautobrand_id(namebrand character varying) OWNER TO postgres;

--
-- Name: getautocategory_id(character varying); Type: FUNCTION; Schema: cars; Owner: postgres
--

CREATE FUNCTION cars.getautocategory_id(symbolcategory character varying) RETURNS integer
    LANGUAGE sql
    AS $$
	SELECT autocategory_id FROM cars.autocategories WHERE autocategory_symbol = symbolCategory;
$$;


ALTER FUNCTION cars.getautocategory_id(symbolcategory character varying) OWNER TO postgres;

--
-- Name: getdocumentid(character varying, integer, integer); Type: FUNCTION; Schema: document; Owner: postgres
--

CREATE FUNCTION document.getdocumentid(postperiod character varying, copycmr integer, originaldocuments integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
    DECLARE id INTEGER DEFAULT NULL;
    BEGIN
        id = ( SELECT document_id FROM document.documents WHERE document_postperiod = postPeriod
                                                            AND document_2copycmr = copyCmr
                                                            AND document_original = originalDocuments);
        IF ( id IS NULL ) THEN
            BEGIN
                CALL document.insertDocuments( postPeriod, copyCmr, originalDocuments );
                id = ( SELECT lastval() );
            END;
        END IF;
        RETURN id;
    END;
$$;


ALTER FUNCTION document.getdocumentid(postperiod character varying, copycmr integer, originaldocuments integer) OWNER TO postgres;

--
-- Name: insertdocuments(character varying, integer, integer); Type: PROCEDURE; Schema: document; Owner: postgres
--

CREATE PROCEDURE document.insertdocuments(postperiod character varying, copycmr integer, originaldocuments integer)
    LANGUAGE sql
    AS $$
    INSERT INTO document.documents (document_postperiod, document_2copycmr, document_original)
        VALUES ( postPeriod, copyCmr, originalDocuments );
$$;


ALTER PROCEDURE document.insertdocuments(postperiod character varying, copycmr integer, originaldocuments integer) OWNER TO postgres;

--
-- Name: addemploee(integer, integer, character varying); Type: PROCEDURE; Schema: emploee; Owner: postgres
--

CREATE PROCEDURE emploee.addemploee(functionworkerid integer, autocategoryid integer, emploeename character varying)
    LANGUAGE sql
    AS $$
    INSERT INTO emploee.emploees ( functionWorker_id, autocategory_id, emploee_name )
	VALUES ( functionWorkerId, autocategoryId, emploeeName );
$$;


ALTER PROCEDURE emploee.addemploee(functionworkerid integer, autocategoryid integer, emploeename character varying) OWNER TO postgres;

--
-- Name: addemploee(character varying, character varying, character varying); Type: PROCEDURE; Schema: emploee; Owner: postgres
--

CREATE PROCEDURE emploee.addemploee(functionworkername character varying, autocategoryname character varying, emploeename character varying)
    LANGUAGE sql
    AS $$
    INSERT INTO emploee.emploees ( functionWorker_id, autocategory_id, emploee_name )
	VALUES ( ( SELECT emploee.getFunctionWorkerId( functionWorkerName ) ), ( SELECT cars.getAutocategory_id( autocategoryName ) ), emploeeName );
$$;


ALTER PROCEDURE emploee.addemploee(functionworkername character varying, autocategoryname character varying, emploeename character varying) OWNER TO postgres;

--
-- Name: getfunctionworkerid(character varying); Type: FUNCTION; Schema: emploee; Owner: postgres
--

CREATE FUNCTION emploee.getfunctionworkerid(functionworkername character varying) RETURNS integer
    LANGUAGE sql
    AS $$
    SELECT functionWorker_id FROM emploee.functionWorker WHERE functionWorker_name = functionWorkerName;
$$;


ALTER FUNCTION emploee.getfunctionworkerid(functionworkername character varying) OWNER TO postgres;

--
-- Name: addorder(integer, integer, integer, integer, integer, date, character varying, text); Type: PROCEDURE; Schema: orders; Owner: postgres
--

CREATE PROCEDURE orders.addorder(idshipper integer, idemploee integer, idpayment integer, idroute integer, iddocuments integer, dataorder date, contractnumber character varying, noteorder text)
    LANGUAGE sql
    AS $$
    INSERT INTO orders.orders( shipper_id, emploee_id, payment_id, route_id, document_id, order_data, order_contractNumber, order_note )
        VALUES ( idShipper, idEmploee, idPayment, idRoute, idDocuments, dataOrder, contractNumber, noteOrder );
$$;


ALTER PROCEDURE orders.addorder(idshipper integer, idemploee integer, idpayment integer, idroute integer, iddocuments integer, dataorder date, contractnumber character varying, noteorder text) OWNER TO postgres;

--
-- Name: addtoorder(character varying, character varying, integer, integer, numeric, character varying, character varying, integer, integer, character varying, integer, integer, character varying); Type: PROCEDURE; Schema: orders; Owner: postgres
--

CREATE PROCEDURE orders.addtoorder(orderdate character varying, ordernumber character varying, shipperid integer, emploeeid integer, paymentcost numeric, paymentperiod character varying, paymentcurrency character varying, routesarrival integer, routesroute integer, documentpostperiod character varying, document2copycmr integer, documentoriginal integer, odernote character varying)
    LANGUAGE sql
    AS $$
    INSERT INTO orders.orders ( shipper_id, emploee_id, payment_id, route_id, document_id, order_data, order_contractNumber, order_note )
    VALUES ( shipperId, emploeeId,
				    ( SELECT payment.getPayment_id( paymentCost, paymentPeriod, paymentCurrency ) ),
				    ( SELECT route.getRouteId( routesArrival, routesRoute ) ),
				    ( SELECT document.getDocumentId( documentPostPeriod, document2CopyCmr, documentOriginal ) ),
	    orderDate::date, orderNumber, oderNote );
$$;


ALTER PROCEDURE orders.addtoorder(orderdate character varying, ordernumber character varying, shipperid integer, emploeeid integer, paymentcost numeric, paymentperiod character varying, paymentcurrency character varying, routesarrival integer, routesroute integer, documentpostperiod character varying, document2copycmr integer, documentoriginal integer, odernote character varying) OWNER TO postgres;

--
-- Name: updateorder(integer, character varying, character varying, integer, integer, numeric, character varying, character varying, integer, integer, character varying, integer, integer, character varying); Type: PROCEDURE; Schema: orders; Owner: postgres
--

CREATE PROCEDURE orders.updateorder(orderid integer, orderdate character varying, ordernumber character varying, shipperid integer, emploeeid integer, paymentcost numeric, paymentperiod character varying, paymentcurrency character varying, routesarrival integer, routesroute integer, documentpostperiod character varying, document2copycmr integer, documentoriginal integer, odernote character varying)
    LANGUAGE sql
    AS $$
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


ALTER PROCEDURE orders.updateorder(orderid integer, orderdate character varying, ordernumber character varying, shipperid integer, emploeeid integer, paymentcost numeric, paymentperiod character varying, paymentcurrency character varying, routesarrival integer, routesroute integer, documentpostperiod character varying, document2copycmr integer, documentoriginal integer, odernote character varying) OWNER TO postgres;

--
-- Name: getpayment_id(numeric, character varying, character varying); Type: FUNCTION; Schema: payment; Owner: postgres
--

CREATE FUNCTION payment.getpayment_id(cost numeric, period character varying, currency character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$
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


ALTER FUNCTION payment.getpayment_id(cost numeric, period character varying, currency character varying) OWNER TO postgres;

--
-- Name: insertpayment(numeric, character varying, character varying); Type: PROCEDURE; Schema: payment; Owner: postgres
--

CREATE PROCEDURE payment.insertpayment(cost numeric, period character varying, currency character varying)
    LANGUAGE sql
    AS $$
	INSERT INTO payment.payments ( payment_cost, payment_period, payment_currency )
	VALUES ( cost, period, currency );
$$;


ALTER PROCEDURE payment.insertpayment(cost numeric, period character varying, currency character varying) OWNER TO postgres;

--
-- Name: getrouteid(integer, integer); Type: FUNCTION; Schema: route; Owner: postgres
--

CREATE FUNCTION route.getrouteid(arrival integer, route integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE id INTEGER DEFAULT NULL;
    BEGIN
	id = ( SELECT route_id FROM route.routes WHERE route_arrival = arrival
						 AND route_route = route );
	IF ( id IS NULL ) THEN
	    BEGIN
		CALL route.insertRoute( arrival, route );
		id = ( SELECT lastval() );
	    END;
	END IF;
    RETURN id;
    END;
$$;


ALTER FUNCTION route.getrouteid(arrival integer, route integer) OWNER TO postgres;

--
-- Name: getrouteid(integer, integer, numeric); Type: FUNCTION; Schema: route; Owner: postgres
--

CREATE FUNCTION route.getrouteid(arrival integer, route integer, ante numeric) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE id INTEGER DEFAULT NULL;
    BEGIN
	id = ( SELECT route_id FROM route.routes WHERE route_arrival = arrival
						 AND route_route = route );
	IF ( id IS NULL ) THEN
	    BEGIN
		CALL route.insertRoute( arrival, route, ante );
		id = ( SELECT lastval() );
	    END;
	END IF;
    RETURN id;
    END;
$$;


ALTER FUNCTION route.getrouteid(arrival integer, route integer, ante numeric) OWNER TO postgres;

--
-- Name: insertroute(integer, integer); Type: PROCEDURE; Schema: route; Owner: postgres
--

CREATE PROCEDURE route.insertroute(arrival integer, rout integer)
    LANGUAGE sql
    AS $$
    INSERT INTO route.routes( route_arrival, route_route ) VALUES ( arrival, rout );
$$;


ALTER PROCEDURE route.insertroute(arrival integer, rout integer) OWNER TO postgres;

--
-- Name: addshipper(character varying); Type: PROCEDURE; Schema: shipper; Owner: postgres
--

CREATE PROCEDURE shipper.addshipper(nameshipper character varying)
    LANGUAGE sql
    AS $$
    INSERT INTO shipper.shippers ( shipper_name ) VALUES ( nameShipper );
$$;


ALTER PROCEDURE shipper.addshipper(nameshipper character varying) OWNER TO postgres;

--
-- Name: getvatid(numeric); Type: FUNCTION; Schema: vat; Owner: postgres
--

CREATE FUNCTION vat.getvatid(vat_st numeric) RETURNS integer
    LANGUAGE sql
    AS $$
    SELECT vat_id FROM vat.vats WHERE vat_stavka = vat_st;
$$;


ALTER FUNCTION vat.getvatid(vat_st numeric) OWNER TO postgres;

--
-- Name: getvatnames(character varying); Type: FUNCTION; Schema: vat; Owner: postgres
--

CREATE FUNCTION vat.getvatnames(nm character varying) RETURNS integer
    LANGUAGE sql
    AS $$
    SELECT vatname_id FROM vat.vatnames WHERE vatname_name = nm;
$$;


ALTER FUNCTION vat.getvatnames(nm character varying) OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: adress; Type: TABLE; Schema: adres; Owner: postgres
--

CREATE TABLE adres.adress (
    adres_id integer NOT NULL,
    city_id integer NOT NULL,
    street_id integer NOT NULL,
    adres_index character varying(20),
    adres_type character varying(20) NOT NULL,
    CONSTRAINT adress_adres_type_check CHECK (((adres_type)::text = ANY (ARRAY[('Фактический'::character varying)::text, ('Юридический'::character varying)::text])))
);


ALTER TABLE adres.adress OWNER TO postgres;

--
-- Name: adress_adres_id_seq; Type: SEQUENCE; Schema: adres; Owner: postgres
--

CREATE SEQUENCE adres.adress_adres_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE adres.adress_adres_id_seq OWNER TO postgres;

--
-- Name: adress_adres_id_seq; Type: SEQUENCE OWNED BY; Schema: adres; Owner: postgres
--

ALTER SEQUENCE adres.adress_adres_id_seq OWNED BY adres.adress.adres_id;


--
-- Name: countrys; Type: TABLE; Schema: adres; Owner: postgres
--

CREATE TABLE adres.countrys (
    country_id integer NOT NULL,
    vat_id integer NOT NULL,
    vatname_id integer NOT NULL,
    country_name character varying(256) NOT NULL,
    country_abbreviated_2 character varying(4) NOT NULL,
    country_abbreviated_3 character varying(4) NOT NULL,
    country_icon character varying(256)
);


ALTER TABLE adres.countrys OWNER TO postgres;

--
-- Name: streets; Type: TABLE; Schema: adres; Owner: postgres
--

CREATE TABLE adres.streets (
    street_id integer NOT NULL,
    street_name character varying(256) NOT NULL
);


ALTER TABLE adres.streets OWNER TO postgres;

--
-- Name: сities; Type: TABLE; Schema: adres; Owner: postgres
--

CREATE TABLE adres."сities" (
    city_id integer NOT NULL,
    city_name character varying(256) NOT NULL,
    country_id integer
);


ALTER TABLE adres."сities" OWNER TO postgres;

--
-- Name: adressview; Type: VIEW; Schema: adres; Owner: postgres
--

CREATE VIEW adres.adressview AS
 SELECT ad.adres_id,
    tmp.country_icon,
    tmp.country_name,
    ad.adres_index,
    ct.city_name,
    st.street_name,
    ad.adres_type
   FROM (((adres.adress ad
     LEFT JOIN adres."сities" ct ON ((ad.city_id = ct.city_id)))
     LEFT JOIN adres.streets st ON ((ad.street_id = st.street_id)))
     LEFT JOIN ( SELECT cn.country_id,
            cn.country_icon,
            cn.country_name
           FROM (adres.countrys cn
             JOIN adres."сities" ct_1 ON ((cn.country_id = ct_1.country_id)))) tmp ON ((tmp.country_id = ct.country_id)));


ALTER TABLE adres.adressview OWNER TO postgres;

--
-- Name: countrys_country_id_seq; Type: SEQUENCE; Schema: adres; Owner: postgres
--

CREATE SEQUENCE adres.countrys_country_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE adres.countrys_country_id_seq OWNER TO postgres;

--
-- Name: countrys_country_id_seq; Type: SEQUENCE OWNED BY; Schema: adres; Owner: postgres
--

ALTER SEQUENCE adres.countrys_country_id_seq OWNED BY adres.countrys.country_id;


--
-- Name: streets_street_id_seq; Type: SEQUENCE; Schema: adres; Owner: postgres
--

CREATE SEQUENCE adres.streets_street_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE adres.streets_street_id_seq OWNER TO postgres;

--
-- Name: streets_street_id_seq; Type: SEQUENCE OWNED BY; Schema: adres; Owner: postgres
--

ALTER SEQUENCE adres.streets_street_id_seq OWNED BY adres.streets.street_id;


--
-- Name: testadressview; Type: MATERIALIZED VIEW; Schema: adres; Owner: postgres
--

CREATE MATERIALIZED VIEW adres.testadressview AS
 SELECT ad.adres_id,
    tmp.country_icon,
    tmp.country_name,
    ad.adres_index,
    ct.city_name,
    st.street_name,
    ad.adres_type
   FROM (((adres.adress ad
     LEFT JOIN adres."сities" ct ON ((ad.city_id = ct.city_id)))
     LEFT JOIN adres.streets st ON ((ad.street_id = st.street_id)))
     LEFT JOIN ( SELECT cn.country_id,
            cn.country_icon,
            cn.country_name
           FROM (adres.countrys cn
             JOIN adres."сities" ct_1 ON ((cn.country_id = ct_1.country_id)))) tmp ON ((tmp.country_id = ct.country_id)))
  WITH NO DATA;


ALTER TABLE adres.testadressview OWNER TO postgres;

--
-- Name: сities_city_id_seq; Type: SEQUENCE; Schema: adres; Owner: postgres
--

CREATE SEQUENCE adres."сities_city_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE adres."сities_city_id_seq" OWNER TO postgres;

--
-- Name: сities_city_id_seq; Type: SEQUENCE OWNED BY; Schema: adres; Owner: postgres
--

ALTER SEQUENCE adres."сities_city_id_seq" OWNED BY adres."сities".city_id;


--
-- Name: autobrands; Type: TABLE; Schema: cars; Owner: postgres
--

CREATE TABLE cars.autobrands (
    autobrand_id integer NOT NULL,
    autobrand_name character varying(256) NOT NULL,
    autobrand_icon character varying(256) DEFAULT 'no_icon.png'::character varying
);


ALTER TABLE cars.autobrands OWNER TO postgres;

--
-- Name: autobrands_autobrand_id_seq; Type: SEQUENCE; Schema: cars; Owner: postgres
--

CREATE SEQUENCE cars.autobrands_autobrand_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE cars.autobrands_autobrand_id_seq OWNER TO postgres;

--
-- Name: autobrands_autobrand_id_seq; Type: SEQUENCE OWNED BY; Schema: cars; Owner: postgres
--

ALTER SEQUENCE cars.autobrands_autobrand_id_seq OWNED BY cars.autobrands.autobrand_id;


--
-- Name: autocategories; Type: TABLE; Schema: cars; Owner: postgres
--

CREATE TABLE cars.autocategories (
    autocategory_id integer NOT NULL,
    autocategory_name character varying(256) NOT NULL,
    autocategory_symbol character varying(5) NOT NULL,
    autocategory_icon character varying(64),
    autocategory_description text
);


ALTER TABLE cars.autocategories OWNER TO postgres;

--
-- Name: autocategories_autocategory_id_seq; Type: SEQUENCE; Schema: cars; Owner: postgres
--

CREATE SEQUENCE cars.autocategories_autocategory_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE cars.autocategories_autocategory_id_seq OWNER TO postgres;

--
-- Name: autocategories_autocategory_id_seq; Type: SEQUENCE OWNED BY; Schema: cars; Owner: postgres
--

ALTER SEQUENCE cars.autocategories_autocategory_id_seq OWNED BY cars.autocategories.autocategory_id;


--
-- Name: cars; Type: TABLE; Schema: cars; Owner: postgres
--

CREATE TABLE cars.cars (
    car_id integer NOT NULL,
    car_vin character varying(64) NOT NULL,
    car_date_release date,
    car_date_gto date,
    carsmodel_id integer
);


ALTER TABLE cars.cars OWNER TO postgres;

--
-- Name: carsmodels; Type: TABLE; Schema: cars; Owner: postgres
--

CREATE TABLE cars.carsmodels (
    carsmodel_id integer NOT NULL,
    autobrand_id integer NOT NULL,
    autocategory_id integer NOT NULL,
    carsmodel_name character varying(200),
    semitrailer_id integer
);


ALTER TABLE cars.carsmodels OWNER TO postgres;

--
-- Name: description_semitrailers; Type: TABLE; Schema: cars; Owner: postgres
--

CREATE TABLE cars.description_semitrailers (
    description_semitrailer_id integer NOT NULL,
    description_semitrailer_description text
);


ALTER TABLE cars.description_semitrailers OWNER TO postgres;

--
-- Name: semitrailers; Type: TABLE; Schema: cars; Owner: postgres
--

CREATE TABLE cars.semitrailers (
    semitrailer_id integer NOT NULL,
    semitrailer_name character varying(64),
    semitrailer_carrying numeric(4,2),
    semitrailer_gabarit_lenth numeric(4,2),
    semitrailer_gabarit_width numeric(4,2),
    semitrailer_gabarit_height numeric(4,2),
    description_semitrailer_id integer,
    semitrailer_img character varying(64)
);


ALTER TABLE cars.semitrailers OWNER TO postgres;

--
-- Name: automobiles; Type: VIEW; Schema: cars; Owner: postgres
--

CREATE VIEW cars.automobiles AS
 SELECT cr.car_id,
    cr.car_vin,
    cr.car_date_release,
    cr.car_date_gto,
    cm.carsmodel_id,
    cm.autobrand_id,
    cm.autocategory_id,
    cm.carsmodel_name,
    cm.semitrailer_id,
    ab.autobrand_name,
    ab.autobrand_icon,
    ac.autocategory_name,
    ac.autocategory_symbol,
    ac.autocategory_icon,
    ac.autocategory_description,
    smt.semitrailer_name,
    smt.semitrailer_carrying,
    smt.semitrailer_gabarit_lenth,
    smt.semitrailer_gabarit_width,
    smt.semitrailer_gabarit_height,
    smt.description_semitrailer_id
   FROM (((((cars.cars cr
     JOIN cars.carsmodels cm ON ((cr.carsmodel_id = cm.carsmodel_id)))
     JOIN cars.autobrands ab ON ((ab.autobrand_id = cm.autobrand_id)))
     JOIN cars.autocategories ac ON ((ac.autocategory_id = cm.autocategory_id)))
     JOIN cars.semitrailers smt ON ((smt.semitrailer_id = cm.semitrailer_id)))
     JOIN cars.description_semitrailers dscr ON ((smt.description_semitrailer_id = dscr.description_semitrailer_id)));


ALTER TABLE cars.automobiles OWNER TO postgres;

--
-- Name: cars_car_id_seq; Type: SEQUENCE; Schema: cars; Owner: postgres
--

CREATE SEQUENCE cars.cars_car_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE cars.cars_car_id_seq OWNER TO postgres;

--
-- Name: cars_car_id_seq; Type: SEQUENCE OWNED BY; Schema: cars; Owner: postgres
--

ALTER SEQUENCE cars.cars_car_id_seq OWNED BY cars.cars.car_id;


--
-- Name: carsmodels_carsmodel_id_seq; Type: SEQUENCE; Schema: cars; Owner: postgres
--

CREATE SEQUENCE cars.carsmodels_carsmodel_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE cars.carsmodels_carsmodel_id_seq OWNER TO postgres;

--
-- Name: carsmodels_carsmodel_id_seq; Type: SEQUENCE OWNED BY; Schema: cars; Owner: postgres
--

ALTER SEQUENCE cars.carsmodels_carsmodel_id_seq OWNED BY cars.carsmodels.carsmodel_id;


--
-- Name: description_semitrailers_description_semitrailer_id_seq; Type: SEQUENCE; Schema: cars; Owner: postgres
--

CREATE SEQUENCE cars.description_semitrailers_description_semitrailer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE cars.description_semitrailers_description_semitrailer_id_seq OWNER TO postgres;

--
-- Name: description_semitrailers_description_semitrailer_id_seq; Type: SEQUENCE OWNED BY; Schema: cars; Owner: postgres
--

ALTER SEQUENCE cars.description_semitrailers_description_semitrailer_id_seq OWNED BY cars.description_semitrailers.description_semitrailer_id;


--
-- Name: paletypes; Type: TABLE; Schema: cars; Owner: postgres
--

CREATE TABLE cars.paletypes (
    paletype_id integer NOT NULL,
    paletype_name character varying(96),
    paletype_lenth numeric(4,2),
    paletype_width numeric(4,2)
);


ALTER TABLE cars.paletypes OWNER TO postgres;

--
-- Name: paletypes_paletype_id_seq; Type: SEQUENCE; Schema: cars; Owner: postgres
--

CREATE SEQUENCE cars.paletypes_paletype_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE cars.paletypes_paletype_id_seq OWNER TO postgres;

--
-- Name: paletypes_paletype_id_seq; Type: SEQUENCE OWNED BY; Schema: cars; Owner: postgres
--

ALTER SEQUENCE cars.paletypes_paletype_id_seq OWNED BY cars.paletypes.paletype_id;


--
-- Name: semitrailers_semitrailer_id_seq; Type: SEQUENCE; Schema: cars; Owner: postgres
--

CREATE SEQUENCE cars.semitrailers_semitrailer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE cars.semitrailers_semitrailer_id_seq OWNER TO postgres;

--
-- Name: semitrailers_semitrailer_id_seq; Type: SEQUENCE OWNED BY; Schema: cars; Owner: postgres
--

ALTER SEQUENCE cars.semitrailers_semitrailer_id_seq OWNED BY cars.semitrailers.semitrailer_id;


--
-- Name: semitrailers_view; Type: VIEW; Schema: cars; Owner: postgres
--

CREATE VIEW cars.semitrailers_view AS
 SELECT st.semitrailer_id AS id,
    st.semitrailer_name AS name,
    st.semitrailer_carrying AS carrying,
    st.semitrailer_gabarit_lenth AS lenth,
    st.semitrailer_gabarit_width AS width,
    st.semitrailer_gabarit_height AS height,
    st.semitrailer_img AS img,
    ds.description_semitrailer_description AS description
   FROM (cars.semitrailers st
     JOIN cars.description_semitrailers ds ON ((st.description_semitrailer_id = ds.description_semitrailer_id)));


ALTER TABLE cars.semitrailers_view OWNER TO postgres;

--
-- Name: documents; Type: TABLE; Schema: document; Owner: postgres
--

CREATE TABLE document.documents (
    document_id integer NOT NULL,
    document_postperiod character varying(64),
    document_2copycmr integer,
    document_original integer
);


ALTER TABLE document.documents OWNER TO postgres;

--
-- Name: documents_document_id_seq; Type: SEQUENCE; Schema: document; Owner: postgres
--

CREATE SEQUENCE document.documents_document_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE document.documents_document_id_seq OWNER TO postgres;

--
-- Name: documents_document_id_seq; Type: SEQUENCE OWNED BY; Schema: document; Owner: postgres
--

ALTER SEQUENCE document.documents_document_id_seq OWNED BY document.documents.document_id;


--
-- Name: emploees; Type: TABLE; Schema: emploee; Owner: postgres
--

CREATE TABLE emploee.emploees (
    emploee_id integer NOT NULL,
    functionworker_id integer NOT NULL,
    autocategory_id integer,
    emploee_name character varying(200)
);


ALTER TABLE emploee.emploees OWNER TO postgres;

--
-- Name: emploees_emploee_id_seq; Type: SEQUENCE; Schema: emploee; Owner: postgres
--

CREATE SEQUENCE emploee.emploees_emploee_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE emploee.emploees_emploee_id_seq OWNER TO postgres;

--
-- Name: emploees_emploee_id_seq; Type: SEQUENCE OWNED BY; Schema: emploee; Owner: postgres
--

ALTER SEQUENCE emploee.emploees_emploee_id_seq OWNED BY emploee.emploees.emploee_id;


--
-- Name: functionworker; Type: TABLE; Schema: emploee; Owner: postgres
--

CREATE TABLE emploee.functionworker (
    functionworker_id integer NOT NULL,
    functionworker_name character varying(128)
);


ALTER TABLE emploee.functionworker OWNER TO postgres;

--
-- Name: emploeeview; Type: VIEW; Schema: emploee; Owner: postgres
--

CREATE VIEW emploee.emploeeview AS
 SELECT e.emploee_id,
    e.emploee_name,
    fw.functionworker_name,
    cr.autocategory_symbol,
    cr.autocategory_icon
   FROM ((emploee.emploees e
     JOIN emploee.functionworker fw ON ((e.functionworker_id = fw.functionworker_id)))
     JOIN cars.autocategories cr ON ((e.autocategory_id = cr.autocategory_id)));


ALTER TABLE emploee.emploeeview OWNER TO postgres;

--
-- Name: functionworker_functionworker_id_seq; Type: SEQUENCE; Schema: emploee; Owner: postgres
--

CREATE SEQUENCE emploee.functionworker_functionworker_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE emploee.functionworker_functionworker_id_seq OWNER TO postgres;

--
-- Name: functionworker_functionworker_id_seq; Type: SEQUENCE OWNED BY; Schema: emploee; Owner: postgres
--

ALTER SEQUENCE emploee.functionworker_functionworker_id_seq OWNED BY emploee.functionworker.functionworker_id;


--
-- Name: voditeli; Type: VIEW; Schema: emploee; Owner: postgres
--

CREATE VIEW emploee.voditeli AS
 SELECT emploees.emploee_id,
    emploees.emploee_name
   FROM emploee.emploees
  WHERE (emploees.functionworker_id = ( SELECT emploee.getfunctionworkerid('Водитель'::character varying) AS getfunctionworkerid));


ALTER TABLE emploee.voditeli OWNER TO postgres;

--
-- Name: orders; Type: TABLE; Schema: orders; Owner: postgres
--

CREATE TABLE orders.orders (
    order_id integer NOT NULL,
    shipper_id integer,
    emploee_id integer,
    payment_id integer,
    route_id integer,
    document_id integer,
    order_data date,
    order_contractnumber character varying(200) NOT NULL,
    order_note text
);


ALTER TABLE orders.orders OWNER TO postgres;

--
-- Name: orders_order_id_seq; Type: SEQUENCE; Schema: orders; Owner: postgres
--

CREATE SEQUENCE orders.orders_order_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE orders.orders_order_id_seq OWNER TO postgres;

--
-- Name: orders_order_id_seq; Type: SEQUENCE OWNED BY; Schema: orders; Owner: postgres
--

ALTER SEQUENCE orders.orders_order_id_seq OWNED BY orders.orders.order_id;


--
-- Name: payments; Type: TABLE; Schema: payment; Owner: postgres
--

CREATE TABLE payment.payments (
    payment_id integer NOT NULL,
    payment_cost numeric(32,2),
    payment_period character varying(64),
    payment_currency character varying(64)
);


ALTER TABLE payment.payments OWNER TO postgres;

--
-- Name: routes; Type: TABLE; Schema: route; Owner: postgres
--

CREATE TABLE route.routes (
    route_id integer NOT NULL,
    route_arrival integer,
    route_route integer
);


ALTER TABLE route.routes OWNER TO postgres;

--
-- Name: shippers; Type: TABLE; Schema: shipper; Owner: postgres
--

CREATE TABLE shipper.shippers (
    shipper_id integer NOT NULL,
    shipper_name character varying(200) NOT NULL
);


ALTER TABLE shipper.shippers OWNER TO postgres;

--
-- Name: ordersview; Type: VIEW; Schema: orders; Owner: postgres
--

CREATE VIEW orders.ordersview AS
 SELECT ord.order_data,
    ord.order_contractnumber,
    shp.shipper_name,
    emp.emploee_name,
    pay.payment_cost,
    pay.payment_currency,
    pay.payment_period,
    rou.route_arrival,
    rou.route_route,
        CASE
            WHEN ((rou.route_arrival + rou.route_route) = 0) THEN (0)::numeric
            ELSE trunc((pay.payment_cost / ((rou.route_arrival + rou.route_route))::numeric), 2)
        END AS stavka,
    doc.document_2copycmr,
    doc.document_original,
    doc.document_postperiod,
    ord.order_note,
    ord.order_id,
    ord.shipper_id,
    ord.emploee_id,
    ord.payment_id,
    ord.route_id,
    ord.document_id
   FROM (((((orders.orders ord
     JOIN shipper.shippers shp ON ((ord.shipper_id = shp.shipper_id)))
     JOIN emploee.emploees emp ON ((ord.emploee_id = emp.emploee_id)))
     JOIN payment.payments pay ON ((ord.payment_id = pay.payment_id)))
     JOIN route.routes rou ON ((ord.route_id = rou.route_id)))
     JOIN document.documents doc ON ((ord.document_id = doc.document_id)));


ALTER TABLE orders.ordersview OWNER TO postgres;

--
-- Name: payments_payment_id_seq; Type: SEQUENCE; Schema: payment; Owner: postgres
--

CREATE SEQUENCE payment.payments_payment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE payment.payments_payment_id_seq OWNER TO postgres;

--
-- Name: payments_payment_id_seq; Type: SEQUENCE OWNED BY; Schema: payment; Owner: postgres
--

ALTER SEQUENCE payment.payments_payment_id_seq OWNED BY payment.payments.payment_id;


--
-- Name: autos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.autos (
    auto_id integer NOT NULL,
    auto_brand character varying(64),
    auto_lenthtrailer numeric(4,2),
    auto_widthtrailer numeric(4,2),
    auto_heighttrailer numeric(4,2),
    auto_vin character varying(17),
    auto_datawork date,
    auto_datagto date
);


ALTER TABLE public.autos OWNER TO postgres;

--
-- Name: autos_auto_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.autos_auto_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.autos_auto_id_seq OWNER TO postgres;

--
-- Name: autos_auto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.autos_auto_id_seq OWNED BY public.autos.auto_id;


--
-- Name: testadressview; Type: MATERIALIZED VIEW; Schema: public; Owner: postgres
--

CREATE MATERIALIZED VIEW public.testadressview AS
 SELECT ad.adres_id,
    tmp.country_icon,
    tmp.country_name,
    ad.adres_index,
    ct.city_name,
    st.street_name,
    ad.adres_type
   FROM (((adres.adress ad
     LEFT JOIN adres."сities" ct ON ((ad.city_id = ct.city_id)))
     LEFT JOIN adres.streets st ON ((ad.street_id = st.street_id)))
     LEFT JOIN ( SELECT cn.country_id,
            cn.country_icon,
            cn.country_name
           FROM (adres.countrys cn
             JOIN adres."сities" ct_1 ON ((cn.country_id = ct_1.country_id)))) tmp ON ((tmp.country_id = ct.country_id)))
  WITH NO DATA;


ALTER TABLE public.testadressview OWNER TO postgres;

--
-- Name: routes_route_id_seq; Type: SEQUENCE; Schema: route; Owner: postgres
--

CREATE SEQUENCE route.routes_route_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE route.routes_route_id_seq OWNER TO postgres;

--
-- Name: routes_route_id_seq; Type: SEQUENCE OWNED BY; Schema: route; Owner: postgres
--

ALTER SEQUENCE route.routes_route_id_seq OWNED BY route.routes.route_id;


--
-- Name: shippers_shipper_id_seq; Type: SEQUENCE; Schema: shipper; Owner: postgres
--

CREATE SEQUENCE shipper.shippers_shipper_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE shipper.shippers_shipper_id_seq OWNER TO postgres;

--
-- Name: shippers_shipper_id_seq; Type: SEQUENCE OWNED BY; Schema: shipper; Owner: postgres
--

ALTER SEQUENCE shipper.shippers_shipper_id_seq OWNED BY shipper.shippers.shipper_id;


--
-- Name: vatnames; Type: TABLE; Schema: vat; Owner: postgres
--

CREATE TABLE vat.vatnames (
    vatname_id integer NOT NULL,
    vatname_name character varying(10)
);


ALTER TABLE vat.vatnames OWNER TO postgres;

--
-- Name: vatnames_vatname_id_seq; Type: SEQUENCE; Schema: vat; Owner: postgres
--

CREATE SEQUENCE vat.vatnames_vatname_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE vat.vatnames_vatname_id_seq OWNER TO postgres;

--
-- Name: vatnames_vatname_id_seq; Type: SEQUENCE OWNED BY; Schema: vat; Owner: postgres
--

ALTER SEQUENCE vat.vatnames_vatname_id_seq OWNED BY vat.vatnames.vatname_id;


--
-- Name: vats; Type: TABLE; Schema: vat; Owner: postgres
--

CREATE TABLE vat.vats (
    vat_id integer NOT NULL,
    vat_stavka numeric(4,2) NOT NULL,
    CONSTRAINT vats_valid CHECK (((vat_stavka > (0)::numeric) AND (vat_stavka < (100)::numeric)))
);


ALTER TABLE vat.vats OWNER TO postgres;

--
-- Name: vats_vat_id_seq; Type: SEQUENCE; Schema: vat; Owner: postgres
--

CREATE SEQUENCE vat.vats_vat_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE vat.vats_vat_id_seq OWNER TO postgres;

--
-- Name: vats_vat_id_seq; Type: SEQUENCE OWNED BY; Schema: vat; Owner: postgres
--

ALTER SEQUENCE vat.vats_vat_id_seq OWNED BY vat.vats.vat_id;


--
-- Name: adress adres_id; Type: DEFAULT; Schema: adres; Owner: postgres
--

ALTER TABLE ONLY adres.adress ALTER COLUMN adres_id SET DEFAULT nextval('adres.adress_adres_id_seq'::regclass);


--
-- Name: countrys country_id; Type: DEFAULT; Schema: adres; Owner: postgres
--

ALTER TABLE ONLY adres.countrys ALTER COLUMN country_id SET DEFAULT nextval('adres.countrys_country_id_seq'::regclass);


--
-- Name: streets street_id; Type: DEFAULT; Schema: adres; Owner: postgres
--

ALTER TABLE ONLY adres.streets ALTER COLUMN street_id SET DEFAULT nextval('adres.streets_street_id_seq'::regclass);


--
-- Name: сities city_id; Type: DEFAULT; Schema: adres; Owner: postgres
--

ALTER TABLE ONLY adres."сities" ALTER COLUMN city_id SET DEFAULT nextval('adres."сities_city_id_seq"'::regclass);


--
-- Name: autobrands autobrand_id; Type: DEFAULT; Schema: cars; Owner: postgres
--

ALTER TABLE ONLY cars.autobrands ALTER COLUMN autobrand_id SET DEFAULT nextval('cars.autobrands_autobrand_id_seq'::regclass);


--
-- Name: autocategories autocategory_id; Type: DEFAULT; Schema: cars; Owner: postgres
--

ALTER TABLE ONLY cars.autocategories ALTER COLUMN autocategory_id SET DEFAULT nextval('cars.autocategories_autocategory_id_seq'::regclass);


--
-- Name: cars car_id; Type: DEFAULT; Schema: cars; Owner: postgres
--

ALTER TABLE ONLY cars.cars ALTER COLUMN car_id SET DEFAULT nextval('cars.cars_car_id_seq'::regclass);


--
-- Name: carsmodels carsmodel_id; Type: DEFAULT; Schema: cars; Owner: postgres
--

ALTER TABLE ONLY cars.carsmodels ALTER COLUMN carsmodel_id SET DEFAULT nextval('cars.carsmodels_carsmodel_id_seq'::regclass);


--
-- Name: description_semitrailers description_semitrailer_id; Type: DEFAULT; Schema: cars; Owner: postgres
--

ALTER TABLE ONLY cars.description_semitrailers ALTER COLUMN description_semitrailer_id SET DEFAULT nextval('cars.description_semitrailers_description_semitrailer_id_seq'::regclass);


--
-- Name: paletypes paletype_id; Type: DEFAULT; Schema: cars; Owner: postgres
--

ALTER TABLE ONLY cars.paletypes ALTER COLUMN paletype_id SET DEFAULT nextval('cars.paletypes_paletype_id_seq'::regclass);


--
-- Name: semitrailers semitrailer_id; Type: DEFAULT; Schema: cars; Owner: postgres
--

ALTER TABLE ONLY cars.semitrailers ALTER COLUMN semitrailer_id SET DEFAULT nextval('cars.semitrailers_semitrailer_id_seq'::regclass);


--
-- Name: documents document_id; Type: DEFAULT; Schema: document; Owner: postgres
--

ALTER TABLE ONLY document.documents ALTER COLUMN document_id SET DEFAULT nextval('document.documents_document_id_seq'::regclass);


--
-- Name: emploees emploee_id; Type: DEFAULT; Schema: emploee; Owner: postgres
--

ALTER TABLE ONLY emploee.emploees ALTER COLUMN emploee_id SET DEFAULT nextval('emploee.emploees_emploee_id_seq'::regclass);


--
-- Name: functionworker functionworker_id; Type: DEFAULT; Schema: emploee; Owner: postgres
--

ALTER TABLE ONLY emploee.functionworker ALTER COLUMN functionworker_id SET DEFAULT nextval('emploee.functionworker_functionworker_id_seq'::regclass);


--
-- Name: orders order_id; Type: DEFAULT; Schema: orders; Owner: postgres
--

ALTER TABLE ONLY orders.orders ALTER COLUMN order_id SET DEFAULT nextval('orders.orders_order_id_seq'::regclass);


--
-- Name: payments payment_id; Type: DEFAULT; Schema: payment; Owner: postgres
--

ALTER TABLE ONLY payment.payments ALTER COLUMN payment_id SET DEFAULT nextval('payment.payments_payment_id_seq'::regclass);


--
-- Name: autos auto_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.autos ALTER COLUMN auto_id SET DEFAULT nextval('public.autos_auto_id_seq'::regclass);


--
-- Name: routes route_id; Type: DEFAULT; Schema: route; Owner: postgres
--

ALTER TABLE ONLY route.routes ALTER COLUMN route_id SET DEFAULT nextval('route.routes_route_id_seq'::regclass);


--
-- Name: shippers shipper_id; Type: DEFAULT; Schema: shipper; Owner: postgres
--

ALTER TABLE ONLY shipper.shippers ALTER COLUMN shipper_id SET DEFAULT nextval('shipper.shippers_shipper_id_seq'::regclass);


--
-- Name: vatnames vatname_id; Type: DEFAULT; Schema: vat; Owner: postgres
--

ALTER TABLE ONLY vat.vatnames ALTER COLUMN vatname_id SET DEFAULT nextval('vat.vatnames_vatname_id_seq'::regclass);


--
-- Name: vats vat_id; Type: DEFAULT; Schema: vat; Owner: postgres
--

ALTER TABLE ONLY vat.vats ALTER COLUMN vat_id SET DEFAULT nextval('vat.vats_vat_id_seq'::regclass);


--
-- Name: adress adress_pkey; Type: CONSTRAINT; Schema: adres; Owner: postgres
--

ALTER TABLE ONLY adres.adress
    ADD CONSTRAINT adress_pkey PRIMARY KEY (adres_id);


--
-- Name: countrys countrys_country_abbreviated_2_key; Type: CONSTRAINT; Schema: adres; Owner: postgres
--

ALTER TABLE ONLY adres.countrys
    ADD CONSTRAINT countrys_country_abbreviated_2_key UNIQUE (country_abbreviated_2);


--
-- Name: countrys countrys_country_abbreviated_3_key; Type: CONSTRAINT; Schema: adres; Owner: postgres
--

ALTER TABLE ONLY adres.countrys
    ADD CONSTRAINT countrys_country_abbreviated_3_key UNIQUE (country_abbreviated_3);


--
-- Name: countrys countrys_country_name_key; Type: CONSTRAINT; Schema: adres; Owner: postgres
--

ALTER TABLE ONLY adres.countrys
    ADD CONSTRAINT countrys_country_name_key UNIQUE (country_name);


--
-- Name: countrys countrys_pkey; Type: CONSTRAINT; Schema: adres; Owner: postgres
--

ALTER TABLE ONLY adres.countrys
    ADD CONSTRAINT countrys_pkey PRIMARY KEY (country_id);


--
-- Name: streets streets_pkey; Type: CONSTRAINT; Schema: adres; Owner: postgres
--

ALTER TABLE ONLY adres.streets
    ADD CONSTRAINT streets_pkey PRIMARY KEY (street_id);


--
-- Name: streets streets_street_name_key; Type: CONSTRAINT; Schema: adres; Owner: postgres
--

ALTER TABLE ONLY adres.streets
    ADD CONSTRAINT streets_street_name_key UNIQUE (street_name);


--
-- Name: сities сities_city_name_key; Type: CONSTRAINT; Schema: adres; Owner: postgres
--

ALTER TABLE ONLY adres."сities"
    ADD CONSTRAINT "сities_city_name_key" UNIQUE (city_name);


--
-- Name: сities сities_pkey; Type: CONSTRAINT; Schema: adres; Owner: postgres
--

ALTER TABLE ONLY adres."сities"
    ADD CONSTRAINT "сities_pkey" PRIMARY KEY (city_id);


--
-- Name: autobrands autobrands_autobrand_name_key; Type: CONSTRAINT; Schema: cars; Owner: postgres
--

ALTER TABLE ONLY cars.autobrands
    ADD CONSTRAINT autobrands_autobrand_name_key UNIQUE (autobrand_name);


--
-- Name: autobrands autobrands_pkey; Type: CONSTRAINT; Schema: cars; Owner: postgres
--

ALTER TABLE ONLY cars.autobrands
    ADD CONSTRAINT autobrands_pkey PRIMARY KEY (autobrand_id);


--
-- Name: autocategories autocategories_pkey; Type: CONSTRAINT; Schema: cars; Owner: postgres
--

ALTER TABLE ONLY cars.autocategories
    ADD CONSTRAINT autocategories_pkey PRIMARY KEY (autocategory_id);


--
-- Name: cars cars_car_vin_key; Type: CONSTRAINT; Schema: cars; Owner: postgres
--

ALTER TABLE ONLY cars.cars
    ADD CONSTRAINT cars_car_vin_key UNIQUE (car_vin);


--
-- Name: cars cars_pkey; Type: CONSTRAINT; Schema: cars; Owner: postgres
--

ALTER TABLE ONLY cars.cars
    ADD CONSTRAINT cars_pkey PRIMARY KEY (car_id);


--
-- Name: carsmodels carsmodels_pkey; Type: CONSTRAINT; Schema: cars; Owner: postgres
--

ALTER TABLE ONLY cars.carsmodels
    ADD CONSTRAINT carsmodels_pkey PRIMARY KEY (carsmodel_id);


--
-- Name: description_semitrailers description_semitrailers_pkey; Type: CONSTRAINT; Schema: cars; Owner: postgres
--

ALTER TABLE ONLY cars.description_semitrailers
    ADD CONSTRAINT description_semitrailers_pkey PRIMARY KEY (description_semitrailer_id);


--
-- Name: paletypes paletypes_pkey; Type: CONSTRAINT; Schema: cars; Owner: postgres
--

ALTER TABLE ONLY cars.paletypes
    ADD CONSTRAINT paletypes_pkey PRIMARY KEY (paletype_id);


--
-- Name: semitrailers semitrailers_pkey; Type: CONSTRAINT; Schema: cars; Owner: postgres
--

ALTER TABLE ONLY cars.semitrailers
    ADD CONSTRAINT semitrailers_pkey PRIMARY KEY (semitrailer_id);


--
-- Name: documents documents_pkey; Type: CONSTRAINT; Schema: document; Owner: postgres
--

ALTER TABLE ONLY document.documents
    ADD CONSTRAINT documents_pkey PRIMARY KEY (document_id);


--
-- Name: emploees emploees_pkey; Type: CONSTRAINT; Schema: emploee; Owner: postgres
--

ALTER TABLE ONLY emploee.emploees
    ADD CONSTRAINT emploees_pkey PRIMARY KEY (emploee_id);


--
-- Name: functionworker functionworker_functionworker_name_key; Type: CONSTRAINT; Schema: emploee; Owner: postgres
--

ALTER TABLE ONLY emploee.functionworker
    ADD CONSTRAINT functionworker_functionworker_name_key UNIQUE (functionworker_name);


--
-- Name: functionworker functionworker_pkey; Type: CONSTRAINT; Schema: emploee; Owner: postgres
--

ALTER TABLE ONLY emploee.functionworker
    ADD CONSTRAINT functionworker_pkey PRIMARY KEY (functionworker_id);


--
-- Name: orders orders_order_contractnumber_key; Type: CONSTRAINT; Schema: orders; Owner: postgres
--

ALTER TABLE ONLY orders.orders
    ADD CONSTRAINT orders_order_contractnumber_key UNIQUE (order_contractnumber);


--
-- Name: orders orders_order_contractnumber_key1; Type: CONSTRAINT; Schema: orders; Owner: postgres
--

ALTER TABLE ONLY orders.orders
    ADD CONSTRAINT orders_order_contractnumber_key1 UNIQUE (order_contractnumber);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: orders; Owner: postgres
--

ALTER TABLE ONLY orders.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (order_id);


--
-- Name: payments payments_pkey; Type: CONSTRAINT; Schema: payment; Owner: postgres
--

ALTER TABLE ONLY payment.payments
    ADD CONSTRAINT payments_pkey PRIMARY KEY (payment_id);


--
-- Name: autos autos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.autos
    ADD CONSTRAINT autos_pkey PRIMARY KEY (auto_id);


--
-- Name: routes routes_pkey; Type: CONSTRAINT; Schema: route; Owner: postgres
--

ALTER TABLE ONLY route.routes
    ADD CONSTRAINT routes_pkey PRIMARY KEY (route_id);


--
-- Name: shippers shippers_shipper_id_key; Type: CONSTRAINT; Schema: shipper; Owner: postgres
--

ALTER TABLE ONLY shipper.shippers
    ADD CONSTRAINT shippers_shipper_id_key UNIQUE (shipper_id);


--
-- Name: shippers shippers_shipper_name_key; Type: CONSTRAINT; Schema: shipper; Owner: postgres
--

ALTER TABLE ONLY shipper.shippers
    ADD CONSTRAINT shippers_shipper_name_key UNIQUE (shipper_name);


--
-- Name: vatnames vatnames_pkey; Type: CONSTRAINT; Schema: vat; Owner: postgres
--

ALTER TABLE ONLY vat.vatnames
    ADD CONSTRAINT vatnames_pkey PRIMARY KEY (vatname_id);


--
-- Name: vatnames vatnames_vatname_name_key; Type: CONSTRAINT; Schema: vat; Owner: postgres
--

ALTER TABLE ONLY vat.vatnames
    ADD CONSTRAINT vatnames_vatname_name_key UNIQUE (vatname_name);


--
-- Name: vats vats_pkey; Type: CONSTRAINT; Schema: vat; Owner: postgres
--

ALTER TABLE ONLY vat.vats
    ADD CONSTRAINT vats_pkey PRIMARY KEY (vat_id);


--
-- Name: vats vats_vat_stavka_key; Type: CONSTRAINT; Schema: vat; Owner: postgres
--

ALTER TABLE ONLY vat.vats
    ADD CONSTRAINT vats_vat_stavka_key UNIQUE (vat_stavka);


--
-- Name: adress adress_city_id_fkey; Type: FK CONSTRAINT; Schema: adres; Owner: postgres
--

ALTER TABLE ONLY adres.adress
    ADD CONSTRAINT adress_city_id_fkey FOREIGN KEY (city_id) REFERENCES adres."сities"(city_id) ON DELETE SET NULL;


--
-- Name: adress adress_street_id_fkey; Type: FK CONSTRAINT; Schema: adres; Owner: postgres
--

ALTER TABLE ONLY adres.adress
    ADD CONSTRAINT adress_street_id_fkey FOREIGN KEY (street_id) REFERENCES adres.streets(street_id) ON DELETE SET NULL;


--
-- Name: countrys countrys_vat_id_fkey; Type: FK CONSTRAINT; Schema: adres; Owner: postgres
--

ALTER TABLE ONLY adres.countrys
    ADD CONSTRAINT countrys_vat_id_fkey FOREIGN KEY (vat_id) REFERENCES vat.vats(vat_id) ON UPDATE SET NULL ON DELETE SET NULL;


--
-- Name: countrys countrys_vatname_id_fkey; Type: FK CONSTRAINT; Schema: adres; Owner: postgres
--

ALTER TABLE ONLY adres.countrys
    ADD CONSTRAINT countrys_vatname_id_fkey FOREIGN KEY (vatname_id) REFERENCES vat.vatnames(vatname_id) ON UPDATE SET NULL ON DELETE SET NULL;


--
-- Name: сities сities_country_id_fkey; Type: FK CONSTRAINT; Schema: adres; Owner: postgres
--

ALTER TABLE ONLY adres."сities"
    ADD CONSTRAINT "сities_country_id_fkey" FOREIGN KEY (country_id) REFERENCES adres.countrys(country_id) ON DELETE RESTRICT;


--
-- Name: cars cars_carsmodel_id_fkey; Type: FK CONSTRAINT; Schema: cars; Owner: postgres
--

ALTER TABLE ONLY cars.cars
    ADD CONSTRAINT cars_carsmodel_id_fkey FOREIGN KEY (carsmodel_id) REFERENCES cars.carsmodels(carsmodel_id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: carsmodels carsmodels_autobrand_id_fkey; Type: FK CONSTRAINT; Schema: cars; Owner: postgres
--

ALTER TABLE ONLY cars.carsmodels
    ADD CONSTRAINT carsmodels_autobrand_id_fkey FOREIGN KEY (autobrand_id) REFERENCES cars.autobrands(autobrand_id);


--
-- Name: carsmodels carsmodels_autocategory_id_fkey; Type: FK CONSTRAINT; Schema: cars; Owner: postgres
--

ALTER TABLE ONLY cars.carsmodels
    ADD CONSTRAINT carsmodels_autocategory_id_fkey FOREIGN KEY (autocategory_id) REFERENCES cars.autocategories(autocategory_id);


--
-- Name: emploees emploees_autocategory_id_fkey; Type: FK CONSTRAINT; Schema: emploee; Owner: postgres
--

ALTER TABLE ONLY emploee.emploees
    ADD CONSTRAINT emploees_autocategory_id_fkey FOREIGN KEY (autocategory_id) REFERENCES cars.autocategories(autocategory_id) ON DELETE SET NULL;


--
-- Name: emploees emploees_functionworker_id_fkey; Type: FK CONSTRAINT; Schema: emploee; Owner: postgres
--

ALTER TABLE ONLY emploee.emploees
    ADD CONSTRAINT emploees_functionworker_id_fkey FOREIGN KEY (functionworker_id) REFERENCES emploee.functionworker(functionworker_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: orders orders_emploee_id_fkey; Type: FK CONSTRAINT; Schema: orders; Owner: postgres
--

ALTER TABLE ONLY orders.orders
    ADD CONSTRAINT orders_emploee_id_fkey FOREIGN KEY (emploee_id) REFERENCES emploee.emploees(emploee_id);


--
-- Name: orders orders_payment_id_fkey; Type: FK CONSTRAINT; Schema: orders; Owner: postgres
--

ALTER TABLE ONLY orders.orders
    ADD CONSTRAINT orders_payment_id_fkey FOREIGN KEY (payment_id) REFERENCES payment.payments(payment_id);


--
-- Name: orders orders_shipper_id_fkey; Type: FK CONSTRAINT; Schema: orders; Owner: postgres
--

ALTER TABLE ONLY orders.orders
    ADD CONSTRAINT orders_shipper_id_fkey FOREIGN KEY (shipper_id) REFERENCES shipper.shippers(shipper_id);


--
-- PostgreSQL database dump complete
--

