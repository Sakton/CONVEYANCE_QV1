PGDMP     ;                    y            demo_coveyance_db    13.1    13.3 �    q           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            r           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            s           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            t           1262    58757    demo_coveyance_db    DATABASE     n   CREATE DATABASE demo_coveyance_db WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Russian_Russia.1251';
 !   DROP DATABASE demo_coveyance_db;
                postgres    false                        2615    58758    auto    SCHEMA        CREATE SCHEMA auto;
    DROP SCHEMA auto;
                postgres    false                        2615    58935    emploee    SCHEMA        CREATE SCHEMA emploee;
    DROP SCHEMA emploee;
                postgres    false                        2615    58944    payment    SCHEMA        CREATE SCHEMA payment;
    DROP SCHEMA payment;
                postgres    false            
            2615    58926    route    SCHEMA        CREATE SCHEMA route;
    DROP SCHEMA route;
                postgres    false                        2615    58917    shipper    SCHEMA        CREATE SCHEMA shipper;
    DROP SCHEMA shipper;
                postgres    false            �            1255    58759 E   add_carmodel(character varying, character varying, character varying) 	   PROCEDURE     b  CREATE PROCEDURE auto.add_carmodel(namebrand character varying, symbolcategory character varying, carmodel character varying)
    LANGUAGE sql
    AS $$
	INSERT INTO auto.carsmodels ( autobrand_id, autocategory_id, carsmodel_name )
	VALUES ( ( SELECT auto.getAutobrand_id(nameBrand) ), ( SELECT auto.getAutocategory_id(symbolCategory) ), carModel );
$$;
 }   DROP PROCEDURE auto.add_carmodel(namebrand character varying, symbolcategory character varying, carmodel character varying);
       auto          postgres    false    8            �            1255    58760 "   getautobrand_id(character varying)    FUNCTION     �   CREATE FUNCTION auto.getautobrand_id(namebrand character varying) RETURNS integer
    LANGUAGE sql
    AS $$
	SELECT autobrand_id FROM auto.autobrands WHERE autobrand_name = nameBrand;
$$;
 A   DROP FUNCTION auto.getautobrand_id(namebrand character varying);
       auto          postgres    false    8            �            1255    58761 %   getautocategory_id(character varying)    FUNCTION     �   CREATE FUNCTION auto.getautocategory_id(symbolcategory character varying) RETURNS integer
    LANGUAGE sql
    AS $$
	SELECT autocategory_id FROM auto.autocategories WHERE autocategory_symbol = symbolCategory;
