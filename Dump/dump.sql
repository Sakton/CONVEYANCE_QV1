PGDMP                         y            conveyance_db    13.1    13.4 ?    ?           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            ?           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            ?           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            ?           1262    16982    conveyance_db    DATABASE     j   CREATE DATABASE conveyance_db WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Russian_Russia.1251';
    DROP DATABASE conveyance_db;
                postgres    false                        2615    16983    adres    SCHEMA        CREATE SCHEMA adres;
    DROP SCHEMA adres;
                postgres    false                        2615    16984    cars    SCHEMA        CREATE SCHEMA cars;
    DROP SCHEMA cars;
                postgres    false                        2615    16985    document    SCHEMA        CREATE SCHEMA document;
    DROP SCHEMA document;
                postgres    false                        2615    16986    emploee    SCHEMA        CREATE SCHEMA emploee;
    DROP SCHEMA emploee;
                postgres    false            	            2615    16987    orders    SCHEMA        CREATE SCHEMA orders;
    DROP SCHEMA orders;
                postgres    false                        2615    16988    payment    SCHEMA        CREATE SCHEMA payment;
    DROP SCHEMA payment;
                postgres    false                        2615    16989    route    SCHEMA        CREATE SCHEMA route;
    DROP SCHEMA route;
                postgres    false                        2615    16990    shipper    SCHEMA        CREATE SCHEMA shipper;
    DROP SCHEMA shipper;
                postgres    false                        2615    16991    vat    SCHEMA        CREATE SCHEMA vat;
    DROP SCHEMA vat;
                postgres    false                       1255    16992 #   addcity(character varying, integer) 	   PROCEDURE     ?   CREATE PROCEDURE adres.addcity(namecity character varying, idcountry integer)
    LANGUAGE sql
    AS $$
    INSERT INTO adres.сities ( city_name, country_id ) VALUES ( nameCity, idCountry );
$$;
 M   DROP PROCEDURE adres.addcity(namecity character varying, idcountry integer);
       adres          postgres    false    12                       1255    16993    getcityid(character varying)    FUNCTION     ?   CREATE FUNCTION adres.getcityid(ct character varying) RETURNS integer
    LANGUAGE sql
    AS $$ 
    SELECT city_id FROM adres.сities WHERE city_name = ct;
$$;
 5   DROP FUNCTION adres.getcityid(ct character varying);
       adres          postgres    false    12                       1255    16994    getcountryid(character varying)    FUNCTION     ?   CREATE FUNCTION adres.getcountryid(cntr character varying) RETURNS integer
    LANGUAGE sql
    AS $$
    SELECT country_id FROM adres.countrys WHERE country_name = cntr;
$$;
 :   DROP FUNCTION adres.getcountryid(cntr character varying);
       adres          postgres    false    12                       1255    16995    getstreetid(character varying)    FUNCTION     ?  CREATE FUNCTION adres.getstreetid(st character varying) RETURNS integer
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
 7   DROP FUNCTION adres.getstreetid(st character varying);
       adres          postgres    false    12                       1255    16996 X   insertadress(character varying, character varying, character varying, character varying) 	   PROCEDURE     ?  CREATE PROCEDURE adres.insertadress(ct character varying, strt character varying, idx character varying, type_adress character varying)
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
 ?   DROP PROCEDURE adres.insertadress(ct character varying, strt character varying, idx character varying, type_adress character varying);
       adres          postgres    false    12                       1255    16997 E   add_carmodel(character varying, character varying, character varying) 	   PROCEDURE     i  CREATE PROCEDURE cars.add_carmodel(namebrand character varying, symbolcategory character varying, carmodel character varying)
    LANGUAGE sql
    AS $$
	INSERT INTO cars.carsmodels ( autobrand_id, autocategory_id, carsmodel_name )
	    VALUES ( ( SELECT cars.getAutobrand_id(nameBrand) ), ( SELECT cars.getAutocategory_id(symbolCategory) ), carModel );
$$;
 }   DROP PROCEDURE cars.add_carmodel(namebrand character varying, symbolcategory character varying, carmodel character varying);
       cars          postgres    false    13                       1255    16998 "   getautobrand_id(character varying)    FUNCTION     ?   CREATE FUNCTION cars.getautobrand_id(namebrand character varying) RETURNS integer
    LANGUAGE sql
    AS $$
	SELECT autobrand_id FROM cars.autobrands WHERE autobrand_name = nameBrand;
$$;
 A   DROP FUNCTION cars.getautobrand_id(namebrand character varying);
       cars          postgres    false    13            	           1255    16999 %   getautocategory_id(character varying)    FUNCTION     ?   CREATE FUNCTION cars.getautocategory_id(symbolcategory character varying) RETURNS integer
    LANGUAGE sql
    AS $$
	SELECT autocategory_id FROM cars.autocategories WHERE autocategory_symbol = symbolCategory;
$$;
 I   DROP FUNCTION cars.getautocategory_id(symbolcategory character varying);
       cars          postgres    false    13            
           1255    17000 2   getdocumentid(character varying, integer, integer)    FUNCTION     ?  CREATE FUNCTION document.getdocumentid(postperiod character varying, copycmr integer, originaldocuments integer) RETURNS integer
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
 p   DROP FUNCTION document.getdocumentid(postperiod character varying, copycmr integer, originaldocuments integer);
       document          postgres    false    14                       1255    17001 4   insertdocuments(character varying, integer, integer) 	   PROCEDURE     0  CREATE PROCEDURE document.insertdocuments(postperiod character varying, copycmr integer, originaldocuments integer)
    LANGUAGE sql
    AS $$
    INSERT INTO document.documents (document_postperiod, document_2copycmr, document_original)
        VALUES ( postPeriod, copyCmr, originalDocuments );
