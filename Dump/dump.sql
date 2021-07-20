PGDMP                         y            demo_coveyance_db    13.1    13.3 �    m           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            n           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            o           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            p           1262    59001    demo_coveyance_db    DATABASE     n   CREATE DATABASE demo_coveyance_db WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Russian_Russia.1251';
 !   DROP DATABASE demo_coveyance_db;
                postgres    false                        2615    59127    adres    SCHEMA        CREATE SCHEMA adres;
    DROP SCHEMA adres;
                postgres    false                        2615    59342    cars    SCHEMA        CREATE SCHEMA cars;
    DROP SCHEMA cars;
                postgres    false            
            2615    59389    emploee    SCHEMA        CREATE SCHEMA emploee;
    DROP SCHEMA emploee;
                postgres    false            	            2615    59328    shipper    SCHEMA        CREATE SCHEMA shipper;
    DROP SCHEMA shipper;
                postgres    false                        2615    59020    vat    SCHEMA        CREATE SCHEMA vat;
    DROP SCHEMA vat;
                postgres    false            �            1255    59208 #   addcity(character varying, integer) 	   PROCEDURE     �   CREATE PROCEDURE adres.addcity(namecity character varying, idcountry integer)
    LANGUAGE sql
    AS $$
    INSERT INTO adres.сities ( city_name, country_id ) VALUES ( nameCity, idCountry );
$$;
 M   DROP PROCEDURE adres.addcity(namecity character varying, idcountry integer);
       adres          postgres    false    6            �            1255    59211    getcityid(character varying)    FUNCTION     �   CREATE FUNCTION adres.getcityid(ct character varying) RETURNS integer
    LANGUAGE sql
    AS $$ 
    SELECT city_id FROM adres.сities WHERE city_name = ct;
$$;
 5   DROP FUNCTION adres.getcityid(ct character varying);
       adres          postgres    false    6            �            1255    59207    getcountryid(character varying)    FUNCTION     �   CREATE FUNCTION adres.getcountryid(cntr character varying) RETURNS integer
    LANGUAGE sql
    AS $$
    SELECT country_id FROM adres.countrys WHERE country_name = cntr;
$$;
 :   DROP FUNCTION adres.getcountryid(cntr character varying);
       adres          postgres    false    6            �            1255    59212    getstreetid(character varying)    FUNCTION     �  CREATE FUNCTION adres.getstreetid(st character varying) RETURNS integer
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
       adres          postgres    false    6            �            1255    59216 X   insertadress(character varying, character varying, character varying, character varying) 	   PROCEDURE     �  CREATE PROCEDURE adres.insertadress(ct character varying, strt character varying, idx character varying, type_adress character varying)
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
 �   DROP PROCEDURE adres.insertadress(ct character varying, strt character varying, idx character varying, type_adress character varying);
       adres          postgres    false    6            �            1255    59388 E   add_carmodel(character varying, character varying, character varying) 	   PROCEDURE     f  CREATE PROCEDURE cars.add_carmodel(namebrand character varying, symbolcategory character varying, carmodel character varying)
    LANGUAGE sql
    AS $$
	INSERT INTO cars.carsmodels ( autobrand_id, autocategory_id, carsmodel_name )
	    VALUES ( ( SELECT cars.getAutobrand_id(nameBrand) ), ( SELECT cars.getAutocategory_id(symbolCategory) ), carModel );
$$;
 }   DROP PROCEDURE cars.add_carmodel(namebrand character varying, symbolcategory character varying, carmodel character varying);
       cars          postgres    false    5            �            1255    59386 "   getautobrand_id(character varying)    FUNCTION     �   CREATE FUNCTION cars.getautobrand_id(namebrand character varying) RETURNS integer
    LANGUAGE sql
    AS $$
	SELECT autobrand_id FROM cars.autobrands WHERE autobrand_name = nameBrand;
$$;
 A   DROP FUNCTION cars.getautobrand_id(namebrand character varying);
       cars          postgres    false    5            �            1255    59387 %   getautocategory_id(character varying)    FUNCTION     �   CREATE FUNCTION cars.getautocategory_id(symbolcategory character varying) RETURNS integer
    LANGUAGE sql
    AS $$
	SELECT autocategory_id FROM cars.autocategories WHERE autocategory_symbol = symbolCategory;
$$;
 I   DROP FUNCTION cars.getautocategory_id(symbolcategory character varying);
       cars          postgres    false    5            �            1255    59421 /   addemploee(integer, integer, character varying) 	   PROCEDURE     %  CREATE PROCEDURE emploee.addemploee(functionworkerid integer, autocategoryid integer, emploeename character varying)
    LANGUAGE sql
    AS $$
    INSERT INTO emploee.emploees ( functionWorker_id, autocategory_id, emploee_name )
	VALUES ( functionWorkerId, autocategoryId, emploeeName );
$$;
 t   DROP PROCEDURE emploee.addemploee(functionworkerid integer, autocategoryid integer, emploeename character varying);
       emploee          postgres    false    10                        1255    59418 C   addemploee(character varying, character varying, character varying) 	   PROCEDURE     �  CREATE PROCEDURE emploee.addemploee(functionworkername character varying, autocategoryname character varying, emploeename character varying)
    LANGUAGE sql
    AS $$
    INSERT INTO emploee.emploees ( functionWorker_id, autocategory_id, emploee_name )
	VALUES ( ( SELECT emploee.getFunctionWorkerId( functionWorkerName ) ), ( SELECT cars.getAutocategory_id( autocategoryName ) ), emploeeName );