$$;
 I   DROP FUNCTION auto.getautocategory_id(symbolcategory character varying);
       auto          postgres    false    8                       1255    59000     getemploee_id(character varying)    FUNCTION     �  CREATE FUNCTION emploee.getemploee_id(nameemploee character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$
	DECLARE id INTEGER DEFAULT NULL;
	BEGIN
		id = ( SELECT emploee_id FROM emploee.emploees WHERE  emploee_name = nameEmploee );
		IF ( id IS NULL ) THEN
			BEGIN
				INSERT INTO emploee.emploees ( emploee_name ) VALUES ( nameEmploee );
				id = ( SELECT lastval() );
			END;
		END IF;
		RETURN id;
	END;
$$;
 D   DROP FUNCTION emploee.getemploee_id(nameemploee character varying);
       emploee          postgres    false    4            �            1255    58762 #   addcity(character varying, integer)    FUNCTION     �   CREATE FUNCTION public.addcity(nm character varying, idcountry integer) RETURNS void
    LANGUAGE sql
    AS $$ INSERT INTO cities ( city_name, country_id ) VALUES ( nm, idCountry ) $$;
 G   DROP FUNCTION public.addcity(nm character varying, idcountry integer);
       public          postgres    false            �            1255    58763 '   func_to_trigger_insupddel_adress_view()    FUNCTION     �  CREATE FUNCTION public.func_to_trigger_insupddel_adress_view() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	SELECT insertOrIgnoreStreet( NOW.street_name );
	INSERT INTO adress ( country_id, city_id, street_id, adres_index, adres_type )
	VALUES (  ( SELECT id_country( NOW.country_name ) ), ( SELECT id_city( NOW.city_name ) ), ( SELECT id_street( NOW.street_name ) ), NOW.adres_index, NOW.adres_type );
END
$$;
 >   DROP FUNCTION public.func_to_trigger_insupddel_adress_view();
       public          postgres    false            �            1255    58764 !   get_id_country(character varying)    FUNCTION     �   CREATE FUNCTION public.get_id_country(nm character varying) RETURNS integer
    LANGUAGE sql
    AS $$SELECT country_id FROM countrys WHERE country_name = nm$$;
 ;   DROP FUNCTION public.get_id_country(nm character varying);
       public          postgres    false            �            1255    58765    get_vat_id(real)    FUNCTION     �   CREATE FUNCTION public.get_vat_id(vat_st real) RETURNS integer
    LANGUAGE sql
    AS $$ SELECT vat_id FROM vats WHERE vat_stavka = vat_st; $$;
 .   DROP FUNCTION public.get_vat_id(vat_st real);
       public          postgres    false            �            1255    58766    get_vat_id(numeric)    FUNCTION     �   CREATE FUNCTION public.get_vat_id(vat_st numeric) RETURNS integer
    LANGUAGE sql
    AS $$ SELECT vat_id FROM vats WHERE vat_stavka = vat_st; $$;
 1   DROP FUNCTION public.get_vat_id(vat_st numeric);
       public          postgres    false            �            1255    58767    id_city(character varying)    FUNCTION     �   CREATE FUNCTION public.id_city(ct character varying) RETURNS integer
    LANGUAGE sql
    AS $$ SELECT city_id FROM cities WHERE city_name = ct $$;
 4   DROP FUNCTION public.id_city(ct character varying);
       public          postgres    false            �            1255    58768    id_country(character varying)    FUNCTION     �   CREATE FUNCTION public.id_country(cntr character varying) RETURNS integer
    LANGUAGE sql
    AS $$SELECT country_id FROM countrys WHERE country_name = cntr$$;
 9   DROP FUNCTION public.id_country(cntr character varying);
       public          postgres    false            �            1255    58769    id_street(character varying)    FUNCTION     �   CREATE FUNCTION public.id_street(st character varying) RETURNS integer
    LANGUAGE sql
    AS $$SELECT street_id FROM streets WHERE street_name = st$$;
 6   DROP FUNCTION public.id_street(st character varying);
       public          postgres    false            �            1255    58770    id_vatnames(character varying)    FUNCTION     �   CREATE FUNCTION public.id_vatnames(nm character varying) RETURNS integer
    LANGUAGE sql
    AS $$ SELECT vatname_id FROM vatnames WHERE vatname_name = nm $$;
 8   DROP FUNCTION public.id_vatnames(nm character varying);
       public          postgres    false            �            1255    58771 l   insert_adress(character varying, character varying, character varying, character varying, character varying) 	   PROCEDURE     �  CREATE PROCEDURE public.insert_adress(cntr character varying, ct character varying, strt character varying, idx character varying, type_adress character varying)
    LANGUAGE sql
    AS $$
	INSERT INTO adress ( country_id, city_id, street_id, adres_index, adres_type )
	VALUES (  ( SELECT id_country( cntr ) ), ( SELECT id_city( ct ) ), ( SELECT id_street( strt ) ), idx, type_adress );
$$;
 �   DROP PROCEDURE public.insert_adress(cntr character varying, ct character varying, strt character varying, idx character varying, type_adress character varying);
       public          postgres    false            �            1255    58772 '   insertorignorestreet(character varying) 	   PROCEDURE     �   CREATE PROCEDURE public.insertorignorestreet(strt character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
	IF NOT EXISTS(  SELECT 1 FROM streets WHERE street_name = strt )
		THEN  INSERT INTO streets ( street_name ) VALUES ( strt );
	END IF;
END
$$;
 D   DROP PROCEDURE public.insertorignorestreet(strt character varying);
       public          postgres    false            �            1255    58773 u   update_adress(integer, character varying, character varying, character varying, character varying, character varying) 	   PROCEDURE     �  CREATE PROCEDURE public.update_adress(id integer, cntr character varying, ct character varying, strt character varying, idx character varying, type_adress character varying)
    LANGUAGE sql
    AS $$
	CALL insertOrIgnoreStreet(strt);
	UPDATE adress SET country_id = ( SELECT id_country(cntr) ),
					  city_id = ( SELECT id_city(ct) ),
					  street_id = ( SELECT id_street(strt) ),
					  adres_type = type_adress,
					  adres_index = idx
	WHERE adres_id = id;
$$;
 �   DROP PROCEDURE public.update_adress(id integer, cntr character varying, ct character varying, strt character varying, idx character varying, type_adress character varying);
       public          postgres    false                       1255    58998 %   getrout_id(integer, integer, numeric)    FUNCTION     �  CREATE FUNCTION route.getrout_id(arrival integer, route integer, ante numeric) RETURNS integer
    LANGUAGE plpgsql
    AS $$
	DECLARE id INTEGER DEFAULT NULL;
	BEGIN
		id = ( SELECT route_id FROM route.routes WHERE route_arrival = arrival
													AND route_route = route
													AND route_ante = ante::MONEY);
		IF ( id IS NULL ) THEN
			BEGIN
				CALL route.insertRoute(arrival, route, ante);
				id = ( SELECT lastval() );
			END;
		END IF;
	RETURN id;
	END;
$$;
 N   DROP FUNCTION route.getrout_id(arrival integer, route integer, ante numeric);
       route          postgres    false    10            �            1255    58994 $   insertroute(integer, integer, money) 	   PROCEDURE     �   CREATE PROCEDURE route.insertroute(arrival integer, rout integer, ante money)
    LANGUAGE sql
    AS $$
	INSERT INTO route.routes(route_arrival, route_route, route_ante) VALUES (arrival, rout, ante);
$$;
 M   DROP PROCEDURE route.insertroute(arrival integer, rout integer, ante money);
       route          postgres    false    10            �            1255    58995 &   insertroute(integer, integer, numeric) 	   PROCEDURE     �   CREATE PROCEDURE route.insertroute(arrival integer, rout integer, ante numeric)
    LANGUAGE sql
    AS $$
	INSERT INTO route.routes(route_arrival, route_route, route_ante) VALUES (arrival, rout, ante::MONEY);
$$;
 O   DROP PROCEDURE route.insertroute(arrival integer, rout integer, ante numeric);
       route          postgres    false    10                       1255    58993     getshipper_id(character varying)    FUNCTION     �  CREATE FUNCTION shipper.getshipper_id(shippername character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE id INTEGER;
	BEGIN
		id = ( SELECT shipper_id FROM shipper.shippers WHERE  shipper_name = shipperName );
		IF ( id IS NULL ) THEN
			BEGIN
				INSERT INTO shipper.shippers ( shipper_name ) VALUES (shipperName);
				id = ( SELECT lastval(  ) ) ;
			END;
		END IF;
		RETURN id;
	END;
$$;
 D   DROP FUNCTION shipper.getshipper_id(shippername character varying);
       shipper          postgres    false    7            �            1259    58774 
   autobrands    TABLE     �   CREATE TABLE auto.autobrands (
    autobrand_id integer NOT NULL,
    autobrand_name character varying(256) NOT NULL,
    autobrand_icon character varying(256) DEFAULT 'no_icon.png'::character varying
);
    DROP TABLE auto.autobrands;
       auto         heap    postgres    false    8            �            1259    58781    autobrands_autobrand_id_seq    SEQUENCE     �   CREATE SEQUENCE auto.autobrands_autobrand_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE auto.autobrands_autobrand_id_seq;
       auto          postgres    false    8    205            u           0    0    autobrands_autobrand_id_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE auto.autobrands_autobrand_id_seq OWNED BY auto.autobrands.autobrand_id;
          auto          postgres    false    206            �            1259    58783    autocategories    TABLE     	  CREATE TABLE auto.autocategories (
    autocategory_id integer NOT NULL,
    autocategory_name character varying(256) NOT NULL,
    autocategory_symbol character varying(5) NOT NULL,
    autocategory_icon character varying(64),
    autocategory_description text
);
     DROP TABLE auto.autocategories;
       auto         heap    postgres    false    8            �            1259    58789 "   autocategories_autocategory_id_seq    SEQUENCE     �   CREATE SEQUENCE auto.autocategories_autocategory_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 7   DROP SEQUENCE auto.autocategories_autocategory_id_seq;
       auto          postgres    false    8    207            v           0    0 "   autocategories_autocategory_id_seq    SEQUENCE OWNED BY     e   ALTER SEQUENCE auto.autocategories_autocategory_id_seq OWNED BY auto.autocategories.autocategory_id;
          auto          postgres    false    208            �            1259    58791 
   carsmodels    TABLE     �   CREATE TABLE auto.carsmodels (
    carsmodel_id integer NOT NULL,
    autobrand_id integer NOT NULL,
    autocategory_id integer NOT NULL,
    carsmodel_name character varying(200)
);
    DROP TABLE auto.carsmodels;
       auto         heap    postgres    false    8            �            1259    58794    carsmodels_carsmodel_id_seq    SEQUENCE     �   CREATE SEQUENCE auto.carsmodels_carsmodel_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE auto.carsmodels_carsmodel_id_seq;
       auto          postgres    false    8    209            w           0    0    carsmodels_carsmodel_id_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE auto.carsmodels_carsmodel_id_seq OWNED BY auto.carsmodels.carsmodel_id;
          auto          postgres    false    210            �            1259    58972    emploees    TABLE     l   CREATE TABLE emploee.emploees (
    emploee_id integer NOT NULL,
    emploee_name character varying(200)
);
    DROP TABLE emploee.emploees;
       emploee         heap    postgres    false    4            �            1259    58970    emploees_emploee_id_seq    SEQUENCE     �   CREATE SEQUENCE emploee.emploees_emploee_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE emploee.emploees_emploee_id_seq;
       emploee          postgres    false    229    4            x           0    0    emploees_emploee_id_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE emploee.emploees_emploee_id_seq OWNED BY emploee.emploees.emploee_id;
          emploee          postgres    false    228            �            1259    58980    payments    TABLE     �   CREATE TABLE payment.payments (
    payment_id integer NOT NULL,
    payment_cost money,
    payment_period character varying(10),
    payment_currency character varying(10)
);
    DROP TABLE payment.payments;
       payment         heap    postgres    false    5            �            1259    58978    payments_payment_id_seq    SEQUENCE     �   CREATE SEQUENCE payment.payments_payment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE payment.payments_payment_id_seq;
       payment          postgres    false    231    5            y           0    0    payments_payment_id_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE payment.payments_payment_id_seq OWNED BY payment.payments.payment_id;
          payment          postgres    false    230            �            1259    58796    adress    TABLE     �  CREATE TABLE public.adress (
    adres_id integer NOT NULL,
    country_id integer,
    city_id integer,
    street_id integer,
    adres_type character varying(15),
    adres_index character varying(10),
    CONSTRAINT adress_adres_type_check CHECK (((adres_type)::text = ANY (ARRAY[('Фактический'::character varying)::text, ('Юридический'::character varying)::text])))
);
    DROP TABLE public.adress;
       public         heap    postgres    false            �            1259    58800    adress_adres_id_seq    SEQUENCE     �   CREATE SEQUENCE public.adress_adres_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.adress_adres_id_seq;
       public          postgres    false    211            z           0    0    adress_adres_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.adress_adres_id_seq OWNED BY public.adress.adres_id;
          public          postgres    false    212            �            1259    58802    cities    TABLE     �   CREATE TABLE public.cities (
    city_id integer NOT NULL,
    city_name character varying(256) NOT NULL,
    country_id integer
);
    DROP TABLE public.cities;
       public         heap    postgres    false            �            1259    58805    countrys    TABLE     M  CREATE TABLE public.countrys (
    country_id integer NOT NULL,
    vat_id integer NOT NULL,
    vatname_id integer NOT NULL,
    country_name character varying(256) NOT NULL,
    country_abbreviated_2 character varying(4) NOT NULL,
    country_abbreviated_3 character varying(4) NOT NULL,
    country_icon character varying(256)
);
    DROP TABLE public.countrys;
       public         heap    postgres    false            �            1259    58811    streets    TABLE     q   CREATE TABLE public.streets (
    street_id integer NOT NULL,
    street_name character varying(256) NOT NULL
);
    DROP TABLE public.streets;
       public         heap    postgres    false            �            1259    58814    adress_view    VIEW     �  CREATE VIEW public.adress_view AS
 SELECT ad.adres_id,
    cntr.country_icon,
    cntr.country_name,
    ad.adres_index,
    ct.city_name,
    st.street_name,
    ad.adres_type
   FROM (((public.adress ad
     LEFT JOIN public.countrys cntr ON ((ad.country_id = cntr.country_id)))
     LEFT JOIN public.cities ct ON ((ad.city_id = ct.city_id)))
     LEFT JOIN public.streets st ON ((ad.street_id = st.street_id)));
    DROP VIEW public.adress_view;
       public          postgres    false    214    211    211    211    211    211    211    213    213    214    214    215    215            �            1259    58819    countrys_country_id_seq    SEQUENCE     �   CREATE SEQUENCE public.countrys_country_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.countrys_country_id_seq;
       public          postgres    false    214            {           0    0    countrys_country_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.countrys_country_id_seq OWNED BY public.countrys.country_id;
          public          postgres    false    217            �            1259    58821    sities_city_id_seq    SEQUENCE     �   CREATE SEQUENCE public.sities_city_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.sities_city_id_seq;
       public          postgres    false    213            |           0    0    sities_city_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.sities_city_id_seq OWNED BY public.cities.city_id;
          public          postgres    false    218            �            1259    58823    streets_street_id_seq    SEQUENCE     �   CREATE SEQUENCE public.streets_street_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.streets_street_id_seq;
       public          postgres    false    215            }           0    0    streets_street_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.streets_street_id_seq OWNED BY public.streets.street_id;
          public          postgres    false    219            �            1259    58825    vatnames    TABLE     j   CREATE TABLE public.vatnames (
    vatname_id integer NOT NULL,
    vatname_name character varying(10)
);
    DROP TABLE public.vatnames;
       public         heap    postgres    false            �            1259    58828    vatnames_vatname_id_seq    SEQUENCE     �   CREATE SEQUENCE public.vatnames_vatname_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.vatnames_vatname_id_seq;
       public          postgres    false    220            ~           0    0    vatnames_vatname_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.vatnames_vatname_id_seq OWNED BY public.vatnames.vatname_id;
          public          postgres    false    221            �            1259    58830    vats    TABLE     �   CREATE TABLE public.vats (
    vat_id integer NOT NULL,
    vat_stavka numeric(4,2) NOT NULL,
    CONSTRAINT vats_valid CHECK (((vat_stavka > (0)::numeric) AND (vat_stavka < (100)::numeric)))
);
    DROP TABLE public.vats;
       public         heap    postgres    false            �            1259    58834    vats_vat_id_seq    SEQUENCE     �   CREATE SEQUENCE public.vats_vat_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.vats_vat_id_seq;
       public          postgres    false    222                       0    0    vats_vat_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.vats_vat_id_seq OWNED BY public.vats.vat_id;
          public          postgres    false    223            �            1259    58964    routes    TABLE     �   CREATE TABLE route.routes (
    route_id integer NOT NULL,
    route_arrival integer,
    route_route integer,
    route_ante money
);
    DROP TABLE route.routes;
       route         heap    postgres    false    10            �            1259    58962    routes_route_id_seq    SEQUENCE     �   CREATE SEQUENCE route.routes_route_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE route.routes_route_id_seq;
       route          postgres    false    10    227            �           0    0    routes_route_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE route.routes_route_id_seq OWNED BY route.routes.route_id;
          route          postgres    false    226            �            1259    58956    shippers    TABLE     l   CREATE TABLE shipper.shippers (
    shipper_id integer NOT NULL,
    shipper_name character varying(200)
);
    DROP TABLE shipper.shippers;
       shipper         heap    postgres    false    7            �            1259    58954    shippers_shipper_id_seq    SEQUENCE     �   CREATE SEQUENCE shipper.shippers_shipper_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE shipper.shippers_shipper_id_seq;
       shipper          postgres    false    7    225            �           0    0    shippers_shipper_id_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE shipper.shippers_shipper_id_seq OWNED BY shipper.shippers.shipper_id;
          shipper          postgres    false    224            �           2604    58836    autobrands autobrand_id    DEFAULT     ~   ALTER TABLE ONLY auto.autobrands ALTER COLUMN autobrand_id SET DEFAULT nextval('auto.autobrands_autobrand_id_seq'::regclass);
 D   ALTER TABLE auto.autobrands ALTER COLUMN autobrand_id DROP DEFAULT;
       auto          postgres    false    206    205            �           2604    58837    autocategories autocategory_id    DEFAULT     �   ALTER TABLE ONLY auto.autocategories ALTER COLUMN autocategory_id SET DEFAULT nextval('auto.autocategories_autocategory_id_seq'::regclass);
 K   ALTER TABLE auto.autocategories ALTER COLUMN autocategory_id DROP DEFAULT;
       auto          postgres    false    208    207            �           2604    58838    carsmodels carsmodel_id    DEFAULT     ~   ALTER TABLE ONLY auto.carsmodels ALTER COLUMN carsmodel_id SET DEFAULT nextval('auto.carsmodels_carsmodel_id_seq'::regclass);
 D   ALTER TABLE auto.carsmodels ALTER COLUMN carsmodel_id DROP DEFAULT;
       auto          postgres    false    210    209            �           2604    58975    emploees emploee_id    DEFAULT     |   ALTER TABLE ONLY emploee.emploees ALTER COLUMN emploee_id SET DEFAULT nextval('emploee.emploees_emploee_id_seq'::regclass);
 C   ALTER TABLE emploee.emploees ALTER COLUMN emploee_id DROP DEFAULT;
       emploee          postgres    false    228    229    229            �           2604    58983    payments payment_id    DEFAULT     |   ALTER TABLE ONLY payment.payments ALTER COLUMN payment_id SET DEFAULT nextval('payment.payments_payment_id_seq'::regclass);
 C   ALTER TABLE payment.payments ALTER COLUMN payment_id DROP DEFAULT;
       payment          postgres    false    230    231    231            �           2604    58839    adress adres_id    DEFAULT     r   ALTER TABLE ONLY public.adress ALTER COLUMN adres_id SET DEFAULT nextval('public.adress_adres_id_seq'::regclass);
 >   ALTER TABLE public.adress ALTER COLUMN adres_id DROP DEFAULT;
       public          postgres    false    212    211            �           2604    58840    cities city_id    DEFAULT     p   ALTER TABLE ONLY public.cities ALTER COLUMN city_id SET DEFAULT nextval('public.sities_city_id_seq'::regclass);
 =   ALTER TABLE public.cities ALTER COLUMN city_id DROP DEFAULT;
       public          postgres    false    218    213            �           2604    58841    countrys country_id    DEFAULT     z   ALTER TABLE ONLY public.countrys ALTER COLUMN country_id SET DEFAULT nextval('public.countrys_country_id_seq'::regclass);
 B   ALTER TABLE public.countrys ALTER COLUMN country_id DROP DEFAULT;
       public          postgres    false    217    214            �           2604    58842    streets street_id    DEFAULT     v   ALTER TABLE ONLY public.streets ALTER COLUMN street_id SET DEFAULT nextval('public.streets_street_id_seq'::regclass);
 @   ALTER TABLE public.streets ALTER COLUMN street_id DROP DEFAULT;
       public          postgres    false    219    215            �           2604    58843    vatnames vatname_id    DEFAULT     z   ALTER TABLE ONLY public.vatnames ALTER COLUMN vatname_id SET DEFAULT nextval('public.vatnames_vatname_id_seq'::regclass);
 B   ALTER TABLE public.vatnames ALTER COLUMN vatname_id DROP DEFAULT;
       public          postgres    false    221    220            �           2604    58844    vats vat_id    DEFAULT     j   ALTER TABLE ONLY public.vats ALTER COLUMN vat_id SET DEFAULT nextval('public.vats_vat_id_seq'::regclass);
 :   ALTER TABLE public.vats ALTER COLUMN vat_id DROP DEFAULT;
       public          postgres    false    223    222            �           2604    58967    routes route_id    DEFAULT     p   ALTER TABLE ONLY route.routes ALTER COLUMN route_id SET DEFAULT nextval('route.routes_route_id_seq'::regclass);
 =   ALTER TABLE route.routes ALTER COLUMN route_id DROP DEFAULT;
       route          postgres    false    227    226    227            �           2604    58959    shippers shipper_id    DEFAULT     |   ALTER TABLE ONLY shipper.shippers ALTER COLUMN shipper_id SET DEFAULT nextval('shipper.shippers_shipper_id_seq'::regclass);
 C   ALTER TABLE shipper.shippers ALTER COLUMN shipper_id DROP DEFAULT;
       shipper          postgres    false    225    224    225            U          0    58774 
   autobrands 
   TABLE DATA           P   COPY auto.autobrands (autobrand_id, autobrand_name, autobrand_icon) FROM stdin;
    auto          postgres    false    205   �       W          0    58783    autocategories 
   TABLE DATA           �   COPY auto.autocategories (autocategory_id, autocategory_name, autocategory_symbol, autocategory_icon, autocategory_description) FROM stdin;
    auto          postgres    false    207   ��       Y          0    58791 
   carsmodels 
   TABLE DATA           _   COPY auto.carsmodels (carsmodel_id, autobrand_id, autocategory_id, carsmodel_name) FROM stdin;
    auto          postgres    false    209   �       l          0    58972    emploees 
   TABLE DATA           =   COPY emploee.emploees (emploee_id, emploee_name) FROM stdin;
    emploee          postgres    false    229   �       n          0    58980    payments 
   TABLE DATA           _   COPY payment.payments (payment_id, payment_cost, payment_period, payment_currency) FROM stdin;
    payment          postgres    false    231   a�       [          0    58796    adress 
   TABLE DATA           c   COPY public.adress (adres_id, country_id, city_id, street_id, adres_type, adres_index) FROM stdin;
    public          postgres    false    211   ~�       ]          0    58802    cities 
   TABLE DATA           @   COPY public.cities (city_id, city_name, country_id) FROM stdin;
    public          postgres    false    213   ǻ       ^          0    58805    countrys 
   TABLE DATA           �   COPY public.countrys (country_id, vat_id, vatname_id, country_name, country_abbreviated_2, country_abbreviated_3, country_icon) FROM stdin;
    public          postgres    false    214   4�       _          0    58811    streets 
   TABLE DATA           9   COPY public.streets (street_id, street_name) FROM stdin;
    public          postgres    false    215   �       c          0    58825    vatnames 
   TABLE DATA           <   COPY public.vatnames (vatname_id, vatname_name) FROM stdin;
    public          postgres    false    220   ��       e          0    58830    vats 
   TABLE DATA           2   COPY public.vats (vat_id, vat_stavka) FROM stdin;
    public          postgres    false    222   -�       j          0    58964    routes 
   TABLE DATA           Q   COPY route.routes (route_id, route_arrival, route_route, route_ante) FROM stdin;
    route          postgres    false    227   ��       h          0    58956    shippers 
   TABLE DATA           =   COPY shipper.shippers (shipper_id, shipper_name) FROM stdin;
    shipper          postgres    false    225   ��       �           0    0    autobrands_autobrand_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('auto.autobrands_autobrand_id_seq', 12, true);
          auto          postgres    false    206            �           0    0 "   autocategories_autocategory_id_seq    SEQUENCE SET     O   SELECT pg_catalog.setval('auto.autocategories_autocategory_id_seq', 16, true);
          auto          postgres    false    208            �           0    0    carsmodels_carsmodel_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('auto.carsmodels_carsmodel_id_seq', 3, true);
          auto          postgres    false    210            �           0    0    emploees_emploee_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('emploee.emploees_emploee_id_seq', 2, true);
          emploee          postgres    false    228            �           0    0    payments_payment_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('payment.payments_payment_id_seq', 1, false);
          payment          postgres    false    230            �           0    0    adress_adres_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.adress_adres_id_seq', 9, true);
          public          postgres    false    212            �           0    0    countrys_country_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.countrys_country_id_seq', 53, true);
          public          postgres    false    217            �           0    0    sities_city_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.sities_city_id_seq', 32, true);
          public          postgres    false    218            �           0    0    streets_street_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.streets_street_id_seq', 44, true);
          public          postgres    false    219            �           0    0    vatnames_vatname_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.vatnames_vatname_id_seq', 39, true);
          public          postgres    false    221            �           0    0    vats_vat_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.vats_vat_id_seq', 43, true);
          public          postgres    false    223            �           0    0    routes_route_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('route.routes_route_id_seq', 5, true);
          route          postgres    false    226            �           0    0    shippers_shipper_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('shipper.shippers_shipper_id_seq', 13, true);
          shipper          postgres    false    224            �           2606    58846 &   autobrands autobrands_autobrand_id_key 
   CONSTRAINT     g   ALTER TABLE ONLY auto.autobrands
    ADD CONSTRAINT autobrands_autobrand_id_key UNIQUE (autobrand_id);
 N   ALTER TABLE ONLY auto.autobrands DROP CONSTRAINT autobrands_autobrand_id_key;
       auto            postgres    false    205            �           2606    58848 (   autobrands autobrands_autobrand_name_key 
   CONSTRAINT     k   ALTER TABLE ONLY auto.autobrands
    ADD CONSTRAINT autobrands_autobrand_name_key UNIQUE (autobrand_name);
 P   ALTER TABLE ONLY auto.autobrands DROP CONSTRAINT autobrands_autobrand_name_key;
       auto            postgres    false    205            �           2606    58850 1   autocategories autocategories_autocategory_id_key 
   CONSTRAINT     u   ALTER TABLE ONLY auto.autocategories
    ADD CONSTRAINT autocategories_autocategory_id_key UNIQUE (autocategory_id);
 Y   ALTER TABLE ONLY auto.autocategories DROP CONSTRAINT autocategories_autocategory_id_key;
       auto            postgres    false    207            �           2606    58852 &   carsmodels carsmodels_carsmodel_id_key 
   CONSTRAINT     g   ALTER TABLE ONLY auto.carsmodels
    ADD CONSTRAINT carsmodels_carsmodel_id_key UNIQUE (carsmodel_id);
 N   ALTER TABLE ONLY auto.carsmodels DROP CONSTRAINT carsmodels_carsmodel_id_key;
       auto            postgres    false    209            �           2606    58977     emploees emploees_emploee_id_key 
   CONSTRAINT     b   ALTER TABLE ONLY emploee.emploees
    ADD CONSTRAINT emploees_emploee_id_key UNIQUE (emploee_id);
 K   ALTER TABLE ONLY emploee.emploees DROP CONSTRAINT emploees_emploee_id_key;
       emploee            postgres    false    229            �           2606    58985     payments payments_payment_id_key 
   CONSTRAINT     b   ALTER TABLE ONLY payment.payments
    ADD CONSTRAINT payments_payment_id_key UNIQUE (payment_id);
 K   ALTER TABLE ONLY payment.payments DROP CONSTRAINT payments_payment_id_key;
       payment            postgres    false    231            �           2606    58854    adress adress_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.adress
    ADD CONSTRAINT adress_pkey PRIMARY KEY (adres_id);
 <   ALTER TABLE ONLY public.adress DROP CONSTRAINT adress_pkey;
       public            postgres    false    211            �           2606    58856 +   countrys countrys_country_abbreviated_2_key 
   CONSTRAINT     w   ALTER TABLE ONLY public.countrys
    ADD CONSTRAINT countrys_country_abbreviated_2_key UNIQUE (country_abbreviated_2);
 U   ALTER TABLE ONLY public.countrys DROP CONSTRAINT countrys_country_abbreviated_2_key;
       public            postgres    false    214            �           2606    58858 +   countrys countrys_country_abbreviated_3_key 
   CONSTRAINT     w   ALTER TABLE ONLY public.countrys
    ADD CONSTRAINT countrys_country_abbreviated_3_key UNIQUE (country_abbreviated_3);
 U   ALTER TABLE ONLY public.countrys DROP CONSTRAINT countrys_country_abbreviated_3_key;
       public            postgres    false    214            �           2606    58860 "   countrys countrys_country_name_key 
   CONSTRAINT     e   ALTER TABLE ONLY public.countrys
    ADD CONSTRAINT countrys_country_name_key UNIQUE (country_name);
 L   ALTER TABLE ONLY public.countrys DROP CONSTRAINT countrys_country_name_key;
       public            postgres    false    214            �           2606    58862    countrys countrys_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.countrys
    ADD CONSTRAINT countrys_pkey PRIMARY KEY (country_id);
 @   ALTER TABLE ONLY public.countrys DROP CONSTRAINT countrys_pkey;
       public            postgres    false    214            �           2606    58864    cities sities_city_id_key 
   CONSTRAINT     W   ALTER TABLE ONLY public.cities
    ADD CONSTRAINT sities_city_id_key UNIQUE (city_id);
 C   ALTER TABLE ONLY public.cities DROP CONSTRAINT sities_city_id_key;
       public            postgres    false    213            �           2606    58866    cities sities_city_name_key 
   CONSTRAINT     [   ALTER TABLE ONLY public.cities
    ADD CONSTRAINT sities_city_name_key UNIQUE (city_name);
 E   ALTER TABLE ONLY public.cities DROP CONSTRAINT sities_city_name_key;
       public            postgres    false    213            �           2606    58868    cities sities_city_name_key1 
   CONSTRAINT     \   ALTER TABLE ONLY public.cities
    ADD CONSTRAINT sities_city_name_key1 UNIQUE (city_name);
 F   ALTER TABLE ONLY public.cities DROP CONSTRAINT sities_city_name_key1;
       public            postgres    false    213            �           2606    58870    cities sities_pkey 
   CONSTRAINT     U   ALTER TABLE ONLY public.cities
    ADD CONSTRAINT sities_pkey PRIMARY KEY (city_id);
 <   ALTER TABLE ONLY public.cities DROP CONSTRAINT sities_pkey;
       public            postgres    false    213            �           2606    58872    streets streets_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY public.streets
    ADD CONSTRAINT streets_pkey PRIMARY KEY (street_id);
 >   ALTER TABLE ONLY public.streets DROP CONSTRAINT streets_pkey;
       public            postgres    false    215            �           2606    58874    streets streets_street_id_key 
   CONSTRAINT     ]   ALTER TABLE ONLY public.streets
    ADD CONSTRAINT streets_street_id_key UNIQUE (street_id);
 G   ALTER TABLE ONLY public.streets DROP CONSTRAINT streets_street_id_key;
       public            postgres    false    215            �           2606    58876    streets streets_street_name_key 
   CONSTRAINT     a   ALTER TABLE ONLY public.streets
    ADD CONSTRAINT streets_street_name_key UNIQUE (street_name);
 I   ALTER TABLE ONLY public.streets DROP CONSTRAINT streets_street_name_key;
       public            postgres    false    215            �           2606    58878    vatnames vatnames_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.vatnames
    ADD CONSTRAINT vatnames_pkey PRIMARY KEY (vatname_id);
 @   ALTER TABLE ONLY public.vatnames DROP CONSTRAINT vatnames_pkey;
       public            postgres    false    220            �           2606    58880 "   vatnames vatnames_vatname_name_key 
   CONSTRAINT     e   ALTER TABLE ONLY public.vatnames
    ADD CONSTRAINT vatnames_vatname_name_key UNIQUE (vatname_name);
 L   ALTER TABLE ONLY public.vatnames DROP CONSTRAINT vatnames_vatname_name_key;
       public            postgres    false    220            �           2606    58882    vats vats_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.vats
    ADD CONSTRAINT vats_pkey PRIMARY KEY (vat_id);
 8   ALTER TABLE ONLY public.vats DROP CONSTRAINT vats_pkey;
       public            postgres    false    222            �           2606    58884    vats vats_vat_id_key 
   CONSTRAINT     Q   ALTER TABLE ONLY public.vats
    ADD CONSTRAINT vats_vat_id_key UNIQUE (vat_id);
 >   ALTER TABLE ONLY public.vats DROP CONSTRAINT vats_vat_id_key;
       public            postgres    false    222            �           2606    58886    vats vats_vat_stavka_key 
   CONSTRAINT     Y   ALTER TABLE ONLY public.vats
    ADD CONSTRAINT vats_vat_stavka_key UNIQUE (vat_stavka);
 B   ALTER TABLE ONLY public.vats DROP CONSTRAINT vats_vat_stavka_key;
       public            postgres    false    222            �           2606    58969    routes routes_route_id_key 
   CONSTRAINT     X   ALTER TABLE ONLY route.routes
    ADD CONSTRAINT routes_route_id_key UNIQUE (route_id);
 C   ALTER TABLE ONLY route.routes DROP CONSTRAINT routes_route_id_key;
       route            postgres    false    227            �           2606    58961     shippers shippers_shipper_id_key 
   CONSTRAINT     b   ALTER TABLE ONLY shipper.shippers
    ADD CONSTRAINT shippers_shipper_id_key UNIQUE (shipper_id);
 K   ALTER TABLE ONLY shipper.shippers DROP CONSTRAINT shippers_shipper_id_key;
       shipper            postgres    false    225            �           2606    58887 '   carsmodels carsmodels_autobrand_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY auto.carsmodels
    ADD CONSTRAINT carsmodels_autobrand_id_fkey FOREIGN KEY (autobrand_id) REFERENCES auto.autobrands(autobrand_id);
 O   ALTER TABLE ONLY auto.carsmodels DROP CONSTRAINT carsmodels_autobrand_id_fkey;
       auto          postgres    false    205    2971    209            �           2606    58892 *   carsmodels carsmodels_autocategory_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY auto.carsmodels
    ADD CONSTRAINT carsmodels_autocategory_id_fkey FOREIGN KEY (autocategory_id) REFERENCES auto.autocategories(autocategory_id);
 R   ALTER TABLE ONLY auto.carsmodels DROP CONSTRAINT carsmodels_autocategory_id_fkey;
       auto          postgres    false    207    2975    209            �           2606    58897    adress adress_city_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.adress
    ADD CONSTRAINT adress_city_id_fkey FOREIGN KEY (city_id) REFERENCES public.cities(city_id) ON DELETE SET NULL;
 D   ALTER TABLE ONLY public.adress DROP CONSTRAINT adress_city_id_fkey;
       public          postgres    false    213    211    2981            �           2606    58902    adress adress_country_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.adress
    ADD CONSTRAINT adress_country_id_fkey FOREIGN KEY (country_id) REFERENCES public.countrys(country_id) ON DELETE SET NULL;
 G   ALTER TABLE ONLY public.adress DROP CONSTRAINT adress_country_id_fkey;
       public          postgres    false    2995    214    211            �           2606    58907    adress adress_street_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.adress
    ADD CONSTRAINT adress_street_id_fkey FOREIGN KEY (street_id) REFERENCES public.streets(street_id) ON DELETE SET NULL;
 F   ALTER TABLE ONLY public.adress DROP CONSTRAINT adress_street_id_fkey;
       public          postgres    false    2997    211    215            �           2606    58912    countrys countrys_vat_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.countrys
    ADD CONSTRAINT countrys_vat_id_fkey FOREIGN KEY (vat_id) REFERENCES public.vats(vat_id) ON UPDATE SET NULL ON DELETE SET NULL;
 G   ALTER TABLE ONLY public.countrys DROP CONSTRAINT countrys_vat_id_fkey;
       public          postgres    false    222    214    3007            U   �   x�3�I-.��ˏ�L���+�K�2r�$g�e�s����8s
2u��sS�uM*�,o�ya�ņ{.l��������ojQqjJj1gJ~y^N~b
X�ln	�U��N�a�I�e�!�5(�14�ꂩ����� T7G�      W   )  x��Y�r�F>KO1�A�F��'9�^�q�)��B��x��Y�T�	e.R�Z�+,�oO0z�<I����4iH���QO�|�uOo��z�:ң��t����|��:֑��z�G�:N���XO����{���{O���d���y�@�J��J��)���!$����q��+=-m9i�2�y������G��� �rf��'=�(��T��#�0y�c耍��S��pc����'�>%5?��%Aɀe7(D""��$9�g�~r��&��_�%ם|�ۓ�&�%��̏�ҿ�!d�N�*�;mP��/������c�czĪТ��0`�B�,�ű�a�w$�q�n��'}Ҹє���"v�WJ`��+K(ʁ2O�B�@9��fƷO�N�w��}�2��p�sA�D&�4���%gX&p3�1��ʴ�[��%�I���k����8��I?�x//��6z�ވ�Ep��6O y_�Lq�{v�X�e%�zL�❧���M����s��"�#�#��Pt�>W�"�1c(�F�1�r|r���6��s�ʝ�1���x��V��[��iU����
_rzaV���u#�Cq~�D4$q�[:i�0@�A�xx��U���cǳ��;Uba�ǹPt3kq��<1'�>#�!=Ra���	��@��wr�Iz�(ژI.q(�`�d�d}�mz��U)�
��V�o�B�UO��ow֥1�v�̲=�C�'F�ā)�w@{���)�0�@(�U�2Gn�*F+��1I�ֵ�͟b�g��0�R���gR	o��?��R>$Mm��D����[�E�.�+=+�m4���Ԇ�ӆYf�%bfC��U�(�.����3j����:�z�7F��G�m����;]�P�&������ ���e9:8�b*�H����,$R�%wHe!gR#�W�W�y�b�1crݤ��xKrb��'�Y���=�r�P�c8���~��m�
{���{ei�g�J�L{��T9j����v�dԵn7(Yy1���ğ�F��ұ�S>M�9�q�����w[�Kx�۸V��U����!��4�D��~����ƙq��q�촿;9)�A�m��(��9��N�{��9�G5/��my[�|@�2�z�֪}P��j�n]֟��3�-�+6���cj!��Y�9�l@S��}O�
.}W+������^��7��Wm�h�~_��*���W�|��v^YQ��\���˷�5�v�?paf�ҹn�����Y���Lsl�4tegC�EfT�s��w+��i%��Ʌ��do�I�3�Z���o�$qkt��Rn�s����e�����>�6
6�t9���u�$σ0�'���=x,��~����z���)0����Lǒ�z:)p��s?W��E����V�D�+�����B{����(�BwxO""�p=N�����ᐃԓȐ���5q�L�:��S�O��^��&�1jz�X�t�s��kr3u��cI��*� �ώp�?x��˃�C�u~� �k���z6-I�!�U�E��.�΂��R��U�rJW�S	�~�6�������XZq�i��f��m��@mڬ�gn�q������ݰ������Kh�YA�3�s:{�#�j7:[�p(���X8eٻ숫����b�1�R�1+��)�rΓ�e�T%��]��"���o��X��i�����b�p��Ja����o�Nq���e�8Qi����]HSk7�<m�T�}���5��N����4R��]7����Z*N���`!%��F�]m�õ�����#=�3PV }�+�D���M<�(�u���B�ќ1���ke��}���������      Y   $   x�3�4�4�tJ)N�2�4�4�t)N-����� P��      l   3   x�3�0���{.캰A������_�w��������ɢ+����� �1�      n      x������ � �      [   9   x�. ��9	21	22	44	Фактический	123321
\.


���      ]   ]  x�=��O�@��w�z�EV�5����
�\
���idҚ �����E�����G����}�}��{'"p\���@B�&X�w]��D��$�SP���A�yk����f�HZ�b�8����U���뺼_��(�V*��8�����Q|ȯ$.5
op�c��Y>�3�EbP�'i����|��Z6�$L�j���������.j�|��[6�3.�k������2�6dz�˨�L�Ej�р��2�%8b���n��*�
��p��.�8\eh&�T6���`q�򖫱��0U`�t�F����=��&������K��{ۍ��B��L�      ^   �  x�U��n�F�����dɗ��8�hY )�	
���	Q�@�I�+�A� 	������)ڛNdN;��|���])-t �|3;;gfiըJɗ�myR��syQ��f@�~@a1˳(�1MF��
�o�R^��r^>F���[���zt$�0+f�S�l����B��28����[e�y�̔�ڃ���G᪆�&5h��Hz%��Շ�t\$ j��ٸ�wr	�<���i$�I���B$��\�
?/�Qׅv)����0�Ul������J�F�{��2!BcU���I��O�wh�ۡ�H&a6�T��'�t�B��=��L����s�
�'��}��?0`ٚ�����ͦa�h��x
�R'�&Ey�6m���h��rN;��NW�ۛ| ��	�ʷ*�{5)���C�b��؅����>�Q~\�Ɋ���t(�	Px^>U����m�A��"���\ȶ	�*��Z��험�7׹\�ۇ>���RL��"�m��37�|΍����Q�$�sS�
&��9X}��]�I�4����1Z+�
��ـ��Q�fB�Y�N�W�+���OqxϥށK�t��͓oi�wZ>�e1v��y�,/Fa���\\�V���!�������	c�V���C��̉w �)K'kG�'�s��5y�9�|�E3���
c��N���B�����h�x�<}0zM/M~tW�b]ۄ9����f����Gy����h���?`��_ �����xT�3̾^Ѫ�<�E�V�e�b�S7�P��E�ڃj�L�k���TpӃ�t/���ۏV�i��Po�� K�|u)�,f�Rm�B*J��C�]��`��(KUH�W�[�!O�srh��p7��(��m�ڇ�U{ߡ��#�srh� ��N�T�˥"�-}��Ϙx�4fs���?��@��q��$fy�2��Y������F���z��Z�I�\d4L�'����̘      _   d  x�EPMKA=���\�?fg�V�"ٸ��%��)]a?LO���F�%�z��E�$x���G����T��W�M��d��]Y,�%�M�_�
۪b��ٌ�U�4.f��ҷC�h��䒗�</�#�����E��ڊ�w��9r:=�$�GG����P���tWPi�鵕�2@�c"o� �K{Њ&�::
���tzm鐗%��f�)�vGiݣ��<�6����?�yn"t�����k�pOUU0]�5E��+1�7��$���;�!LJ0�`��-L��^�M�]~˓��7����m�%��y�U��ʟ��Ka5M��cX������j�/ ��t��      c   �   x��A
�0D�3���?���H(�-$��!xq+�r$�Ճ�3���"�0��oML�{8�!��v��#��RZ��-��PNe$=�t�
<e�V��U�+ָ5ի�'��Z.Q�u���y�i�T�^4
{.����#�yk+�      e   �   x�%��D!Ϣ�I�������iJ�X}�F�-&�+Np�f��_�CF��v���K\�ac����WI8�	NVe�ʍٯxn��S|x+�`R+��ZaeNxVVi).����u�C�C#�H��տ�Z�,�      j   $   x�3�4�4�4�16P��2�44�44�4��c���� WE�      h   M   x�B ��12	Вася Терка
13	Колян-железный лом
\.


0�'     