$$;
 s   DROP PROCEDURE document.insertdocuments(postperiod character varying, copycmr integer, originaldocuments integer);
       document          postgres    false    14                       1255    17002 /   addemploee(integer, integer, character varying) 	   PROCEDURE     (  CREATE PROCEDURE emploee.addemploee(functionworkerid integer, autocategoryid integer, emploeename character varying)
    LANGUAGE sql
    AS $$
    INSERT INTO emploee.emploees ( functionWorker_id, autocategory_id, emploee_name )
	VALUES ( functionWorkerId, autocategoryId, emploeeName );
$$;
 t   DROP PROCEDURE emploee.addemploee(functionworkerid integer, autocategoryid integer, emploeename character varying);
       emploee          postgres    false    6                       1255    17003 C   addemploee(character varying, character varying, character varying) 	   PROCEDURE     ?  CREATE PROCEDURE emploee.addemploee(functionworkername character varying, autocategoryname character varying, emploeename character varying)
    LANGUAGE sql
    AS $$
    INSERT INTO emploee.emploees ( functionWorker_id, autocategory_id, emploee_name )
	VALUES ( ( SELECT emploee.getFunctionWorkerId( functionWorkerName ) ), ( SELECT cars.getAutocategory_id( autocategoryName ) ), emploeeName );
$$;
 ?   DROP PROCEDURE emploee.addemploee(functionworkername character varying, autocategoryname character varying, emploeename character varying);
       emploee          postgres    false    6                       1255    17004 &   getfunctionworkerid(character varying)    FUNCTION     ?   CREATE FUNCTION emploee.getfunctionworkerid(functionworkername character varying) RETURNS integer
    LANGUAGE sql
    AS $$
    SELECT functionWorker_id FROM emploee.functionWorker WHERE functionWorker_name = functionWorkerName;
$$;
 Q   DROP FUNCTION emploee.getfunctionworkerid(functionworkername character varying);
       emploee          postgres    false    6                       1255    17005 T   addorder(integer, integer, integer, integer, integer, date, character varying, text) 	   PROCEDURE     ?  CREATE PROCEDURE orders.addorder(idshipper integer, idemploee integer, idpayment integer, idroute integer, iddocuments integer, dataorder date, contractnumber character varying, noteorder text)
    LANGUAGE sql
    AS $$
    INSERT INTO orders.orders( shipper_id, emploee_id, payment_id, route_id, document_id, order_data, order_contractNumber, order_note )
        VALUES ( idShipper, idEmploee, idPayment, idRoute, idDocuments, dataOrder, contractNumber, noteOrder );
$$;
 ?   DROP PROCEDURE orders.addorder(idshipper integer, idemploee integer, idpayment integer, idroute integer, iddocuments integer, dataorder date, contractnumber character varying, noteorder text);
       orders          postgres    false    9            "           1255    17323 ?   addtoorder(character varying, character varying, integer, integer, numeric, character varying, character varying, integer, integer, character varying, integer, integer, character varying) 	   PROCEDURE     |  CREATE PROCEDURE orders.addtoorder(orderdate character varying, ordernumber character varying, shipperid integer, emploeeid integer, paymentcost numeric, paymentperiod character varying, paymentcurrency character varying, routesarrival integer, routesroute integer, documentpostperiod character varying, document2copycmr integer, documentoriginal integer, odernote character varying)
    LANGUAGE sql
    AS $$
    INSERT INTO orders.orders ( shipper_id, emploee_id, payment_id, route_id, document_id, order_data, order_contractNumber, order_note )
    VALUES ( shipperId, emploeeId,
				    ( SELECT payment.getPayment_id( paymentCost, paymentPeriod, paymentCurrency ) ),
				    ( SELECT route.getRouteId( routesArrival, routesRoute ) ),
				    ( SELECT document.getDocumentId( documentPostPeriod, document2CopyCmr, documentOriginal ) ),
	    orderDate::date, orderNumber, oderNote );
$$;
   DROP PROCEDURE orders.addtoorder(orderdate character varying, ordernumber character varying, shipperid integer, emploeeid integer, paymentcost numeric, paymentperiod character varying, paymentcurrency character varying, routesarrival integer, routesroute integer, documentpostperiod character varying, document2copycmr integer, documentoriginal integer, odernote character varying);
       orders          postgres    false    9            #           1255    17325 ?   updateorder(integer, character varying, character varying, integer, integer, numeric, character varying, character varying, integer, integer, character varying, integer, integer, character varying) 	   PROCEDURE     ?  CREATE PROCEDURE orders.updateorder(orderid integer, orderdate character varying, ordernumber character varying, shipperid integer, emploeeid integer, paymentcost numeric, paymentperiod character varying, paymentcurrency character varying, routesarrival integer, routesroute integer, documentpostperiod character varying, document2copycmr integer, documentoriginal integer, odernote character varying)
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
 ?  DROP PROCEDURE orders.updateorder(orderid integer, orderdate character varying, ordernumber character varying, shipperid integer, emploeeid integer, paymentcost numeric, paymentperiod character varying, paymentcurrency character varying, routesarrival integer, routesroute integer, documentpostperiod character varying, document2copycmr integer, documentoriginal integer, odernote character varying);
       orders          postgres    false    9                       1255    17006 <   getpayment_id(numeric, character varying, character varying)    FUNCTION       CREATE FUNCTION payment.getpayment_id(cost numeric, period character varying, currency character varying) RETURNS integer
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
 i   DROP FUNCTION payment.getpayment_id(cost numeric, period character varying, currency character varying);
       payment          postgres    false    4                       1255    17007 <   insertpayment(numeric, character varying, character varying) 	   PROCEDURE       CREATE PROCEDURE payment.insertpayment(cost numeric, period character varying, currency character varying)
    LANGUAGE sql
    AS $$
	INSERT INTO payment.payments ( payment_cost, payment_period, payment_currency )
	VALUES ( cost, period, currency );
$$;
 j   DROP PROCEDURE payment.insertpayment(cost numeric, period character varying, currency character varying);
       payment          postgres    false    4            !           1255    17308    getrouteid(integer, integer)    FUNCTION     ?  CREATE FUNCTION route.getrouteid(arrival integer, route integer) RETURNS integer
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
 @   DROP FUNCTION route.getrouteid(arrival integer, route integer);
       route          postgres    false    5                        1255    17008 %   getrouteid(integer, integer, numeric)    FUNCTION     ?  CREATE FUNCTION route.getrouteid(arrival integer, route integer, ante numeric) RETURNS integer
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
 N   DROP FUNCTION route.getrouteid(arrival integer, route integer, ante numeric);
       route          postgres    false    5                       1255    17324    insertroute(integer, integer) 	   PROCEDURE     ?   CREATE PROCEDURE route.insertroute(arrival integer, rout integer)
    LANGUAGE sql
    AS $$
    INSERT INTO route.routes( route_arrival, route_route ) VALUES ( arrival, rout );
$$;
 A   DROP PROCEDURE route.insertroute(arrival integer, rout integer);
       route          postgres    false    5                       1255    17010    addshipper(character varying) 	   PROCEDURE     ?   CREATE PROCEDURE shipper.addshipper(nameshipper character varying)
    LANGUAGE sql
    AS $$
    INSERT INTO shipper.shippers ( shipper_name ) VALUES ( nameShipper );
$$;
 B   DROP PROCEDURE shipper.addshipper(nameshipper character varying);
       shipper          postgres    false    11                       1255    17011    getvatid(numeric)    FUNCTION     ?   CREATE FUNCTION vat.getvatid(vat_st numeric) RETURNS integer
    LANGUAGE sql
    AS $$
    SELECT vat_id FROM vat.vats WHERE vat_stavka = vat_st;
$$;
 ,   DROP FUNCTION vat.getvatid(vat_st numeric);
       vat          postgres    false    7                       1255    17012    getvatnames(character varying)    FUNCTION     ?   CREATE FUNCTION vat.getvatnames(nm character varying) RETURNS integer
    LANGUAGE sql
    AS $$
    SELECT vatname_id FROM vat.vatnames WHERE vatname_name = nm;
$$;
 5   DROP FUNCTION vat.getvatnames(nm character varying);
       vat          postgres    false    7            ?            1259    17013    adress    TABLE     ?  CREATE TABLE adres.adress (
    adres_id integer NOT NULL,
    city_id integer NOT NULL,
    street_id integer NOT NULL,
    adres_index character varying(20),
    adres_type character varying(20) NOT NULL,
    CONSTRAINT adress_adres_type_check CHECK (((adres_type)::text = ANY (ARRAY[('Фактический'::character varying)::text, ('Юридический'::character varying)::text])))
);
    DROP TABLE adres.adress;
       adres         heap    postgres    false    12            ?            1259    17017    adress_adres_id_seq    SEQUENCE     ?   CREATE SEQUENCE adres.adress_adres_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE adres.adress_adres_id_seq;
       adres          postgres    false    12    209            ?           0    0    adress_adres_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE adres.adress_adres_id_seq OWNED BY adres.adress.adres_id;
          adres          postgres    false    210            ?            1259    17019    countrys    TABLE     L  CREATE TABLE adres.countrys (
    country_id integer NOT NULL,
    vat_id integer NOT NULL,
    vatname_id integer NOT NULL,
    country_name character varying(256) NOT NULL,
    country_abbreviated_2 character varying(4) NOT NULL,
    country_abbreviated_3 character varying(4) NOT NULL,
    country_icon character varying(256)
);
    DROP TABLE adres.countrys;
       adres         heap    postgres    false    12            ?            1259    17025    streets    TABLE     p   CREATE TABLE adres.streets (
    street_id integer NOT NULL,
    street_name character varying(256) NOT NULL
);
    DROP TABLE adres.streets;
       adres         heap    postgres    false    12            ?            1259    17028    сities    TABLE     ?   CREATE TABLE adres."сities" (
    city_id integer NOT NULL,
    city_name character varying(256) NOT NULL,
    country_id integer
);
    DROP TABLE adres."сities";
       adres         heap    postgres    false    12            ?            1259    17031 
   adressview    VIEW     M  CREATE VIEW adres.adressview AS
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
    DROP VIEW adres.adressview;
       adres          postgres    false    213    211    209    209    209    212    209    209    212    211    211    213    213    12            ?            1259    17036    countrys_country_id_seq    SEQUENCE     ?   CREATE SEQUENCE adres.countrys_country_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE adres.countrys_country_id_seq;
       adres          postgres    false    12    211            ?           0    0    countrys_country_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE adres.countrys_country_id_seq OWNED BY adres.countrys.country_id;
          adres          postgres    false    215            ?            1259    17038    streets_street_id_seq    SEQUENCE     ?   CREATE SEQUENCE adres.streets_street_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE adres.streets_street_id_seq;
       adres          postgres    false    12    212            ?           0    0    streets_street_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE adres.streets_street_id_seq OWNED BY adres.streets.street_id;
          adres          postgres    false    216            ?            1259    17040    testadressview    MATERIALIZED VIEW     m  CREATE MATERIALIZED VIEW adres.testadressview AS
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
 -   DROP MATERIALIZED VIEW adres.testadressview;
       adres         heap    postgres    false    209    213    213    213    212    212    211    211    211    209    209    209    209    12            ?            1259    17048    сities_city_id_seq    SEQUENCE     ?   CREATE SEQUENCE adres."сities_city_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE adres."сities_city_id_seq";
       adres          postgres    false    213    12            ?           0    0    сities_city_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE adres."сities_city_id_seq" OWNED BY adres."сities".city_id;
          adres          postgres    false    218            ?            1259    17050 
   autobrands    TABLE     ?   CREATE TABLE cars.autobrands (
    autobrand_id integer NOT NULL,
    autobrand_name character varying(256) NOT NULL,
    autobrand_icon character varying(256) DEFAULT 'no_icon.png'::character varying
);
    DROP TABLE cars.autobrands;
       cars         heap    postgres    false    13            ?            1259    17057    autobrands_autobrand_id_seq    SEQUENCE     ?   CREATE SEQUENCE cars.autobrands_autobrand_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE cars.autobrands_autobrand_id_seq;
       cars          postgres    false    13    219                        0    0    autobrands_autobrand_id_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE cars.autobrands_autobrand_id_seq OWNED BY cars.autobrands.autobrand_id;
          cars          postgres    false    220            ?            1259    17059    autocategories    TABLE     	  CREATE TABLE cars.autocategories (
    autocategory_id integer NOT NULL,
    autocategory_name character varying(256) NOT NULL,
    autocategory_symbol character varying(5) NOT NULL,
    autocategory_icon character varying(64),
    autocategory_description text
);
     DROP TABLE cars.autocategories;
       cars         heap    postgres    false    13            ?            1259    17065 "   autocategories_autocategory_id_seq    SEQUENCE     ?   CREATE SEQUENCE cars.autocategories_autocategory_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 7   DROP SEQUENCE cars.autocategories_autocategory_id_seq;
       cars          postgres    false    221    13                       0    0 "   autocategories_autocategory_id_seq    SEQUENCE OWNED BY     e   ALTER SEQUENCE cars.autocategories_autocategory_id_seq OWNED BY cars.autocategories.autocategory_id;
          cars          postgres    false    222            ?            1259    17374    cars    TABLE     ?   CREATE TABLE cars.cars (
    car_id integer NOT NULL,
    car_vin character varying(64) NOT NULL,
    car_date_release date,
    car_date_gto date,
    carsmodel_id integer
);
    DROP TABLE cars.cars;
       cars         heap    postgres    false    13            ?            1259    17067 
   carsmodels    TABLE     ?   CREATE TABLE cars.carsmodels (
    carsmodel_id integer NOT NULL,
    autobrand_id integer NOT NULL,
    autocategory_id integer NOT NULL,
    carsmodel_name character varying(200),
    semitrailer_id integer
);
    DROP TABLE cars.carsmodels;
       cars         heap    postgres    false    13            ?            1259    17342    description_semitrailers    TABLE     ?   CREATE TABLE cars.description_semitrailers (
    description_semitrailer_id integer NOT NULL,
    description_semitrailer_description text
);
 *   DROP TABLE cars.description_semitrailers;
       cars         heap    postgres    false    13            ?            1259    17361    semitrailers    TABLE     s  CREATE TABLE cars.semitrailers (
    semitrailer_id integer NOT NULL,
    semitrailer_name character varying(64),
    semitrailer_carrying numeric(4,2),
    semitrailer_gabarit_lenth numeric(4,2),
    semitrailer_gabarit_width numeric(4,2),
    semitrailer_gabarit_height numeric(4,2),
    description_semitrailer_id integer,
    semitrailer_img character varying(64)
);
    DROP TABLE cars.semitrailers;
       cars         heap    postgres    false    13            ?            1259    17388    automobiles    VIEW       CREATE VIEW cars.automobiles AS
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
    DROP VIEW cars.automobiles;
       cars          postgres    false    250    223    223    254    254    254    254    254    252    252    252    252    252    252    252    223    223    223    221    221    221    221    221    219    219    219    13            ?            1259    17372    cars_car_id_seq    SEQUENCE     ?   CREATE SEQUENCE cars.cars_car_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE cars.cars_car_id_seq;
       cars          postgres    false    13    254                       0    0    cars_car_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE cars.cars_car_id_seq OWNED BY cars.cars.car_id;
          cars          postgres    false    253            ?            1259    17070    carsmodels_carsmodel_id_seq    SEQUENCE     ?   CREATE SEQUENCE cars.carsmodels_carsmodel_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE cars.carsmodels_carsmodel_id_seq;
       cars          postgres    false    13    223                       0    0    carsmodels_carsmodel_id_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE cars.carsmodels_carsmodel_id_seq OWNED BY cars.carsmodels.carsmodel_id;
          cars          postgres    false    224            ?            1259    17340 7   description_semitrailers_description_semitrailer_id_seq    SEQUENCE     ?   CREATE SEQUENCE cars.description_semitrailers_description_semitrailer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 L   DROP SEQUENCE cars.description_semitrailers_description_semitrailer_id_seq;
       cars          postgres    false    13    250                       0    0 7   description_semitrailers_description_semitrailer_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE cars.description_semitrailers_description_semitrailer_id_seq OWNED BY cars.description_semitrailers.description_semitrailer_id;
          cars          postgres    false    249            ?            1259    17334 	   paletypes    TABLE     ?   CREATE TABLE cars.paletypes (
    paletype_id integer NOT NULL,
    paletype_name character varying(96),
    paletype_lenth numeric(4,2),
    paletype_width numeric(4,2)
);
    DROP TABLE cars.paletypes;
       cars         heap    postgres    false    13            ?            1259    17332    paletypes_paletype_id_seq    SEQUENCE     ?   CREATE SEQUENCE cars.paletypes_paletype_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE cars.paletypes_paletype_id_seq;
       cars          postgres    false    248    13                       0    0    paletypes_paletype_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE cars.paletypes_paletype_id_seq OWNED BY cars.paletypes.paletype_id;
          cars          postgres    false    247            ?            1259    17359    semitrailers_semitrailer_id_seq    SEQUENCE     ?   CREATE SEQUENCE cars.semitrailers_semitrailer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 4   DROP SEQUENCE cars.semitrailers_semitrailer_id_seq;
       cars          postgres    false    252    13                       0    0    semitrailers_semitrailer_id_seq    SEQUENCE OWNED BY     _   ALTER SEQUENCE cars.semitrailers_semitrailer_id_seq OWNED BY cars.semitrailers.semitrailer_id;
          cars          postgres    false    251                        1259    17397    semitrailers_view    VIEW     ?  CREATE VIEW cars.semitrailers_view AS
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
 "   DROP VIEW cars.semitrailers_view;
       cars          postgres    false    250    252    252    252    252    252    252    252    252    250    13            ?            1259    17072 	   documents    TABLE     ?   CREATE TABLE document.documents (
    document_id integer NOT NULL,
    document_postperiod character varying(64),
    document_2copycmr integer,
    document_original integer
);
    DROP TABLE document.documents;
       document         heap    postgres    false    14            ?            1259    17075    documents_document_id_seq    SEQUENCE     ?   CREATE SEQUENCE document.documents_document_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE document.documents_document_id_seq;
       document          postgres    false    14    225                       0    0    documents_document_id_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE document.documents_document_id_seq OWNED BY document.documents.document_id;
          document          postgres    false    226            ?            1259    17077    emploees    TABLE     ?   CREATE TABLE emploee.emploees (
    emploee_id integer NOT NULL,
    functionworker_id integer NOT NULL,
    autocategory_id integer,
    emploee_name character varying(200)
);
    DROP TABLE emploee.emploees;
       emploee         heap    postgres    false    6            ?            1259    17080    emploees_emploee_id_seq    SEQUENCE     ?   CREATE SEQUENCE emploee.emploees_emploee_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE emploee.emploees_emploee_id_seq;
       emploee          postgres    false    6    227                       0    0    emploees_emploee_id_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE emploee.emploees_emploee_id_seq OWNED BY emploee.emploees.emploee_id;
          emploee          postgres    false    228            ?            1259    17082    functionworker    TABLE     ?   CREATE TABLE emploee.functionworker (
    functionworker_id integer NOT NULL,
    functionworker_name character varying(128)
);
 #   DROP TABLE emploee.functionworker;
       emploee         heap    postgres    false    6            ?            1259    17085    emploeeview    VIEW     c  CREATE VIEW emploee.emploeeview AS
 SELECT e.emploee_id,
    e.emploee_name,
    fw.functionworker_name,
    cr.autocategory_symbol,
    cr.autocategory_icon
   FROM ((emploee.emploees e
     JOIN emploee.functionworker fw ON ((e.functionworker_id = fw.functionworker_id)))
     JOIN cars.autocategories cr ON ((e.autocategory_id = cr.autocategory_id)));
    DROP VIEW emploee.emploeeview;
       emploee          postgres    false    229    227    221    221    229    227    227    227    221    6            ?            1259    17089 $   functionworker_functionworker_id_seq    SEQUENCE     ?   CREATE SEQUENCE emploee.functionworker_functionworker_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 <   DROP SEQUENCE emploee.functionworker_functionworker_id_seq;
       emploee          postgres    false    229    6            	           0    0 $   functionworker_functionworker_id_seq    SEQUENCE OWNED BY     o   ALTER SEQUENCE emploee.functionworker_functionworker_id_seq OWNED BY emploee.functionworker.functionworker_id;
          emploee          postgres    false    231            ?            1259    17091    voditeli    VIEW     ?   CREATE VIEW emploee.voditeli AS
 SELECT emploees.emploee_id,
    emploees.emploee_name
   FROM emploee.emploees
  WHERE (emploees.functionworker_id = ( SELECT emploee.getfunctionworkerid('Водитель'::character varying) AS getfunctionworkerid));
    DROP VIEW emploee.voditeli;
       emploee          postgres    false    270    227    227    227    6            ?            1259    17095    orders    TABLE       CREATE TABLE orders.orders (
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
    DROP TABLE orders.orders;
       orders         heap    postgres    false    9            ?            1259    17101    orders_order_id_seq    SEQUENCE     ?   CREATE SEQUENCE orders.orders_order_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE orders.orders_order_id_seq;
       orders          postgres    false    233    9            
           0    0    orders_order_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE orders.orders_order_id_seq OWNED BY orders.orders.order_id;
          orders          postgres    false    234            ?            1259    17103    payments    TABLE     ?   CREATE TABLE payment.payments (
    payment_id integer NOT NULL,
    payment_cost numeric(32,2),
    payment_period character varying(64),
    payment_currency character varying(64)
);
    DROP TABLE payment.payments;
       payment         heap    postgres    false    4            ?            1259    17302    routes    TABLE     q   CREATE TABLE route.routes (
    route_id integer NOT NULL,
    route_arrival integer,
    route_route integer
);
    DROP TABLE route.routes;
       route         heap    postgres    false    5            ?            1259    17106    shippers    TABLE     u   CREATE TABLE shipper.shippers (
    shipper_id integer NOT NULL,
    shipper_name character varying(200) NOT NULL
);
    DROP TABLE shipper.shippers;
       shipper         heap    postgres    false    11            ?            1259    17327 
   ordersview    VIEW     %  CREATE VIEW orders.ordersview AS
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
    DROP VIEW orders.ordersview;
       orders          postgres    false    233    225    225    225    225    227    227    233    233    233    233    233    245    245    245    236    236    235    235    235    235    233    233    233    9            ?            1259    17114    payments_payment_id_seq    SEQUENCE     ?   CREATE SEQUENCE payment.payments_payment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE payment.payments_payment_id_seq;
       payment          postgres    false    4    235                       0    0    payments_payment_id_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE payment.payments_payment_id_seq OWNED BY payment.payments.payment_id;
          payment          postgres    false    237            ?            1259    17116    testadressview    MATERIALIZED VIEW     n  CREATE MATERIALIZED VIEW public.testadressview AS
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
 .   DROP MATERIALIZED VIEW public.testadressview;
       public         heap    postgres    false    211    212    211    212    213    213    211    209    209    209    213    209    209            ?            1259    17300    routes_route_id_seq    SEQUENCE     ?   CREATE SEQUENCE route.routes_route_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE route.routes_route_id_seq;
       route          postgres    false    5    245                       0    0    routes_route_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE route.routes_route_id_seq OWNED BY route.routes.route_id;
          route          postgres    false    244            ?            1259    17129    shippers_shipper_id_seq    SEQUENCE     ?   CREATE SEQUENCE shipper.shippers_shipper_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE shipper.shippers_shipper_id_seq;
       shipper          postgres    false    11    236                       0    0    shippers_shipper_id_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE shipper.shippers_shipper_id_seq OWNED BY shipper.shippers.shipper_id;
          shipper          postgres    false    239            ?            1259    17131    vatnames    TABLE     g   CREATE TABLE vat.vatnames (
    vatname_id integer NOT NULL,
    vatname_name character varying(10)
);
    DROP TABLE vat.vatnames;
       vat         heap    postgres    false    7            ?            1259    17134    vatnames_vatname_id_seq    SEQUENCE     ?   CREATE SEQUENCE vat.vatnames_vatname_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE vat.vatnames_vatname_id_seq;
       vat          postgres    false    240    7                       0    0    vatnames_vatname_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE vat.vatnames_vatname_id_seq OWNED BY vat.vatnames.vatname_id;
          vat          postgres    false    241            ?            1259    17136    vats    TABLE     ?   CREATE TABLE vat.vats (
    vat_id integer NOT NULL,
    vat_stavka numeric(4,2) NOT NULL,
    CONSTRAINT vats_valid CHECK (((vat_stavka > (0)::numeric) AND (vat_stavka < (100)::numeric)))
);
    DROP TABLE vat.vats;
       vat         heap    postgres    false    7            ?            1259    17140    vats_vat_id_seq    SEQUENCE     ?   CREATE SEQUENCE vat.vats_vat_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE vat.vats_vat_id_seq;
       vat          postgres    false    7    242                       0    0    vats_vat_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE vat.vats_vat_id_seq OWNED BY vat.vats.vat_id;
          vat          postgres    false    243            ?           2604    17142    adress adres_id    DEFAULT     p   ALTER TABLE ONLY adres.adress ALTER COLUMN adres_id SET DEFAULT nextval('adres.adress_adres_id_seq'::regclass);
 =   ALTER TABLE adres.adress ALTER COLUMN adres_id DROP DEFAULT;
       adres          postgres    false    210    209            ?           2604    17143    countrys country_id    DEFAULT     x   ALTER TABLE ONLY adres.countrys ALTER COLUMN country_id SET DEFAULT nextval('adres.countrys_country_id_seq'::regclass);
 A   ALTER TABLE adres.countrys ALTER COLUMN country_id DROP DEFAULT;
       adres          postgres    false    215    211            ?           2604    17144    streets street_id    DEFAULT     t   ALTER TABLE ONLY adres.streets ALTER COLUMN street_id SET DEFAULT nextval('adres.streets_street_id_seq'::regclass);
 ?   ALTER TABLE adres.streets ALTER COLUMN street_id DROP DEFAULT;
       adres          postgres    false    216    212            ?           2604    17145    сities city_id    DEFAULT     t   ALTER TABLE ONLY adres."сities" ALTER COLUMN city_id SET DEFAULT nextval('adres."сities_city_id_seq"'::regclass);
 ?   ALTER TABLE adres."сities" ALTER COLUMN city_id DROP DEFAULT;
       adres          postgres    false    218    213            ?           2604    17146    autobrands autobrand_id    DEFAULT     ~   ALTER TABLE ONLY cars.autobrands ALTER COLUMN autobrand_id SET DEFAULT nextval('cars.autobrands_autobrand_id_seq'::regclass);
 D   ALTER TABLE cars.autobrands ALTER COLUMN autobrand_id DROP DEFAULT;
       cars          postgres    false    220    219            ?           2604    17147    autocategories autocategory_id    DEFAULT     ?   ALTER TABLE ONLY cars.autocategories ALTER COLUMN autocategory_id SET DEFAULT nextval('cars.autocategories_autocategory_id_seq'::regclass);
 K   ALTER TABLE cars.autocategories ALTER COLUMN autocategory_id DROP DEFAULT;
       cars          postgres    false    222    221            ?           2604    17377    cars car_id    DEFAULT     f   ALTER TABLE ONLY cars.cars ALTER COLUMN car_id SET DEFAULT nextval('cars.cars_car_id_seq'::regclass);
 8   ALTER TABLE cars.cars ALTER COLUMN car_id DROP DEFAULT;
       cars          postgres    false    254    253    254            ?           2604    17148    carsmodels carsmodel_id    DEFAULT     ~   ALTER TABLE ONLY cars.carsmodels ALTER COLUMN carsmodel_id SET DEFAULT nextval('cars.carsmodels_carsmodel_id_seq'::regclass);
 D   ALTER TABLE cars.carsmodels ALTER COLUMN carsmodel_id DROP DEFAULT;
       cars          postgres    false    224    223            ?           2604    17345 3   description_semitrailers description_semitrailer_id    DEFAULT     ?   ALTER TABLE ONLY cars.description_semitrailers ALTER COLUMN description_semitrailer_id SET DEFAULT nextval('cars.description_semitrailers_description_semitrailer_id_seq'::regclass);
 `   ALTER TABLE cars.description_semitrailers ALTER COLUMN description_semitrailer_id DROP DEFAULT;
       cars          postgres    false    249    250    250            ?           2604    17337    paletypes paletype_id    DEFAULT     z   ALTER TABLE ONLY cars.paletypes ALTER COLUMN paletype_id SET DEFAULT nextval('cars.paletypes_paletype_id_seq'::regclass);
 B   ALTER TABLE cars.paletypes ALTER COLUMN paletype_id DROP DEFAULT;
       cars          postgres    false    248    247    248            ?           2604    17364    semitrailers semitrailer_id    DEFAULT     ?   ALTER TABLE ONLY cars.semitrailers ALTER COLUMN semitrailer_id SET DEFAULT nextval('cars.semitrailers_semitrailer_id_seq'::regclass);
 H   ALTER TABLE cars.semitrailers ALTER COLUMN semitrailer_id DROP DEFAULT;
       cars          postgres    false    252    251    252            ?           2604    17149    documents document_id    DEFAULT     ?   ALTER TABLE ONLY document.documents ALTER COLUMN document_id SET DEFAULT nextval('document.documents_document_id_seq'::regclass);
 F   ALTER TABLE document.documents ALTER COLUMN document_id DROP DEFAULT;
       document          postgres    false    226    225            ?           2604    17150    emploees emploee_id    DEFAULT     |   ALTER TABLE ONLY emploee.emploees ALTER COLUMN emploee_id SET DEFAULT nextval('emploee.emploees_emploee_id_seq'::regclass);
 C   ALTER TABLE emploee.emploees ALTER COLUMN emploee_id DROP DEFAULT;
       emploee          postgres    false    228    227            ?           2604    17151     functionworker functionworker_id    DEFAULT     ?   ALTER TABLE ONLY emploee.functionworker ALTER COLUMN functionworker_id SET DEFAULT nextval('emploee.functionworker_functionworker_id_seq'::regclass);
 P   ALTER TABLE emploee.functionworker ALTER COLUMN functionworker_id DROP DEFAULT;
       emploee          postgres    false    231    229            ?           2604    17152    orders order_id    DEFAULT     r   ALTER TABLE ONLY orders.orders ALTER COLUMN order_id SET DEFAULT nextval('orders.orders_order_id_seq'::regclass);
 >   ALTER TABLE orders.orders ALTER COLUMN order_id DROP DEFAULT;
       orders          postgres    false    234    233            ?           2604    17153    payments payment_id    DEFAULT     |   ALTER TABLE ONLY payment.payments ALTER COLUMN payment_id SET DEFAULT nextval('payment.payments_payment_id_seq'::regclass);
 C   ALTER TABLE payment.payments ALTER COLUMN payment_id DROP DEFAULT;
       payment          postgres    false    237    235            ?           2604    17305    routes route_id    DEFAULT     p   ALTER TABLE ONLY route.routes ALTER COLUMN route_id SET DEFAULT nextval('route.routes_route_id_seq'::regclass);
 =   ALTER TABLE route.routes ALTER COLUMN route_id DROP DEFAULT;
       route          postgres    false    245    244    245            ?           2604    17155    shippers shipper_id    DEFAULT     |   ALTER TABLE ONLY shipper.shippers ALTER COLUMN shipper_id SET DEFAULT nextval('shipper.shippers_shipper_id_seq'::regclass);
 C   ALTER TABLE shipper.shippers ALTER COLUMN shipper_id DROP DEFAULT;
       shipper          postgres    false    239    236            ?           2604    17156    vatnames vatname_id    DEFAULT     t   ALTER TABLE ONLY vat.vatnames ALTER COLUMN vatname_id SET DEFAULT nextval('vat.vatnames_vatname_id_seq'::regclass);
 ?   ALTER TABLE vat.vatnames ALTER COLUMN vatname_id DROP DEFAULT;
       vat          postgres    false    241    240            ?           2604    17157    vats vat_id    DEFAULT     d   ALTER TABLE ONLY vat.vats ALTER COLUMN vat_id SET DEFAULT nextval('vat.vats_vat_id_seq'::regclass);
 7   ALTER TABLE vat.vats ALTER COLUMN vat_id DROP DEFAULT;
       vat          postgres    false    243    242            ?          0    17013    adress 
   TABLE DATA           V   COPY adres.adress (adres_id, city_id, street_id, adres_index, adres_type) FROM stdin;
    adres          postgres    false    209   0      ?          0    17019    countrys 
   TABLE DATA           ?   COPY adres.countrys (country_id, vat_id, vatname_id, country_name, country_abbreviated_2, country_abbreviated_3, country_icon) FROM stdin;
    adres          postgres    false    211   10      ?          0    17025    streets 
   TABLE DATA           8   COPY adres.streets (street_id, street_name) FROM stdin;
    adres          postgres    false    212   
4      ?          0    17028    сities 
   TABLE DATA           B   COPY adres."сities" (city_id, city_name, country_id) FROM stdin;
    adres          postgres    false    213   '4      ?          0    17050 
   autobrands 
   TABLE DATA           P   COPY cars.autobrands (autobrand_id, autobrand_name, autobrand_icon) FROM stdin;
    cars          postgres    false    219   D4      ?          0    17059    autocategories 
   TABLE DATA           ?   COPY cars.autocategories (autocategory_id, autocategory_name, autocategory_symbol, autocategory_icon, autocategory_description) FROM stdin;
    cars          postgres    false    221   {4      ?          0    17374    cars 
   TABLE DATA           [   COPY cars.cars (car_id, car_vin, car_date_release, car_date_gto, carsmodel_id) FROM stdin;
    cars          postgres    false    254   ?;      ?          0    17067 
   carsmodels 
   TABLE DATA           o   COPY cars.carsmodels (carsmodel_id, autobrand_id, autocategory_id, carsmodel_name, semitrailer_id) FROM stdin;
    cars          postgres    false    223   ?;      ?          0    17342    description_semitrailers 
   TABLE DATA           q   COPY cars.description_semitrailers (description_semitrailer_id, description_semitrailer_description) FROM stdin;
    cars          postgres    false    250   ?;      ?          0    17334 	   paletypes 
   TABLE DATA           ]   COPY cars.paletypes (paletype_id, paletype_name, paletype_lenth, paletype_width) FROM stdin;
    cars          postgres    false    248   ?<      ?          0    17361    semitrailers 
   TABLE DATA           ?   COPY cars.semitrailers (semitrailer_id, semitrailer_name, semitrailer_carrying, semitrailer_gabarit_lenth, semitrailer_gabarit_width, semitrailer_gabarit_height, description_semitrailer_id, semitrailer_img) FROM stdin;
    cars          postgres    false    252   6=      ?          0    17072 	   documents 
   TABLE DATA           m   COPY document.documents (document_id, document_postperiod, document_2copycmr, document_original) FROM stdin;
    document          postgres    false    225   c>      ?          0    17077    emploees 
   TABLE DATA           a   COPY emploee.emploees (emploee_id, functionworker_id, autocategory_id, emploee_name) FROM stdin;
    emploee          postgres    false    227   ?>      ?          0    17082    functionworker 
   TABLE DATA           Q   COPY emploee.functionworker (functionworker_id, functionworker_name) FROM stdin;
    emploee          postgres    false    229   ?      ?          0    17095    orders 
   TABLE DATA           ?   COPY orders.orders (order_id, shipper_id, emploee_id, payment_id, route_id, document_id, order_data, order_contractnumber, order_note) FROM stdin;
    orders          postgres    false    233   J?      ?          0    17103    payments 
   TABLE DATA           _   COPY payment.payments (payment_id, payment_cost, payment_period, payment_currency) FROM stdin;
    payment          postgres    false    235   @      ?          0    17302    routes 
   TABLE DATA           E   COPY route.routes (route_id, route_arrival, route_route) FROM stdin;
    route          postgres    false    245   ?@      ?          0    17106    shippers 
   TABLE DATA           =   COPY shipper.shippers (shipper_id, shipper_name) FROM stdin;
    shipper          postgres    false    236   ?@      ?          0    17131    vatnames 
   TABLE DATA           9   COPY vat.vatnames (vatname_id, vatname_name) FROM stdin;
    vat          postgres    false    240   6A      ?          0    17136    vats 
   TABLE DATA           /   COPY vat.vats (vat_id, vat_stavka) FROM stdin;
    vat          postgres    false    242   ?A                 0    0    adress_adres_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('adres.adress_adres_id_seq', 1, false);
          adres          postgres    false    210                       0    0    countrys_country_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('adres.countrys_country_id_seq', 39, true);
          adres          postgres    false    215                       0    0    streets_street_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('adres.streets_street_id_seq', 1, false);
          adres          postgres    false    216                       0    0    сities_city_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('adres."сities_city_id_seq"', 1, false);
          adres          postgres    false    218                       0    0    autobrands_autobrand_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('cars.autobrands_autobrand_id_seq', 1, true);
          cars          postgres    false    220                       0    0 "   autocategories_autocategory_id_seq    SEQUENCE SET     O   SELECT pg_catalog.setval('cars.autocategories_autocategory_id_seq', 16, true);
          cars          postgres    false    222                       0    0    cars_car_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('cars.cars_car_id_seq', 1, false);
          cars          postgres    false    253                       0    0    carsmodels_carsmodel_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('cars.carsmodels_carsmodel_id_seq', 1, false);
          cars          postgres    false    224                       0    0 7   description_semitrailers_description_semitrailer_id_seq    SEQUENCE SET     c   SELECT pg_catalog.setval('cars.description_semitrailers_description_semitrailer_id_seq', 5, true);
          cars          postgres    false    249                       0    0    paletypes_paletype_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('cars.paletypes_paletype_id_seq', 3, true);
          cars          postgres    false    247                       0    0    semitrailers_semitrailer_id_seq    SEQUENCE SET     L   SELECT pg_catalog.setval('cars.semitrailers_semitrailer_id_seq', 12, true);
          cars          postgres    false    251                       0    0    documents_document_id_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('document.documents_document_id_seq', 14, true);
          document          postgres    false    226                       0    0    emploees_emploee_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('emploee.emploees_emploee_id_seq', 2, true);
          emploee          postgres    false    228                       0    0 $   functionworker_functionworker_id_seq    SEQUENCE SET     S   SELECT pg_catalog.setval('emploee.functionworker_functionworker_id_seq', 1, true);
          emploee          postgres    false    231                       0    0    orders_order_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('orders.orders_order_id_seq', 26, true);
          orders          postgres    false    234                       0    0    payments_payment_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('payment.payments_payment_id_seq', 14, true);
          payment          postgres    false    237                        0    0    routes_route_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('route.routes_route_id_seq', 8, true);
          route          postgres    false    244            !           0    0    shippers_shipper_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('shipper.shippers_shipper_id_seq', 2, true);
          shipper          postgres    false    239            "           0    0    vatnames_vatname_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('vat.vatnames_vatname_id_seq', 39, true);
          vat          postgres    false    241            #           0    0    vats_vat_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('vat.vats_vat_id_seq', 34, true);
          vat          postgres    false    243            ?           2606    17159    adress adress_pkey 
   CONSTRAINT     U   ALTER TABLE ONLY adres.adress
    ADD CONSTRAINT adress_pkey PRIMARY KEY (adres_id);
 ;   ALTER TABLE ONLY adres.adress DROP CONSTRAINT adress_pkey;
       adres            postgres    false    209            ?           2606    17161 +   countrys countrys_country_abbreviated_2_key 
   CONSTRAINT     v   ALTER TABLE ONLY adres.countrys
    ADD CONSTRAINT countrys_country_abbreviated_2_key UNIQUE (country_abbreviated_2);
 T   ALTER TABLE ONLY adres.countrys DROP CONSTRAINT countrys_country_abbreviated_2_key;
       adres            postgres    false    211            ?           2606    17163 +   countrys countrys_country_abbreviated_3_key 
   CONSTRAINT     v   ALTER TABLE ONLY adres.countrys
    ADD CONSTRAINT countrys_country_abbreviated_3_key UNIQUE (country_abbreviated_3);
 T   ALTER TABLE ONLY adres.countrys DROP CONSTRAINT countrys_country_abbreviated_3_key;
       adres            postgres    false    211            ?           2606    17165 "   countrys countrys_country_name_key 
   CONSTRAINT     d   ALTER TABLE ONLY adres.countrys
    ADD CONSTRAINT countrys_country_name_key UNIQUE (country_name);
 K   ALTER TABLE ONLY adres.countrys DROP CONSTRAINT countrys_country_name_key;
       adres            postgres    false    211            ?           2606    17167    countrys countrys_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY adres.countrys
    ADD CONSTRAINT countrys_pkey PRIMARY KEY (country_id);
 ?   ALTER TABLE ONLY adres.countrys DROP CONSTRAINT countrys_pkey;
       adres            postgres    false    211            ?           2606    17169    streets streets_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY adres.streets
    ADD CONSTRAINT streets_pkey PRIMARY KEY (street_id);
 =   ALTER TABLE ONLY adres.streets DROP CONSTRAINT streets_pkey;
       adres            postgres    false    212                        2606    17171    streets streets_street_name_key 
   CONSTRAINT     `   ALTER TABLE ONLY adres.streets
    ADD CONSTRAINT streets_street_name_key UNIQUE (street_name);
 H   ALTER TABLE ONLY adres.streets DROP CONSTRAINT streets_street_name_key;
       adres            postgres    false    212                       2606    17173    сities сities_city_name_key 
   CONSTRAINT     `   ALTER TABLE ONLY adres."сities"
    ADD CONSTRAINT "сities_city_name_key" UNIQUE (city_name);
 J   ALTER TABLE ONLY adres."сities" DROP CONSTRAINT "сities_city_name_key";
       adres            postgres    false    213                       2606    17175    сities сities_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY adres."сities"
    ADD CONSTRAINT "сities_pkey" PRIMARY KEY (city_id);
 A   ALTER TABLE ONLY adres."сities" DROP CONSTRAINT "сities_pkey";
       adres            postgres    false    213                       2606    17177 (   autobrands autobrands_autobrand_name_key 
   CONSTRAINT     k   ALTER TABLE ONLY cars.autobrands
    ADD CONSTRAINT autobrands_autobrand_name_key UNIQUE (autobrand_name);
 P   ALTER TABLE ONLY cars.autobrands DROP CONSTRAINT autobrands_autobrand_name_key;
       cars            postgres    false    219                       2606    17179    autobrands autobrands_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY cars.autobrands
    ADD CONSTRAINT autobrands_pkey PRIMARY KEY (autobrand_id);
 B   ALTER TABLE ONLY cars.autobrands DROP CONSTRAINT autobrands_pkey;
       cars            postgres    false    219            
           2606    17181 "   autocategories autocategories_pkey 
   CONSTRAINT     k   ALTER TABLE ONLY cars.autocategories
    ADD CONSTRAINT autocategories_pkey PRIMARY KEY (autocategory_id);
 J   ALTER TABLE ONLY cars.autocategories DROP CONSTRAINT autocategories_pkey;
       cars            postgres    false    221            2           2606    17381    cars cars_car_vin_key 
   CONSTRAINT     Q   ALTER TABLE ONLY cars.cars
    ADD CONSTRAINT cars_car_vin_key UNIQUE (car_vin);
 =   ALTER TABLE ONLY cars.cars DROP CONSTRAINT cars_car_vin_key;
       cars            postgres    false    254            4           2606    17379    cars cars_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY cars.cars
    ADD CONSTRAINT cars_pkey PRIMARY KEY (car_id);
 6   ALTER TABLE ONLY cars.cars DROP CONSTRAINT cars_pkey;
       cars            postgres    false    254                       2606    17183    carsmodels carsmodels_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY cars.carsmodels
    ADD CONSTRAINT carsmodels_pkey PRIMARY KEY (carsmodel_id);
 B   ALTER TABLE ONLY cars.carsmodels DROP CONSTRAINT carsmodels_pkey;
       cars            postgres    false    223            .           2606    17350 6   description_semitrailers description_semitrailers_pkey 
   CONSTRAINT     ?   ALTER TABLE ONLY cars.description_semitrailers
    ADD CONSTRAINT description_semitrailers_pkey PRIMARY KEY (description_semitrailer_id);
 ^   ALTER TABLE ONLY cars.description_semitrailers DROP CONSTRAINT description_semitrailers_pkey;
       cars            postgres    false    250            ,           2606    17339    paletypes paletypes_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY cars.paletypes
    ADD CONSTRAINT paletypes_pkey PRIMARY KEY (paletype_id);
 @   ALTER TABLE ONLY cars.paletypes DROP CONSTRAINT paletypes_pkey;
       cars            postgres    false    248            0           2606    17366    semitrailers semitrailers_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY cars.semitrailers
    ADD CONSTRAINT semitrailers_pkey PRIMARY KEY (semitrailer_id);
 F   ALTER TABLE ONLY cars.semitrailers DROP CONSTRAINT semitrailers_pkey;
       cars            postgres    false    252                       2606    17185    documents documents_pkey 
   CONSTRAINT     a   ALTER TABLE ONLY document.documents
    ADD CONSTRAINT documents_pkey PRIMARY KEY (document_id);
 D   ALTER TABLE ONLY document.documents DROP CONSTRAINT documents_pkey;
       document            postgres    false    225                       2606    17187    emploees emploees_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY emploee.emploees
    ADD CONSTRAINT emploees_pkey PRIMARY KEY (emploee_id);
 A   ALTER TABLE ONLY emploee.emploees DROP CONSTRAINT emploees_pkey;
       emploee            postgres    false    227                       2606    17189 5   functionworker functionworker_functionworker_name_key 
   CONSTRAINT     ?   ALTER TABLE ONLY emploee.functionworker
    ADD CONSTRAINT functionworker_functionworker_name_key UNIQUE (functionworker_name);
 `   ALTER TABLE ONLY emploee.functionworker DROP CONSTRAINT functionworker_functionworker_name_key;
       emploee            postgres    false    229                       2606    17191 "   functionworker functionworker_pkey 
   CONSTRAINT     p   ALTER TABLE ONLY emploee.functionworker
    ADD CONSTRAINT functionworker_pkey PRIMARY KEY (functionworker_id);
 M   ALTER TABLE ONLY emploee.functionworker DROP CONSTRAINT functionworker_pkey;
       emploee            postgres    false    229                       2606    17277 &   orders orders_order_contractnumber_key 
   CONSTRAINT     q   ALTER TABLE ONLY orders.orders
    ADD CONSTRAINT orders_order_contractnumber_key UNIQUE (order_contractnumber);
 P   ALTER TABLE ONLY orders.orders DROP CONSTRAINT orders_order_contractnumber_key;
       orders            postgres    false    233                       2606    17279 '   orders orders_order_contractnumber_key1 
   CONSTRAINT     r   ALTER TABLE ONLY orders.orders
    ADD CONSTRAINT orders_order_contractnumber_key1 UNIQUE (order_contractnumber);
 Q   ALTER TABLE ONLY orders.orders DROP CONSTRAINT orders_order_contractnumber_key1;
       orders            postgres    false    233                       2606    17193    orders orders_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY orders.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (order_id);
 <   ALTER TABLE ONLY orders.orders DROP CONSTRAINT orders_pkey;
       orders            postgres    false    233                       2606    17195    payments payments_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY payment.payments
    ADD CONSTRAINT payments_pkey PRIMARY KEY (payment_id);
 A   ALTER TABLE ONLY payment.payments DROP CONSTRAINT payments_pkey;
       payment            postgres    false    235            *           2606    17307    routes routes_pkey 
   CONSTRAINT     U   ALTER TABLE ONLY route.routes
    ADD CONSTRAINT routes_pkey PRIMARY KEY (route_id);
 ;   ALTER TABLE ONLY route.routes DROP CONSTRAINT routes_pkey;
       route            postgres    false    245                       2606    17199     shippers shippers_shipper_id_key 
   CONSTRAINT     b   ALTER TABLE ONLY shipper.shippers
    ADD CONSTRAINT shippers_shipper_id_key UNIQUE (shipper_id);
 K   ALTER TABLE ONLY shipper.shippers DROP CONSTRAINT shippers_shipper_id_key;
       shipper            postgres    false    236                        2606    17201 "   shippers shippers_shipper_name_key 
   CONSTRAINT     f   ALTER TABLE ONLY shipper.shippers
    ADD CONSTRAINT shippers_shipper_name_key UNIQUE (shipper_name);
 M   ALTER TABLE ONLY shipper.shippers DROP CONSTRAINT shippers_shipper_name_key;
       shipper            postgres    false    236            "           2606    17203    vatnames vatnames_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY vat.vatnames
    ADD CONSTRAINT vatnames_pkey PRIMARY KEY (vatname_id);
 =   ALTER TABLE ONLY vat.vatnames DROP CONSTRAINT vatnames_pkey;
       vat            postgres    false    240            $           2606    17205 "   vatnames vatnames_vatname_name_key 
   CONSTRAINT     b   ALTER TABLE ONLY vat.vatnames
    ADD CONSTRAINT vatnames_vatname_name_key UNIQUE (vatname_name);
 I   ALTER TABLE ONLY vat.vatnames DROP CONSTRAINT vatnames_vatname_name_key;
       vat            postgres    false    240            &           2606    17207    vats vats_pkey 
   CONSTRAINT     M   ALTER TABLE ONLY vat.vats
    ADD CONSTRAINT vats_pkey PRIMARY KEY (vat_id);
 5   ALTER TABLE ONLY vat.vats DROP CONSTRAINT vats_pkey;
       vat            postgres    false    242            (           2606    17209    vats vats_vat_stavka_key 
   CONSTRAINT     V   ALTER TABLE ONLY vat.vats
    ADD CONSTRAINT vats_vat_stavka_key UNIQUE (vat_stavka);
 ?   ALTER TABLE ONLY vat.vats DROP CONSTRAINT vats_vat_stavka_key;
       vat            postgres    false    242            5           2606    17210    adress adress_city_id_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY adres.adress
    ADD CONSTRAINT adress_city_id_fkey FOREIGN KEY (city_id) REFERENCES adres."сities"(city_id) ON DELETE SET NULL;
 C   ALTER TABLE ONLY adres.adress DROP CONSTRAINT adress_city_id_fkey;
       adres          postgres    false    213    209    3076            6           2606    17215    adress adress_street_id_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY adres.adress
    ADD CONSTRAINT adress_street_id_fkey FOREIGN KEY (street_id) REFERENCES adres.streets(street_id) ON DELETE SET NULL;
 E   ALTER TABLE ONLY adres.adress DROP CONSTRAINT adress_street_id_fkey;
       adres          postgres    false    209    3070    212            7           2606    17220    countrys countrys_vat_id_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY adres.countrys
    ADD CONSTRAINT countrys_vat_id_fkey FOREIGN KEY (vat_id) REFERENCES vat.vats(vat_id) ON UPDATE SET NULL ON DELETE SET NULL;
 F   ALTER TABLE ONLY adres.countrys DROP CONSTRAINT countrys_vat_id_fkey;
       adres          postgres    false    242    211    3110            8           2606    17225 !   countrys countrys_vatname_id_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY adres.countrys
    ADD CONSTRAINT countrys_vatname_id_fkey FOREIGN KEY (vatname_id) REFERENCES vat.vatnames(vatname_id) ON UPDATE SET NULL ON DELETE SET NULL;
 J   ALTER TABLE ONLY adres.countrys DROP CONSTRAINT countrys_vatname_id_fkey;
       adres          postgres    false    3106    240    211            9           2606    17230    сities сities_country_id_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY adres."сities"
    ADD CONSTRAINT "сities_country_id_fkey" FOREIGN KEY (country_id) REFERENCES adres.countrys(country_id) ON DELETE RESTRICT;
 L   ALTER TABLE ONLY adres."сities" DROP CONSTRAINT "сities_country_id_fkey";
       adres          postgres    false    213    3068    211            A           2606    17382    cars cars_carsmodel_id_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY cars.cars
    ADD CONSTRAINT cars_carsmodel_id_fkey FOREIGN KEY (carsmodel_id) REFERENCES cars.carsmodels(carsmodel_id) ON UPDATE CASCADE ON DELETE SET NULL;
 C   ALTER TABLE ONLY cars.cars DROP CONSTRAINT cars_carsmodel_id_fkey;
       cars          postgres    false    223    3084    254            :           2606    17235 '   carsmodels carsmodels_autobrand_id_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY cars.carsmodels
    ADD CONSTRAINT carsmodels_autobrand_id_fkey FOREIGN KEY (autobrand_id) REFERENCES cars.autobrands(autobrand_id);
 O   ALTER TABLE ONLY cars.carsmodels DROP CONSTRAINT carsmodels_autobrand_id_fkey;
       cars          postgres    false    219    223    3080            ;           2606    17240 *   carsmodels carsmodels_autocategory_id_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY cars.carsmodels
    ADD CONSTRAINT carsmodels_autocategory_id_fkey FOREIGN KEY (autocategory_id) REFERENCES cars.autocategories(autocategory_id);
 R   ALTER TABLE ONLY cars.carsmodels DROP CONSTRAINT carsmodels_autocategory_id_fkey;
       cars          postgres    false    3082    221    223            <           2606    17245 &   emploees emploees_autocategory_id_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY emploee.emploees
    ADD CONSTRAINT emploees_autocategory_id_fkey FOREIGN KEY (autocategory_id) REFERENCES cars.autocategories(autocategory_id) ON DELETE SET NULL;
 Q   ALTER TABLE ONLY emploee.emploees DROP CONSTRAINT emploees_autocategory_id_fkey;
       emploee          postgres    false    221    227    3082            =           2606    17250 (   emploees emploees_functionworker_id_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY emploee.emploees
    ADD CONSTRAINT emploees_functionworker_id_fkey FOREIGN KEY (functionworker_id) REFERENCES emploee.functionworker(functionworker_id) ON UPDATE CASCADE ON DELETE CASCADE;
 S   ALTER TABLE ONLY emploee.emploees DROP CONSTRAINT emploees_functionworker_id_fkey;
       emploee          postgres    false    227    3092    229            >           2606    17255    orders orders_emploee_id_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY orders.orders
    ADD CONSTRAINT orders_emploee_id_fkey FOREIGN KEY (emploee_id) REFERENCES emploee.emploees(emploee_id);
 G   ALTER TABLE ONLY orders.orders DROP CONSTRAINT orders_emploee_id_fkey;
       orders          postgres    false    233    227    3088            ?           2606    17260    orders orders_payment_id_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY orders.orders
    ADD CONSTRAINT orders_payment_id_fkey FOREIGN KEY (payment_id) REFERENCES payment.payments(payment_id);
 G   ALTER TABLE ONLY orders.orders DROP CONSTRAINT orders_payment_id_fkey;
       orders          postgres    false    233    3100    235            @           2606    17270    orders orders_shipper_id_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY orders.orders
    ADD CONSTRAINT orders_shipper_id_fkey FOREIGN KEY (shipper_id) REFERENCES shipper.shippers(shipper_id);
 G   ALTER TABLE ONLY orders.orders DROP CONSTRAINT orders_shipper_id_fkey;
       orders          postgres    false    3102    233    236            ?      x?????? ? ?      ?   ?  x?U?]o?Vǯ?~T;i^.??@7???hr?Cjű#ǆ?UZB?1v1?Ec?v3?%?T(??p???αæ?uz?{?y?^b?????|?????B^?/?5??7 ???I?_?E?-?I??\?+?1_????(?}?ڶCG"??l??
U?T)???\jЂl?A6U`?V???k???H?}Y8??v????Nep)?#?\???L?U؍6?P?ݙ?x?wjԤ?^?e??M??q???????x%W?>ln޳ ??"???F???? ??_)?"F=ڣH??"	?h?mi?QA"??U?D??@?4N?
E?d??m??~?K{?.?D4????N ????i?v,?86???5k??8??v!?????z8?i???B}??? ? j\)@.?q ?(H?Pe착???ԧ|A???>??~1j?IT?'???|?n???~z?????:s??;#{ y?q?G%? n74?(
??U???5??B??"?????&??̿??a?
mp?v_?%??%???bzg?X??6W???Mȟ????}?6?ô? n,???/????߃Z4??Q|?`Mn??.?U1C?ȡ(N???^?Bf?p?_?b<???m??4?7e5???? ???x⊪??w??4??????!_#??vǃ\B???j?q}??^?????_?ȣ$?n?b??F??750??s?u?4?Q?5k0?e?UƸ3?v?=??<?Q?nr??Ы"???hQfPQ??)??C8ph?9?f?DhW+\-?4?	\??3?Z?u?a&	?@?kE?N?FAW???t]?@=?D?2??(?ިk?E??Ew?*? 7zU??g?<jo9?!??O??R3??_??5?X?0?a??,tX?^?$?1j??f?y???ېEÇ??;??eGa0?t?????[Y????z?&d??~?>??N?4?E?B?/u-r?`X`?i??^????o2/???}3 1O??z_]????c?!      ?      x?????? ? ?      ?      x?????? ? ?      ?   '   x?3??0??֋v\?˙??????W??????? ?V?      ?   +  x??Y?nG>?<E??f?lCr?^?q?)??@Q?xm?M?xE"$?}?!???w?x%????$????ggz?gN?X??T??W_U????gz?C=?{JGJ???z?#*?w?x????n??8?y??G??~???z???/?+?A?!^	?]???9????p??w?C?'?-??-???n??~f?Q?????zIS???.o??J????????֧??)ܘ?IK???I%OIя$nAP?'?N?HFH.?G?,ދ??I?˨ལ??p{?&x%~?????/z ????}1?N\a??x??C???%?,D?XZ4??H?&?8^S,?ξ?<JN2???G*;mqz?????R???????.?.??S?qj???^i9?JL,???L??s'BI?%o	5?8?2????5vЦq??Z?&?^??sr??pNĽl?)<=?Gx?<貂C?r{??vg ycH?hq??v?H?e%'}D ??'???M?w'8?v????!#o J@?+????2 q???0?r?2"}?=?"҇V-?PB/????{`%n?w?EZ??5	p?.?P???[??]?????'?#	?oE?z`???J??!r?8?ã?%?]+?p?v<k?s'J?"|w9?nf-^f|Oʲ?H{HU(?z?y%?????3Ҁ^)!?6f?E???.??/Y"Yyކ8?uYJ????]??ێ?d?????U?I̦-?%?m??P??!"?/?J$?밽???ք}?? ì~????+5?????$}[??ͥ-???97I?????gR?	r??v??> ]m??Ę?误ޡE???%?:M(?<????`?4??%nfK*?e??+n?.??'?1x???{>?|?uJ??/[Ke????C휔-JۊJ?/V??	U[?????Y???d]? ??\"U?J??n?vfՋ? ???}?4?(?????n?^ԜvM/>Dq???^?_???b?+?g?? ?p?[K????
h?BD?2R??<E?c?q?AIˋQ??a%2???????H8?Pj*n??????$????ְ?X????µL?--}?썱?? ????'??7???w??C\?R{K?????'?ܔH?Cݛ?W'?????9????jVx???6-y?ְa^	'?V??J#֠??<y???e?????Gb???Xhe`V	????	???}O?2??k?????N?j=????f???`4??o?
0??,o???^Y??jd????{؊6??????rut3آ??+???Ue?????IP???B??({??+??Kt?IQ??ʅ???oN??J?Ҷ?i???!@[???@??U˜?A?????2????k??J?A?L?J?~2Y???????:K0???`(=?9?P?$C??tz`8?/o?h`MK-3?hZZٿ?)U?????VqYM
?????\??l??yvj?Hu?`2??$N? S??i?T???؇W??Ip?g?n2?+??\ڿ#_S[????[??Iq?P	?~???;<?;????1?????ʇւ??Z??T<3?,@h-d+[e?*x?@?`??`?j???"???"iΙw???	p:۽Z ?i?2?????V*???v?"?_?_?????bz?????˜?T???r?VN?p²w?W	G?Oy?>dr??cZ?S@r??'ʋP)K8û?yڱ????}Y?TAp?????M>q8QU1[??:BR+????f?*????`g+?????qo???u??w??{?????k?h?N?;.?s?HAwO????rɷ?!??&?D`?????Ei?x???!?Z???GA???k??Fc??{???????@??m???p-}      ?      x?????? ? ?      ?      x?????? ? ?      ?   ?   x??PK
?0]7?????6?P???u???4?~???F??
?Q!3??̛???DHQ#C*?Z?5Z4xH?V? G?%??\?z?x*_?=?Y?JD?%IF?JH?VG????&?"???????*?!?_?D?t?'	}??-I?9݌l;}???J"!?'?.=	????2=ո???c?.e?7?_yÌ????	?װ?0_?}??	3c>      ?   S   x?3估?{/6^??wr? 	.#?.칰?bPbׅ?????9/L??	?d߅??^؉??@?+F??? (X2?      ?     x?3??0?¦??]l???7(X)\?sh3??????????????)???".#,??pj? ڌ1?Y??f?f?yaʅm6\?sa??}
p?^??N???P?? >D?)??9?^?T???????f?f%?63?/?5?C_???Û.?
?
o????T?S?9??jșZZ??VZ??ka??]???W???eAj@#?c2'?l?%?A?d???A@ϒF?Y??I???]fhHj?p榦'B?24@q???f?Y??Z???6????=... ?M,I      ?   K   x?3?L??M???4?4?2?4U?????[/?
pY  P?q???!??0???r&?W? ??*      ?   K   x?3?4?4??0???.l???;.6(\???b???????,???`ǅ] a??/?s??qqq ?&?      ?   !   x?3??0?¾[.???ta???{?b???? ???      ?   ?   x?u?;?0?g??@i????p ?*#C???X?0???8	N?*???8>?v?@bM3e?Ɍ??? ?6?? $??F4]H??(DЉ?8?Q? 9??P??f?aٷ$???d?V?:?
\???????~?u?P0??~????['Gm??\???R?{? ?n.?i??V?8?௡?x?O????T      ?      x?3?450?30༰????.v_?|??b???v]??????e?	Tc?if?paP??;?2\朆ͨ`-@A<??Xr?c??eh?i?]?????FpYCLYc??`)NCc?R1z\\\ ??o/      ?   8   x???  ?????	C?u~??cM???V?KI??%?M?u???6I ??      ?   6   x?3??0?bÅ/콰??V5?/l????2??0???P?+F??? ???      ?   ?   x??A
?0D?3???????H(?-$??!xq+??r$?Ճ?3????"?0??oML?{8?!??v???#??RZ??-??PNe$=?t?
<e?V??U?+ָ5ի?'???Z.Q?u???y?i?T???^4
{.?????#?yk+?      ?   ?   x?%??D!B?X?'࿗鿎!y?k ???? k????-P9n???K\?ăN??:,?o3?Y?	??+r27f??Y??O?Pa
??P??*w,?&???Y???w?E?sQ?zn?y??h???)'$ݳ?9ܳ??Z??,G     