$$;
 �   DROP PROCEDURE emploee.addemploee(functionworkername character varying, autocategoryname character varying, emploeename character varying);
       emploee          postgres    false    10            �            1255    59416 &   getfunctionworkerid(character varying)    FUNCTION     �   CREATE FUNCTION emploee.getfunctionworkerid(functionworkername character varying) RETURNS integer
    LANGUAGE sql
    AS $$
    SELECT functionWorker_id FROM emploee.functionWorker WHERE functionWorker_name = functionWorkerName;
$$;
 Q   DROP FUNCTION emploee.getfunctionworkerid(functionworkername character varying);
       emploee          postgres    false    10            �            1255    59341    addshipper(character varying) 	   PROCEDURE     �   CREATE PROCEDURE shipper.addshipper(nameshipper character varying)
    LANGUAGE sql
    AS $$
    INSERT INTO shipper.shippers ( shipper_name ) VALUES ( nameShipper );
$$;
 B   DROP PROCEDURE shipper.addshipper(nameshipper character varying);
       shipper          postgres    false    9            �            1255    59042    getvatid(numeric)    FUNCTION     �   CREATE FUNCTION vat.getvatid(vat_st numeric) RETURNS integer
    LANGUAGE sql
    AS $$
    SELECT vat_id FROM vat.vats WHERE vat_stavka = vat_st;
$$;
 ,   DROP FUNCTION vat.getvatid(vat_st numeric);
       vat          postgres    false    4            �            1255    59043    getvatnames(character varying)    FUNCTION     �   CREATE FUNCTION vat.getvatnames(nm character varying) RETURNS integer
    LANGUAGE sql
    AS $$
    SELECT vatname_id FROM vat.vatnames WHERE vatname_name = nm;
$$;
 5   DROP FUNCTION vat.getvatnames(nm character varying);
       vat          postgres    false    4            �            1259    59277    adress    TABLE     �  CREATE TABLE adres.adress (
    adres_id integer NOT NULL,
    city_id integer NOT NULL,
    street_id integer NOT NULL,
    adres_index character varying(20),
    adres_type character varying(20) NOT NULL,
    CONSTRAINT adress_adres_type_check CHECK (((adres_type)::text = ANY ((ARRAY['Фактический'::character varying, 'Юридический'::character varying])::text[])))
);
    DROP TABLE adres.adress;
       adres         heap    postgres    false    6            �            1259    59275    adress_adres_id_seq    SEQUENCE     �   CREATE SEQUENCE adres.adress_adres_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE adres.adress_adres_id_seq;
       adres          postgres    false    6    216            q           0    0    adress_adres_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE adres.adress_adres_id_seq OWNED BY adres.adress.adres_id;
          adres          postgres    false    215            �            1259    59130    countrys    TABLE     L  CREATE TABLE adres.countrys (
    country_id integer NOT NULL,
    vat_id integer NOT NULL,
    vatname_id integer NOT NULL,
    country_name character varying(256) NOT NULL,
    country_abbreviated_2 character varying(4) NOT NULL,
    country_abbreviated_3 character varying(4) NOT NULL,
    country_icon character varying(256)
);
    DROP TABLE adres.countrys;
       adres         heap    postgres    false    6            �            1259    59172    streets    TABLE     p   CREATE TABLE adres.streets (
    street_id integer NOT NULL,
    street_name character varying(256) NOT NULL
);
    DROP TABLE adres.streets;
       adres         heap    postgres    false    6            �            1259    59157    сities    TABLE     �   CREATE TABLE adres."сities" (
    city_id integer NOT NULL,
    city_name character varying(256) NOT NULL,
    country_id integer
);
    DROP TABLE adres."сities";
       adres         heap    postgres    false    6            �            1259    59307 
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
       adres          postgres    false    216    216    216    216    216    214    214    212    212    212    210    210    210    6            �            1259    59128    countrys_country_id_seq    SEQUENCE     �   CREATE SEQUENCE adres.countrys_country_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE adres.countrys_country_id_seq;
       adres          postgres    false    6    210            r           0    0    countrys_country_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE adres.countrys_country_id_seq OWNED BY adres.countrys.country_id;
          adres          postgres    false    209            �            1259    59170    streets_street_id_seq    SEQUENCE     �   CREATE SEQUENCE adres.streets_street_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE adres.streets_street_id_seq;
       adres          postgres    false    6    214            s           0    0    streets_street_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE adres.streets_street_id_seq OWNED BY adres.streets.street_id;
          adres          postgres    false    213            �            1259    59312    testadressview    MATERIALIZED VIEW     m  CREATE MATERIALIZED VIEW adres.testadressview AS
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
       adres         heap    postgres    false    210    210    210    212    212    212    214    214    216    216    216    216    216    6            �            1259    59155    сities_city_id_seq    SEQUENCE     �   CREATE SEQUENCE adres."сities_city_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE adres."сities_city_id_seq";
       adres          postgres    false    212    6            t           0    0    сities_city_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE adres."сities_city_id_seq" OWNED BY adres."сities".city_id;
          adres          postgres    false    211            �            1259    59345 
   autobrands    TABLE     �   CREATE TABLE cars.autobrands (
    autobrand_id integer NOT NULL,
    autobrand_name character varying(256) NOT NULL,
    autobrand_icon character varying(256) DEFAULT 'no_icon.png'::character varying
);
    DROP TABLE cars.autobrands;
       cars         heap    postgres    false    5            �            1259    59343    autobrands_autobrand_id_seq    SEQUENCE     �   CREATE SEQUENCE cars.autobrands_autobrand_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE cars.autobrands_autobrand_id_seq;
       cars          postgres    false    223    5            u           0    0    autobrands_autobrand_id_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE cars.autobrands_autobrand_id_seq OWNED BY cars.autobrands.autobrand_id;
          cars          postgres    false    222            �            1259    59359    autocategories    TABLE     	  CREATE TABLE cars.autocategories (
    autocategory_id integer NOT NULL,
    autocategory_name character varying(256) NOT NULL,
    autocategory_symbol character varying(5) NOT NULL,
    autocategory_icon character varying(64),
    autocategory_description text
);
     DROP TABLE cars.autocategories;
       cars         heap    postgres    false    5            �            1259    59357 "   autocategories_autocategory_id_seq    SEQUENCE     �   CREATE SEQUENCE cars.autocategories_autocategory_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 7   DROP SEQUENCE cars.autocategories_autocategory_id_seq;
       cars          postgres    false    225    5            v           0    0 "   autocategories_autocategory_id_seq    SEQUENCE OWNED BY     e   ALTER SEQUENCE cars.autocategories_autocategory_id_seq OWNED BY cars.autocategories.autocategory_id;
          cars          postgres    false    224            �            1259    59370 
   carsmodels    TABLE     �   CREATE TABLE cars.carsmodels (
    carsmodel_id integer NOT NULL,
    autobrand_id integer NOT NULL,
    autocategory_id integer NOT NULL,
    carsmodel_name character varying(200)
);
    DROP TABLE cars.carsmodels;
       cars         heap    postgres    false    5            �            1259    59368    carsmodels_carsmodel_id_seq    SEQUENCE     �   CREATE SEQUENCE cars.carsmodels_carsmodel_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE cars.carsmodels_carsmodel_id_seq;
       cars          postgres    false    227    5            w           0    0    carsmodels_carsmodel_id_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE cars.carsmodels_carsmodel_id_seq OWNED BY cars.carsmodels.carsmodel_id;
          cars          postgres    false    226            �            1259    59400    emploees    TABLE     �   CREATE TABLE emploee.emploees (
    emploee_id integer NOT NULL,
    functionworker_id integer NOT NULL,
    autocategory_id integer,
    emploee_name character varying(200)
);
    DROP TABLE emploee.emploees;
       emploee         heap    postgres    false    10            �            1259    59398    emploees_emploee_id_seq    SEQUENCE     �   CREATE SEQUENCE emploee.emploees_emploee_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE emploee.emploees_emploee_id_seq;
       emploee          postgres    false    10    231            x           0    0    emploees_emploee_id_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE emploee.emploees_emploee_id_seq OWNED BY emploee.emploees.emploee_id;
          emploee          postgres    false    230            �            1259    59392    functionworker    TABLE     �   CREATE TABLE emploee.functionworker (
    functionworker_id integer NOT NULL,
    functionworker_name character varying(128)
);
 #   DROP TABLE emploee.functionworker;
       emploee         heap    postgres    false    10            �            1259    59390 $   functionworker_functionworker_id_seq    SEQUENCE     �   CREATE SEQUENCE emploee.functionworker_functionworker_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 <   DROP SEQUENCE emploee.functionworker_functionworker_id_seq;
       emploee          postgres    false    229    10            y           0    0 $   functionworker_functionworker_id_seq    SEQUENCE OWNED BY     o   ALTER SEQUENCE emploee.functionworker_functionworker_id_seq OWNED BY emploee.functionworker.functionworker_id;
          emploee          postgres    false    228            �            1259    59320    testadressview    MATERIALIZED VIEW     n  CREATE MATERIALIZED VIEW public.testadressview AS
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
       public         heap    postgres    false    216    210    210    212    212    212    214    214    216    216    216    216    210            �            1259    59333    shippers    TABLE     u   CREATE TABLE shipper.shippers (
    shipper_id integer NOT NULL,
    shipper_name character varying(200) NOT NULL
);
    DROP TABLE shipper.shippers;
       shipper         heap    postgres    false    9            �            1259    59331    shippers_shipper_id_seq    SEQUENCE     �   CREATE SEQUENCE shipper.shippers_shipper_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE shipper.shippers_shipper_id_seq;
       shipper          postgres    false    221    9            z           0    0    shippers_shipper_id_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE shipper.shippers_shipper_id_seq OWNED BY shipper.shippers.shipper_id;
          shipper          postgres    false    220            �            1259    59034    vatnames    TABLE     g   CREATE TABLE vat.vatnames (
    vatname_id integer NOT NULL,
    vatname_name character varying(10)
);
    DROP TABLE vat.vatnames;
       vat         heap    postgres    false    4            �            1259    59032    vatnames_vatname_id_seq    SEQUENCE     �   CREATE SEQUENCE vat.vatnames_vatname_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE vat.vatnames_vatname_id_seq;
       vat          postgres    false    4    208            {           0    0    vatnames_vatname_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE vat.vatnames_vatname_id_seq OWNED BY vat.vatnames.vatname_id;
          vat          postgres    false    207            �            1259    59023    vats    TABLE     �   CREATE TABLE vat.vats (
    vat_id integer NOT NULL,
    vat_stavka numeric(4,2) NOT NULL,
    CONSTRAINT vats_valid CHECK (((vat_stavka > (0)::numeric) AND (vat_stavka < (100)::numeric)))
);
    DROP TABLE vat.vats;
       vat         heap    postgres    false    4            �            1259    59021    vats_vat_id_seq    SEQUENCE     �   CREATE SEQUENCE vat.vats_vat_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE vat.vats_vat_id_seq;
       vat          postgres    false    206    4            |           0    0    vats_vat_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE vat.vats_vat_id_seq OWNED BY vat.vats.vat_id;
          vat          postgres    false    205            �           2604    59280    adress adres_id    DEFAULT     p   ALTER TABLE ONLY adres.adress ALTER COLUMN adres_id SET DEFAULT nextval('adres.adress_adres_id_seq'::regclass);
 =   ALTER TABLE adres.adress ALTER COLUMN adres_id DROP DEFAULT;
       adres          postgres    false    216    215    216            �           2604    59133    countrys country_id    DEFAULT     x   ALTER TABLE ONLY adres.countrys ALTER COLUMN country_id SET DEFAULT nextval('adres.countrys_country_id_seq'::regclass);
 A   ALTER TABLE adres.countrys ALTER COLUMN country_id DROP DEFAULT;
       adres          postgres    false    210    209    210            �           2604    59175    streets street_id    DEFAULT     t   ALTER TABLE ONLY adres.streets ALTER COLUMN street_id SET DEFAULT nextval('adres.streets_street_id_seq'::regclass);
 ?   ALTER TABLE adres.streets ALTER COLUMN street_id DROP DEFAULT;
       adres          postgres    false    214    213    214            �           2604    59160    сities city_id    DEFAULT     t   ALTER TABLE ONLY adres."сities" ALTER COLUMN city_id SET DEFAULT nextval('adres."сities_city_id_seq"'::regclass);
 ?   ALTER TABLE adres."сities" ALTER COLUMN city_id DROP DEFAULT;
       adres          postgres    false    212    211    212            �           2604    59348    autobrands autobrand_id    DEFAULT     ~   ALTER TABLE ONLY cars.autobrands ALTER COLUMN autobrand_id SET DEFAULT nextval('cars.autobrands_autobrand_id_seq'::regclass);
 D   ALTER TABLE cars.autobrands ALTER COLUMN autobrand_id DROP DEFAULT;
       cars          postgres    false    223    222    223            �           2604    59362    autocategories autocategory_id    DEFAULT     �   ALTER TABLE ONLY cars.autocategories ALTER COLUMN autocategory_id SET DEFAULT nextval('cars.autocategories_autocategory_id_seq'::regclass);
 K   ALTER TABLE cars.autocategories ALTER COLUMN autocategory_id DROP DEFAULT;
       cars          postgres    false    225    224    225            �           2604    59373    carsmodels carsmodel_id    DEFAULT     ~   ALTER TABLE ONLY cars.carsmodels ALTER COLUMN carsmodel_id SET DEFAULT nextval('cars.carsmodels_carsmodel_id_seq'::regclass);
 D   ALTER TABLE cars.carsmodels ALTER COLUMN carsmodel_id DROP DEFAULT;
       cars          postgres    false    226    227    227            �           2604    59403    emploees emploee_id    DEFAULT     |   ALTER TABLE ONLY emploee.emploees ALTER COLUMN emploee_id SET DEFAULT nextval('emploee.emploees_emploee_id_seq'::regclass);
 C   ALTER TABLE emploee.emploees ALTER COLUMN emploee_id DROP DEFAULT;
       emploee          postgres    false    231    230    231            �           2604    59395     functionworker functionworker_id    DEFAULT     �   ALTER TABLE ONLY emploee.functionworker ALTER COLUMN functionworker_id SET DEFAULT nextval('emploee.functionworker_functionworker_id_seq'::regclass);
 P   ALTER TABLE emploee.functionworker ALTER COLUMN functionworker_id DROP DEFAULT;
       emploee          postgres    false    228    229    229            �           2604    59336    shippers shipper_id    DEFAULT     |   ALTER TABLE ONLY shipper.shippers ALTER COLUMN shipper_id SET DEFAULT nextval('shipper.shippers_shipper_id_seq'::regclass);
 C   ALTER TABLE shipper.shippers ALTER COLUMN shipper_id DROP DEFAULT;
       shipper          postgres    false    220    221    221            �           2604    59037    vatnames vatname_id    DEFAULT     t   ALTER TABLE ONLY vat.vatnames ALTER COLUMN vatname_id SET DEFAULT nextval('vat.vatnames_vatname_id_seq'::regclass);
 ?   ALTER TABLE vat.vatnames ALTER COLUMN vatname_id DROP DEFAULT;
       vat          postgres    false    208    207    208            �           2604    59026    vats vat_id    DEFAULT     d   ALTER TABLE ONLY vat.vats ALTER COLUMN vat_id SET DEFAULT nextval('vat.vats_vat_id_seq'::regclass);
 7   ALTER TABLE vat.vats ALTER COLUMN vat_id DROP DEFAULT;
       vat          postgres    false    205    206    206            \          0    59277    adress 
   TABLE DATA           V   COPY adres.adress (adres_id, city_id, street_id, adres_index, adres_type) FROM stdin;
    adres          postgres    false    216   ��       V          0    59130    countrys 
   TABLE DATA           �   COPY adres.countrys (country_id, vat_id, vatname_id, country_name, country_abbreviated_2, country_abbreviated_3, country_icon) FROM stdin;
    adres          postgres    false    210   ��       Z          0    59172    streets 
   TABLE DATA           8   COPY adres.streets (street_id, street_name) FROM stdin;
    adres          postgres    false    214   ư       X          0    59157    сities 
   TABLE DATA           B   COPY adres."сities" (city_id, city_name, country_id) FROM stdin;
    adres          postgres    false    212   �       b          0    59345 
   autobrands 
   TABLE DATA           P   COPY cars.autobrands (autobrand_id, autobrand_name, autobrand_icon) FROM stdin;
    cars          postgres    false    223   �       d          0    59359    autocategories 
   TABLE DATA           �   COPY cars.autocategories (autocategory_id, autocategory_name, autocategory_symbol, autocategory_icon, autocategory_description) FROM stdin;
    cars          postgres    false    225   3�       f          0    59370 
   carsmodels 
   TABLE DATA           _   COPY cars.carsmodels (carsmodel_id, autobrand_id, autocategory_id, carsmodel_name) FROM stdin;
    cars          postgres    false    227   l�       j          0    59400    emploees 
   TABLE DATA           a   COPY emploee.emploees (emploee_id, functionworker_id, autocategory_id, emploee_name) FROM stdin;
    emploee          postgres    false    231   ��       h          0    59392    functionworker 
   TABLE DATA           Q   COPY emploee.functionworker (functionworker_id, functionworker_name) FROM stdin;
    emploee          postgres    false    229   ��       `          0    59333    shippers 
   TABLE DATA           =   COPY shipper.shippers (shipper_id, shipper_name) FROM stdin;
    shipper          postgres    false    221   ڸ       T          0    59034    vatnames 
   TABLE DATA           9   COPY vat.vatnames (vatname_id, vatname_name) FROM stdin;
    vat          postgres    false    208   �       R          0    59023    vats 
   TABLE DATA           /   COPY vat.vats (vat_id, vat_stavka) FROM stdin;
    vat          postgres    false    206   ��       }           0    0    adress_adres_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('adres.adress_adres_id_seq', 2, true);
          adres          postgres    false    215            ~           0    0    countrys_country_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('adres.countrys_country_id_seq', 39, true);
          adres          postgres    false    209                       0    0    streets_street_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('adres.streets_street_id_seq', 12, true);
          adres          postgres    false    213            �           0    0    сities_city_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('adres."сities_city_id_seq"', 1, true);
          adres          postgres    false    211            �           0    0    autobrands_autobrand_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('cars.autobrands_autobrand_id_seq', 1, false);
          cars          postgres    false    222            �           0    0 "   autocategories_autocategory_id_seq    SEQUENCE SET     O   SELECT pg_catalog.setval('cars.autocategories_autocategory_id_seq', 16, true);
          cars          postgres    false    224            �           0    0    carsmodels_carsmodel_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('cars.carsmodels_carsmodel_id_seq', 1, false);
          cars          postgres    false    226            �           0    0    emploees_emploee_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('emploee.emploees_emploee_id_seq', 2, true);
          emploee          postgres    false    230            �           0    0 $   functionworker_functionworker_id_seq    SEQUENCE SET     S   SELECT pg_catalog.setval('emploee.functionworker_functionworker_id_seq', 1, true);
          emploee          postgres    false    228            �           0    0    shippers_shipper_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('shipper.shippers_shipper_id_seq', 20, true);
          shipper          postgres    false    220            �           0    0    vatnames_vatname_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('vat.vatnames_vatname_id_seq', 39, true);
          vat          postgres    false    207            �           0    0    vats_vat_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('vat.vats_vat_id_seq', 34, true);
          vat          postgres    false    205            �           2606    59283    adress adress_pkey 
   CONSTRAINT     U   ALTER TABLE ONLY adres.adress
    ADD CONSTRAINT adress_pkey PRIMARY KEY (adres_id);
 ;   ALTER TABLE ONLY adres.adress DROP CONSTRAINT adress_pkey;
       adres            postgres    false    216            �           2606    59142 +   countrys countrys_country_abbreviated_2_key 
   CONSTRAINT     v   ALTER TABLE ONLY adres.countrys
    ADD CONSTRAINT countrys_country_abbreviated_2_key UNIQUE (country_abbreviated_2);
 T   ALTER TABLE ONLY adres.countrys DROP CONSTRAINT countrys_country_abbreviated_2_key;
       adres            postgres    false    210            �           2606    59144 +   countrys countrys_country_abbreviated_3_key 
   CONSTRAINT     v   ALTER TABLE ONLY adres.countrys
    ADD CONSTRAINT countrys_country_abbreviated_3_key UNIQUE (country_abbreviated_3);
 T   ALTER TABLE ONLY adres.countrys DROP CONSTRAINT countrys_country_abbreviated_3_key;
       adres            postgres    false    210            �           2606    59140 "   countrys countrys_country_name_key 
   CONSTRAINT     d   ALTER TABLE ONLY adres.countrys
    ADD CONSTRAINT countrys_country_name_key UNIQUE (country_name);
 K   ALTER TABLE ONLY adres.countrys DROP CONSTRAINT countrys_country_name_key;
       adres            postgres    false    210            �           2606    59138    countrys countrys_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY adres.countrys
    ADD CONSTRAINT countrys_pkey PRIMARY KEY (country_id);
 ?   ALTER TABLE ONLY adres.countrys DROP CONSTRAINT countrys_pkey;
       adres            postgres    false    210            �           2606    59177    streets streets_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY adres.streets
    ADD CONSTRAINT streets_pkey PRIMARY KEY (street_id);
 =   ALTER TABLE ONLY adres.streets DROP CONSTRAINT streets_pkey;
       adres            postgres    false    214            �           2606    59179    streets streets_street_name_key 
   CONSTRAINT     `   ALTER TABLE ONLY adres.streets
    ADD CONSTRAINT streets_street_name_key UNIQUE (street_name);
 H   ALTER TABLE ONLY adres.streets DROP CONSTRAINT streets_street_name_key;
       adres            postgres    false    214            �           2606    59164    сities сities_city_name_key 
   CONSTRAINT     `   ALTER TABLE ONLY adres."сities"
    ADD CONSTRAINT "сities_city_name_key" UNIQUE (city_name);
 J   ALTER TABLE ONLY adres."сities" DROP CONSTRAINT "сities_city_name_key";
       adres            postgres    false    212            �           2606    59162    сities сities_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY adres."сities"
    ADD CONSTRAINT "сities_pkey" PRIMARY KEY (city_id);
 A   ALTER TABLE ONLY adres."сities" DROP CONSTRAINT "сities_pkey";
       adres            postgres    false    212            �           2606    59356 (   autobrands autobrands_autobrand_name_key 
   CONSTRAINT     k   ALTER TABLE ONLY cars.autobrands
    ADD CONSTRAINT autobrands_autobrand_name_key UNIQUE (autobrand_name);
 P   ALTER TABLE ONLY cars.autobrands DROP CONSTRAINT autobrands_autobrand_name_key;
       cars            postgres    false    223            �           2606    59354    autobrands autobrands_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY cars.autobrands
    ADD CONSTRAINT autobrands_pkey PRIMARY KEY (autobrand_id);
 B   ALTER TABLE ONLY cars.autobrands DROP CONSTRAINT autobrands_pkey;
       cars            postgres    false    223            �           2606    59367 "   autocategories autocategories_pkey 
   CONSTRAINT     k   ALTER TABLE ONLY cars.autocategories
    ADD CONSTRAINT autocategories_pkey PRIMARY KEY (autocategory_id);
 J   ALTER TABLE ONLY cars.autocategories DROP CONSTRAINT autocategories_pkey;
       cars            postgres    false    225            �           2606    59375    carsmodels carsmodels_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY cars.carsmodels
    ADD CONSTRAINT carsmodels_pkey PRIMARY KEY (carsmodel_id);
 B   ALTER TABLE ONLY cars.carsmodels DROP CONSTRAINT carsmodels_pkey;
       cars            postgres    false    227            �           2606    59405    emploees emploees_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY emploee.emploees
    ADD CONSTRAINT emploees_pkey PRIMARY KEY (emploee_id);
 A   ALTER TABLE ONLY emploee.emploees DROP CONSTRAINT emploees_pkey;
       emploee            postgres    false    231            �           2606    59420 5   functionworker functionworker_functionworker_name_key 
   CONSTRAINT     �   ALTER TABLE ONLY emploee.functionworker
    ADD CONSTRAINT functionworker_functionworker_name_key UNIQUE (functionworker_name);
 `   ALTER TABLE ONLY emploee.functionworker DROP CONSTRAINT functionworker_functionworker_name_key;
       emploee            postgres    false    229            �           2606    59397 "   functionworker functionworker_pkey 
   CONSTRAINT     p   ALTER TABLE ONLY emploee.functionworker
    ADD CONSTRAINT functionworker_pkey PRIMARY KEY (functionworker_id);
 M   ALTER TABLE ONLY emploee.functionworker DROP CONSTRAINT functionworker_pkey;
       emploee            postgres    false    229            �           2606    59338     shippers shippers_shipper_id_key 
   CONSTRAINT     b   ALTER TABLE ONLY shipper.shippers
    ADD CONSTRAINT shippers_shipper_id_key UNIQUE (shipper_id);
 K   ALTER TABLE ONLY shipper.shippers DROP CONSTRAINT shippers_shipper_id_key;
       shipper            postgres    false    221            �           2606    59340 "   shippers shippers_shipper_name_key 
   CONSTRAINT     f   ALTER TABLE ONLY shipper.shippers
    ADD CONSTRAINT shippers_shipper_name_key UNIQUE (shipper_name);
 M   ALTER TABLE ONLY shipper.shippers DROP CONSTRAINT shippers_shipper_name_key;
       shipper            postgres    false    221            �           2606    59039    vatnames vatnames_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY vat.vatnames
    ADD CONSTRAINT vatnames_pkey PRIMARY KEY (vatname_id);
 =   ALTER TABLE ONLY vat.vatnames DROP CONSTRAINT vatnames_pkey;
       vat            postgres    false    208            �           2606    59041 "   vatnames vatnames_vatname_name_key 
   CONSTRAINT     b   ALTER TABLE ONLY vat.vatnames
    ADD CONSTRAINT vatnames_vatname_name_key UNIQUE (vatname_name);
 I   ALTER TABLE ONLY vat.vatnames DROP CONSTRAINT vatnames_vatname_name_key;
       vat            postgres    false    208            �           2606    59029    vats vats_pkey 
   CONSTRAINT     M   ALTER TABLE ONLY vat.vats
    ADD CONSTRAINT vats_pkey PRIMARY KEY (vat_id);
 5   ALTER TABLE ONLY vat.vats DROP CONSTRAINT vats_pkey;
       vat            postgres    false    206            �           2606    59031    vats vats_vat_stavka_key 
   CONSTRAINT     V   ALTER TABLE ONLY vat.vats
    ADD CONSTRAINT vats_vat_stavka_key UNIQUE (vat_stavka);
 ?   ALTER TABLE ONLY vat.vats DROP CONSTRAINT vats_vat_stavka_key;
       vat            postgres    false    206            �           2606    59284    adress adress_city_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY adres.adress
    ADD CONSTRAINT adress_city_id_fkey FOREIGN KEY (city_id) REFERENCES adres."сities"(city_id) ON DELETE SET NULL;
 C   ALTER TABLE ONLY adres.adress DROP CONSTRAINT adress_city_id_fkey;
       adres          postgres    false    216    212    2986            �           2606    59289    adress adress_street_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY adres.adress
    ADD CONSTRAINT adress_street_id_fkey FOREIGN KEY (street_id) REFERENCES adres.streets(street_id) ON DELETE SET NULL;
 E   ALTER TABLE ONLY adres.adress DROP CONSTRAINT adress_street_id_fkey;
       adres          postgres    false    2988    216    214            �           2606    59145    countrys countrys_vat_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY adres.countrys
    ADD CONSTRAINT countrys_vat_id_fkey FOREIGN KEY (vat_id) REFERENCES vat.vats(vat_id) ON UPDATE SET NULL ON DELETE SET NULL;
 F   ALTER TABLE ONLY adres.countrys DROP CONSTRAINT countrys_vat_id_fkey;
       adres          postgres    false    2968    210    206            �           2606    59150 !   countrys countrys_vatname_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY adres.countrys
    ADD CONSTRAINT countrys_vatname_id_fkey FOREIGN KEY (vatname_id) REFERENCES vat.vatnames(vatname_id) ON UPDATE SET NULL ON DELETE SET NULL;
 J   ALTER TABLE ONLY adres.countrys DROP CONSTRAINT countrys_vatname_id_fkey;
       adres          postgres    false    208    210    2972            �           2606    59165    сities сities_country_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY adres."сities"
    ADD CONSTRAINT "сities_country_id_fkey" FOREIGN KEY (country_id) REFERENCES adres.countrys(country_id) ON DELETE RESTRICT;
 L   ALTER TABLE ONLY adres."сities" DROP CONSTRAINT "сities_country_id_fkey";
       adres          postgres    false    212    210    2982            �           2606    59376 '   carsmodels carsmodels_autobrand_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY cars.carsmodels
    ADD CONSTRAINT carsmodels_autobrand_id_fkey FOREIGN KEY (autobrand_id) REFERENCES cars.autobrands(autobrand_id);
 O   ALTER TABLE ONLY cars.carsmodels DROP CONSTRAINT carsmodels_autobrand_id_fkey;
       cars          postgres    false    227    223    3000            �           2606    59381 *   carsmodels carsmodels_autocategory_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY cars.carsmodels
    ADD CONSTRAINT carsmodels_autocategory_id_fkey FOREIGN KEY (autocategory_id) REFERENCES cars.autocategories(autocategory_id);
 R   ALTER TABLE ONLY cars.carsmodels DROP CONSTRAINT carsmodels_autocategory_id_fkey;
       cars          postgres    false    225    3002    227            �           2606    59411 &   emploees emploees_autocategory_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY emploee.emploees
    ADD CONSTRAINT emploees_autocategory_id_fkey FOREIGN KEY (autocategory_id) REFERENCES cars.autocategories(autocategory_id) ON DELETE SET NULL;
 Q   ALTER TABLE ONLY emploee.emploees DROP CONSTRAINT emploees_autocategory_id_fkey;
       emploee          postgres    false    3002    225    231            �           2606    59406 (   emploees emploees_functionworker_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY emploee.emploees
    ADD CONSTRAINT emploees_functionworker_id_fkey FOREIGN KEY (functionworker_id) REFERENCES emploee.functionworker(functionworker_id) ON UPDATE CASCADE ON DELETE CASCADE;
 S   ALTER TABLE ONLY emploee.emploees DROP CONSTRAINT emploees_functionworker_id_fkey;
       emploee          postgres    false    3008    229    231            ]           0    59312    testadressview    MATERIALIZED VIEW DATA     0   REFRESH MATERIALIZED VIEW adres.testadressview;
          adres          postgres    false    218    3180            ^           0    59320    testadressview    MATERIALIZED VIEW DATA     1   REFRESH MATERIALIZED VIEW public.testadressview;
          public          postgres    false    219    3180            \   9   x�3�4�4"#c�K.l���bӅ�/l��xaׅvr�T 	C##\Jb���� i$1      V   �  x�U�]o�Vǯ�~T;i^.��@7��hr�Cjű#ǆ�UZB�1v1�Ec�v3�%�T(��p���αæ�uz�{�y�^b��?��|����B^�/�5��7 ?��I�_�E�-�I�\�+�1_���(�}�ڶCG"��l��
U�T)���\jЂl�A6U`�V���k��H�}Y8��v���Nep)�#�\��L�U؍6�P�ݙ�x�wjԤ�^�e��M��q������x%W�>ln޳ ��"���F���� ��_)�"F=ڣH��"	�h�mi�QA"��U�D��@�4N�
E�d��m��~�K{�.�D4����N ����i�v,�86���5k��8��v!�����z8�i���B}��� � j\)@.�q �(H�Pe착���ԧ|A���>��~1j�IT�'���|�n���~z�����:s��;#{ y�q�G%� n74�(
�?U���5��B��"�����&��̿��a�
mp�v_�%��%���bzg�X��6W���Mȟ��?�}�6�ô� n,���/����߃Z4��Q|�`Mn��.�U1C�ȡ(N���^�Bf�p�_�b<���m��4�7e5���� ��x⊪��w��4������!_#��vǃ\B���j�q}��^�����_�ȣ$�n�b��F��750�s�u�4�Q�5k0�e�UƸ3�v�=��<�Q�nr��Ы"���hQfPQ��)�C8ph�9�f�DhW+\-�4�	\��3�Z�u�a&	�@�kE�N�FAW���t]�@=�D�2��(�ިk�E��Ew?*� 7zU��g�<jo9�!��O��R3��_��5�X�0�a��,tX�^�$�1j��f�y���ېEÇ��;��eGa0�t�����[Y����z�&d��~�>��N�4�E�B�/u-r�`X`�i��^����o2/���}3 1O�z_]����c�!      Z      x�34�I-.�24ӆ\1z\\\ ?      X      x�3�I-.�4����� ��      b      x������ � �      d   )  x��Y�r�F>KO1�A�F��'9�^�q�)��B��x��Y�T�	e.R�Z�+,�oO0z�<I����4iH���QO�|�uOo��z�:ң��t����|��:֑��z�G�:N���XO����{���{O���d���y�@�J��J��)���!$����q��+=-m9i�2�y������G��� �rf��'=�(��T��#�0y�c耍��S��pc����'�>%5?��%Aɀe7(D""��$9�g�~r��&��_�%ם|�ۓ�&�%��̏�ҿ�!d�N�*�;mP��/������c�czĪТ��0`�B�,�ű�a�w$�q�n��'}Ҹє���"v�WJ`��+K(ʁ2O�B�@9��fƷO�N�w��}�2��p�sA�D&�4���%gX&p3�1��ʴ�[��%�I���k����8��I?�x//��6z�ވ�Ep��6O y_�Lq�{v�X�e%�zL�❧���M����s��"�#�#��Pt�>W�"�1c(�F�1�r|r���6��s�ʝ�1���x��V��[��iU����
_rzaV���u#�Cq~�D4$q�[:i�0@�A�xx��U���cǳ��;Uba�ǹPt3kq��<1'�>#�!=Ra���	��@��wr�Iz�(ژI.q(�`�d�d}�mz��U)�
��V�o�B�UO��ow֥1�v�̲=�C�'F�ā)�w@{���)�0�@(�U�2Gn�*F+��1I�ֵ�͟b�g��0�R���gR	o��?��R>$Mm��D����[�E�.�+=+�m4���Ԇ�ӆYf�%bfC��U�(�.����3j����:�z�7F��G�m����;]�P�&������ ���e9:8�b*�H����,$R�%wHe!gR#�W�W�y�b�1crݤ��xKrb��'�Y���=�r�P�c8���~��m�
{���{ei�g�J�L{��T9j����v�dԵn7(Yy1���ğ�F��ұ�S>M�9�q�����w[�Kx�۸V��U����!��4�D��~����ƙq��q�촿;9)�A�m��(��9��N�{��9�G5/��my[�|@�2�z�֪}P��j�n]֟��3�-�+6���cj!��Y�9�l@S��}O�
.}W+������^��7��Wm�h�~_��*���W�|��v^YQ��\���˷�5�v�?paf�ҹn�����Y���Lsl�4tegC�EfT�s��w+��i%��Ʌ��do�I�3�Z���o�$qkt��Rn�s����e�����>�6
6�t9���u�$σ0�'���=x,��~����z���)0����Lǒ�z:)p��s?W��E����V�D�+�����B{����(�BwxO""�p=N�����ᐃԓȐ���5q�L�:��S�O��^��&�1jz�X�t�s��kr3u��cI��*� �ώp�?x��˃�C�u~� �k���z6-I�!�U�E��.�΂��R��U�rJW�S	�~�6�������XZq�i��f��m��@mڬ�gn�q������ݰ������Kh�YA�3�s:{�#�j7:[�p(���X8eٻ숫����b�1�R�1+��)�rΓ�e�T%��]��"���o��X��i�����b�p��Ja����o�Nq���e�8Qi����]HSk7�<m�T�}���5��N����4R��]7����Z*N���`!%��F�]m�õ�����#=�3PV }�+�D���M<�(�u���B�ќ1���ke��}���������      f      x������ � �      j      x�3�4�4�t,.�2���b���� HUT      h      x�3�,�/�6����� �      `   /   x�3�))I-.�24���́L���g���,(H-����� k�'      T   �   x��A
�0D�3���?���H(�-$��!xq+�r$�Ճ�3���"�0��oML�{8�!��v��#��RZ��-��PNe$=�t�
<e�V��U�+ָ5ի�'��Z.Q�u���y�i�T�^4
{.����#�yk+�      R   �   x�%��D!B�X�'࿗鿎!y�k ���� k����-P9n���K\�ăN��:,�o3�Y�	��+r27f��Y��O�Pa
��P�*w,�&���Y���w�E�sQ�zn�y��h���)'$ݳ�9ܳ��Z��,G     