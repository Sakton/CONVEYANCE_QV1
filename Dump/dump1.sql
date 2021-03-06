PGDMP     ,                    y            demo_coveyance_db    13.1    13.3 R    #           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            $           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            %           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            &           1262    59001    demo_coveyance_db    DATABASE     n   CREATE DATABASE demo_coveyance_db WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Russian_Russia.1251';
 !   DROP DATABASE demo_coveyance_db;
                postgres    false                        2615    59127    adres    SCHEMA        CREATE SCHEMA adres;
    DROP SCHEMA adres;
                postgres    false                        2615    59328    shipper    SCHEMA        CREATE SCHEMA shipper;
    DROP SCHEMA shipper;
                postgres    false                        2615    59020    vat    SCHEMA        CREATE SCHEMA vat;
    DROP SCHEMA vat;
                postgres    false            ?            1255    59208 #   addcity(character varying, integer) 	   PROCEDURE     ?   CREATE PROCEDURE adres.addcity(namecity character varying, idcountry integer)
    LANGUAGE sql
    AS $$
    INSERT INTO adres.сities ( city_name, country_id ) VALUES ( nameCity, idCountry );
$$;
 M   DROP PROCEDURE adres.addcity(namecity character varying, idcountry integer);
       adres          postgres    false    5            ?            1255    59211    getcityid(character varying)    FUNCTION     ?   CREATE FUNCTION adres.getcityid(ct character varying) RETURNS integer
    LANGUAGE sql
    AS $$ 
    SELECT city_id FROM adres.сities WHERE city_name = ct;
$$;
 5   DROP FUNCTION adres.getcityid(ct character varying);
       adres          postgres    false    5            ?            1255    59207    getcountryid(character varying)    FUNCTION     ?   CREATE FUNCTION adres.getcountryid(cntr character varying) RETURNS integer
    LANGUAGE sql
    AS $$
    SELECT country_id FROM adres.countrys WHERE country_name = cntr;
$$;
 :   DROP FUNCTION adres.getcountryid(cntr character varying);
       adres          postgres    false    5            ?            1255    59212    getstreetid(character varying)    FUNCTION     ?  CREATE FUNCTION adres.getstreetid(st character varying) RETURNS integer
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
       adres          postgres    false    5            ?            1255    59216 X   insertadress(character varying, character varying, character varying, character varying) 	   PROCEDURE     ?  CREATE PROCEDURE adres.insertadress(ct character varying, strt character varying, idx character varying, type_adress character varying)
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
       adres          postgres    false    5            ?            1255    59341    addshipper(character varying) 	   PROCEDURE     ?   CREATE PROCEDURE shipper.addshipper(nameshipper character varying)
    LANGUAGE sql
    AS $$
    INSERT INTO shipper.shippers ( shipper_name ) VALUES ( nameShipper );
$$;
 B   DROP PROCEDURE shipper.addshipper(nameshipper character varying);
       shipper          postgres    false    8            ?            1255    59042    getvatid(numeric)    FUNCTION     ?   CREATE FUNCTION vat.getvatid(vat_st numeric) RETURNS integer
    LANGUAGE sql
    AS $$
    SELECT vat_id FROM vat.vats WHERE vat_stavka = vat_st;
$$;
 ,   DROP FUNCTION vat.getvatid(vat_st numeric);
       vat          postgres    false    4            ?            1255    59043    getvatnames(character varying)    FUNCTION     ?   CREATE FUNCTION vat.getvatnames(nm character varying) RETURNS integer
    LANGUAGE sql
    AS $$
    SELECT vatname_id FROM vat.vatnames WHERE vatname_name = nm;
$$;
 5   DROP FUNCTION vat.getvatnames(nm character varying);
       vat          postgres    false    4            ?            1259    59277    adress    TABLE     ?  CREATE TABLE adres.adress (
    adres_id integer NOT NULL,
    city_id integer NOT NULL,
    street_id integer NOT NULL,
    adres_index character varying(20),
    adres_type character varying(20) NOT NULL,
    CONSTRAINT adress_adres_type_check CHECK (((adres_type)::text = ANY ((ARRAY['Фактический'::character varying, 'Юридический'::character varying])::text[])))
);
    DROP TABLE adres.adress;
       adres         heap    postgres    false    5            ?            1259    59275    adress_adres_id_seq    SEQUENCE     ?   CREATE SEQUENCE adres.adress_adres_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE adres.adress_adres_id_seq;
       adres          postgres    false    5    214            '           0    0    adress_adres_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE adres.adress_adres_id_seq OWNED BY adres.adress.adres_id;
          adres          postgres    false    213            ?            1259    59130    countrys    TABLE     L  CREATE TABLE adres.countrys (
    country_id integer NOT NULL,
    vat_id integer NOT NULL,
    vatname_id integer NOT NULL,
    country_name character varying(256) NOT NULL,
    country_abbreviated_2 character varying(4) NOT NULL,
    country_abbreviated_3 character varying(4) NOT NULL,
    country_icon character varying(256)
);
    DROP TABLE adres.countrys;
       adres         heap    postgres    false    5            ?            1259    59172    streets    TABLE     p   CREATE TABLE adres.streets (
    street_id integer NOT NULL,
    street_name character varying(256) NOT NULL
);
    DROP TABLE adres.streets;
       adres         heap    postgres    false    5            ?            1259    59157    сities    TABLE     ?   CREATE TABLE adres."сities" (
    city_id integer NOT NULL,
    city_name character varying(256) NOT NULL,
    country_id integer
);
    DROP TABLE adres."сities";
       adres         heap    postgres    false    5            ?            1259    59307 
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
       adres          postgres    false    214    214    214    212    212    210    210    210    208    208    208    214    214    5            ?            1259    59128    countrys_country_id_seq    SEQUENCE     ?   CREATE SEQUENCE adres.countrys_country_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE adres.countrys_country_id_seq;
       adres          postgres    false    5    208            (           0    0    countrys_country_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE adres.countrys_country_id_seq OWNED BY adres.countrys.country_id;
          adres          postgres    false    207            ?            1259    59170    streets_street_id_seq    SEQUENCE     ?   CREATE SEQUENCE adres.streets_street_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE adres.streets_street_id_seq;
       adres          postgres    false    5    212            )           0    0    streets_street_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE adres.streets_street_id_seq OWNED BY adres.streets.street_id;
          adres          postgres    false    211            ?            1259    59312    testadressview    MATERIALIZED VIEW     m  CREATE MATERIALIZED VIEW adres.testadressview AS
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
       adres         heap    postgres    false    214    214    214    212    212    210    210    210    208    208    208    214    214    5            ?            1259    59155    сities_city_id_seq    SEQUENCE     ?   CREATE SEQUENCE adres."сities_city_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE adres."сities_city_id_seq";
       adres          postgres    false    210    5            *           0    0    сities_city_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE adres."сities_city_id_seq" OWNED BY adres."сities".city_id;
          adres          postgres    false    209            ?            1259    59320    testadressview    MATERIALIZED VIEW     n  CREATE MATERIALIZED VIEW public.testadressview AS
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
       public         heap    postgres    false    208    208    210    210    210    212    212    214    214    214    214    214    208            ?            1259    59333    shippers    TABLE     u   CREATE TABLE shipper.shippers (
    shipper_id integer NOT NULL,
    shipper_name character varying(200) NOT NULL
);
    DROP TABLE shipper.shippers;
       shipper         heap    postgres    false    8            ?            1259    59331    shippers_shipper_id_seq    SEQUENCE     ?   CREATE SEQUENCE shipper.shippers_shipper_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE shipper.shippers_shipper_id_seq;
       shipper          postgres    false    219    8            +           0    0    shippers_shipper_id_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE shipper.shippers_shipper_id_seq OWNED BY shipper.shippers.shipper_id;
          shipper          postgres    false    218            ?            1259    59034    vatnames    TABLE     g   CREATE TABLE vat.vatnames (
    vatname_id integer NOT NULL,
    vatname_name character varying(10)
);
    DROP TABLE vat.vatnames;
       vat         heap    postgres    false    4            ?            1259    59032    vatnames_vatname_id_seq    SEQUENCE     ?   CREATE SEQUENCE vat.vatnames_vatname_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE vat.vatnames_vatname_id_seq;
       vat          postgres    false    206    4            ,           0    0    vatnames_vatname_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE vat.vatnames_vatname_id_seq OWNED BY vat.vatnames.vatname_id;
          vat          postgres    false    205            ?            1259    59023    vats    TABLE     ?   CREATE TABLE vat.vats (
    vat_id integer NOT NULL,
    vat_stavka numeric(4,2) NOT NULL,
    CONSTRAINT vats_valid CHECK (((vat_stavka > (0)::numeric) AND (vat_stavka < (100)::numeric)))
);
    DROP TABLE vat.vats;
       vat         heap    postgres    false    4            ?            1259    59021    vats_vat_id_seq    SEQUENCE     ?   CREATE SEQUENCE vat.vats_vat_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE vat.vats_vat_id_seq;
       vat          postgres    false    204    4            -           0    0    vats_vat_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE vat.vats_vat_id_seq OWNED BY vat.vats.vat_id;
          vat          postgres    false    203            f           2604    59280    adress adres_id    DEFAULT     p   ALTER TABLE ONLY adres.adress ALTER COLUMN adres_id SET DEFAULT nextval('adres.adress_adres_id_seq'::regclass);
 =   ALTER TABLE adres.adress ALTER COLUMN adres_id DROP DEFAULT;
       adres          postgres    false    214    213    214            c           2604    59133    countrys country_id    DEFAULT     x   ALTER TABLE ONLY adres.countrys ALTER COLUMN country_id SET DEFAULT nextval('adres.countrys_country_id_seq'::regclass);
 A   ALTER TABLE adres.countrys ALTER COLUMN country_id DROP DEFAULT;
       adres          postgres    false    208    207    208            e           2604    59175    streets street_id    DEFAULT     t   ALTER TABLE ONLY adres.streets ALTER COLUMN street_id SET DEFAULT nextval('adres.streets_street_id_seq'::regclass);
 ?   ALTER TABLE adres.streets ALTER COLUMN street_id DROP DEFAULT;
       adres          postgres    false    211    212    212            d           2604    59160    сities city_id    DEFAULT     t   ALTER TABLE ONLY adres."сities" ALTER COLUMN city_id SET DEFAULT nextval('adres."сities_city_id_seq"'::regclass);
 ?   ALTER TABLE adres."сities" ALTER COLUMN city_id DROP DEFAULT;
       adres          postgres    false    210    209    210            h           2604    59336    shippers shipper_id    DEFAULT     |   ALTER TABLE ONLY shipper.shippers ALTER COLUMN shipper_id SET DEFAULT nextval('shipper.shippers_shipper_id_seq'::regclass);
 C   ALTER TABLE shipper.shippers ALTER COLUMN shipper_id DROP DEFAULT;
       shipper          postgres    false    218    219    219            b           2604    59037    vatnames vatname_id    DEFAULT     t   ALTER TABLE ONLY vat.vatnames ALTER COLUMN vatname_id SET DEFAULT nextval('vat.vatnames_vatname_id_seq'::regclass);
 ?   ALTER TABLE vat.vatnames ALTER COLUMN vatname_id DROP DEFAULT;
       vat          postgres    false    205    206    206            `           2604    59026    vats vat_id    DEFAULT     d   ALTER TABLE ONLY vat.vats ALTER COLUMN vat_id SET DEFAULT nextval('vat.vats_vat_id_seq'::regclass);
 7   ALTER TABLE vat.vats ALTER COLUMN vat_id DROP DEFAULT;
       vat          postgres    false    203    204    204                      0    59277    adress 
   TABLE DATA           V   COPY adres.adress (adres_id, city_id, street_id, adres_index, adres_type) FROM stdin;
    adres          postgres    false    214   ?i                 0    59130    countrys 
   TABLE DATA           ?   COPY adres.countrys (country_id, vat_id, vatname_id, country_name, country_abbreviated_2, country_abbreviated_3, country_icon) FROM stdin;
    adres          postgres    false    208   ?i                 0    59172    streets 
   TABLE DATA           8   COPY adres.streets (street_id, street_name) FROM stdin;
    adres          postgres    false    212   ?m                 0    59157    сities 
   TABLE DATA           B   COPY adres."сities" (city_id, city_name, country_id) FROM stdin;
    adres          postgres    false    210   ?m                  0    59333    shippers 
   TABLE DATA           =   COPY shipper.shippers (shipper_id, shipper_name) FROM stdin;
    shipper          postgres    false    219   n                 0    59034    vatnames 
   TABLE DATA           9   COPY vat.vatnames (vatname_id, vatname_name) FROM stdin;
    vat          postgres    false    206   Tn                 0    59023    vats 
   TABLE DATA           /   COPY vat.vats (vat_id, vat_stavka) FROM stdin;
    vat          postgres    false    204   ?n       .           0    0    adress_adres_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('adres.adress_adres_id_seq', 2, true);
          adres          postgres    false    213            /           0    0    countrys_country_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('adres.countrys_country_id_seq', 39, true);
          adres          postgres    false    207            0           0    0    streets_street_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('adres.streets_street_id_seq', 12, true);
          adres          postgres    false    211            1           0    0    сities_city_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('adres."сities_city_id_seq"', 1, true);
          adres          postgres    false    209            2           0    0    shippers_shipper_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('shipper.shippers_shipper_id_seq', 20, true);
          shipper          postgres    false    218            3           0    0    vatnames_vatname_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('vat.vatnames_vatname_id_seq', 39, true);
          vat          postgres    false    205            4           0    0    vats_vat_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('vat.vats_vat_id_seq', 34, true);
          vat          postgres    false    203            ?           2606    59283    adress adress_pkey 
   CONSTRAINT     U   ALTER TABLE ONLY adres.adress
    ADD CONSTRAINT adress_pkey PRIMARY KEY (adres_id);
 ;   ALTER TABLE ONLY adres.adress DROP CONSTRAINT adress_pkey;
       adres            postgres    false    214            r           2606    59142 +   countrys countrys_country_abbreviated_2_key 
   CONSTRAINT     v   ALTER TABLE ONLY adres.countrys
    ADD CONSTRAINT countrys_country_abbreviated_2_key UNIQUE (country_abbreviated_2);
 T   ALTER TABLE ONLY adres.countrys DROP CONSTRAINT countrys_country_abbreviated_2_key;
       adres            postgres    false    208            t           2606    59144 +   countrys countrys_country_abbreviated_3_key 
   CONSTRAINT     v   ALTER TABLE ONLY adres.countrys
    ADD CONSTRAINT countrys_country_abbreviated_3_key UNIQUE (country_abbreviated_3);
 T   ALTER TABLE ONLY adres.countrys DROP CONSTRAINT countrys_country_abbreviated_3_key;
       adres            postgres    false    208            v           2606    59140 "   countrys countrys_country_name_key 
   CONSTRAINT     d   ALTER TABLE ONLY adres.countrys
    ADD CONSTRAINT countrys_country_name_key UNIQUE (country_name);
 K   ALTER TABLE ONLY adres.countrys DROP CONSTRAINT countrys_country_name_key;
       adres            postgres    false    208            x           2606    59138    countrys countrys_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY adres.countrys
    ADD CONSTRAINT countrys_pkey PRIMARY KEY (country_id);
 ?   ALTER TABLE ONLY adres.countrys DROP CONSTRAINT countrys_pkey;
       adres            postgres    false    208            ~           2606    59177    streets streets_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY adres.streets
    ADD CONSTRAINT streets_pkey PRIMARY KEY (street_id);
 =   ALTER TABLE ONLY adres.streets DROP CONSTRAINT streets_pkey;
       adres            postgres    false    212            ?           2606    59179    streets streets_street_name_key 
   CONSTRAINT     `   ALTER TABLE ONLY adres.streets
    ADD CONSTRAINT streets_street_name_key UNIQUE (street_name);
 H   ALTER TABLE ONLY adres.streets DROP CONSTRAINT streets_street_name_key;
       adres            postgres    false    212            z           2606    59164    сities сities_city_name_key 
   CONSTRAINT     `   ALTER TABLE ONLY adres."сities"
    ADD CONSTRAINT "сities_city_name_key" UNIQUE (city_name);
 J   ALTER TABLE ONLY adres."сities" DROP CONSTRAINT "сities_city_name_key";
       adres            postgres    false    210            |           2606    59162    сities сities_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY adres."сities"
    ADD CONSTRAINT "сities_pkey" PRIMARY KEY (city_id);
 A   ALTER TABLE ONLY adres."сities" DROP CONSTRAINT "сities_pkey";
       adres            postgres    false    210            ?           2606    59338     shippers shippers_shipper_id_key 
   CONSTRAINT     b   ALTER TABLE ONLY shipper.shippers
    ADD CONSTRAINT shippers_shipper_id_key UNIQUE (shipper_id);
 K   ALTER TABLE ONLY shipper.shippers DROP CONSTRAINT shippers_shipper_id_key;
       shipper            postgres    false    219            ?           2606    59340 "   shippers shippers_shipper_name_key 
   CONSTRAINT     f   ALTER TABLE ONLY shipper.shippers
    ADD CONSTRAINT shippers_shipper_name_key UNIQUE (shipper_name);
 M   ALTER TABLE ONLY shipper.shippers DROP CONSTRAINT shippers_shipper_name_key;
       shipper            postgres    false    219            n           2606    59039    vatnames vatnames_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY vat.vatnames
    ADD CONSTRAINT vatnames_pkey PRIMARY KEY (vatname_id);
 =   ALTER TABLE ONLY vat.vatnames DROP CONSTRAINT vatnames_pkey;
       vat            postgres    false    206            p           2606    59041 "   vatnames vatnames_vatname_name_key 
   CONSTRAINT     b   ALTER TABLE ONLY vat.vatnames
    ADD CONSTRAINT vatnames_vatname_name_key UNIQUE (vatname_name);
 I   ALTER TABLE ONLY vat.vatnames DROP CONSTRAINT vatnames_vatname_name_key;
       vat            postgres    false    206            j           2606    59029    vats vats_pkey 
   CONSTRAINT     M   ALTER TABLE ONLY vat.vats
    ADD CONSTRAINT vats_pkey PRIMARY KEY (vat_id);
 5   ALTER TABLE ONLY vat.vats DROP CONSTRAINT vats_pkey;
       vat            postgres    false    204            l           2606    59031    vats vats_vat_stavka_key 
   CONSTRAINT     V   ALTER TABLE ONLY vat.vats
    ADD CONSTRAINT vats_vat_stavka_key UNIQUE (vat_stavka);
 ?   ALTER TABLE ONLY vat.vats DROP CONSTRAINT vats_vat_stavka_key;
       vat            postgres    false    204            ?           2606    59284    adress adress_city_id_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY adres.adress
    ADD CONSTRAINT adress_city_id_fkey FOREIGN KEY (city_id) REFERENCES adres."сities"(city_id) ON DELETE SET NULL;
 C   ALTER TABLE ONLY adres.adress DROP CONSTRAINT adress_city_id_fkey;
       adres          postgres    false    2940    214    210            ?           2606    59289    adress adress_street_id_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY adres.adress
    ADD CONSTRAINT adress_street_id_fkey FOREIGN KEY (street_id) REFERENCES adres.streets(street_id) ON DELETE SET NULL;
 E   ALTER TABLE ONLY adres.adress DROP CONSTRAINT adress_street_id_fkey;
       adres          postgres    false    2942    212    214            ?           2606    59145    countrys countrys_vat_id_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY adres.countrys
    ADD CONSTRAINT countrys_vat_id_fkey FOREIGN KEY (vat_id) REFERENCES vat.vats(vat_id) ON UPDATE SET NULL ON DELETE SET NULL;
 F   ALTER TABLE ONLY adres.countrys DROP CONSTRAINT countrys_vat_id_fkey;
       adres          postgres    false    208    2922    204            ?           2606    59150 !   countrys countrys_vatname_id_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY adres.countrys
    ADD CONSTRAINT countrys_vatname_id_fkey FOREIGN KEY (vatname_id) REFERENCES vat.vatnames(vatname_id) ON UPDATE SET NULL ON DELETE SET NULL;
 J   ALTER TABLE ONLY adres.countrys DROP CONSTRAINT countrys_vatname_id_fkey;
       adres          postgres    false    2926    206    208            ?           2606    59165    сities сities_country_id_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY adres."сities"
    ADD CONSTRAINT "сities_country_id_fkey" FOREIGN KEY (country_id) REFERENCES adres.countrys(country_id) ON DELETE RESTRICT;
 L   ALTER TABLE ONLY adres."сities" DROP CONSTRAINT "сities_country_id_fkey";
       adres          postgres    false    2936    208    210                       0    59312    testadressview    MATERIALIZED VIEW DATA     0   REFRESH MATERIALIZED VIEW adres.testadressview;
          adres          postgres    false    216    3106                       0    59320    testadressview    MATERIALIZED VIEW DATA     1   REFRESH MATERIALIZED VIEW public.testadressview;
          public          postgres    false    217    3106               9   x?3?4?4"#c?K.l???bӅ?/l??xaׅvr?T 	C##\Jb???? i$1         ?  x?U?]o?Vǯ?~T;i^.??@7???hr?Cjű#ǆ?UZB?1v1?Ec?v3?%?T(??p???αæ?uz?{?y?^b?????|?????B^?/?5??7 ???I?_?E?-?I??\?+?1_????(?}?ڶCG"??l??
U?T)???\jЂl?A6U`?V???k???H?}Y8??v????Nep)?#?\???L?U؍6?P?ݙ?x?wjԤ?^?e??M??q???????x%W?>ln޳ ??"???F???? ??_)?"F=ڣH??"	?h?mi?QA"??U?D??@?4N?
E?d??m??~?K{?.?D4????N ????i?v,?86???5k??8??v!?????z8?i???B}??? ? j\)@.?q ?(H?Pe착???ԧ|A???>??~1j?IT?'???|?n???~z?????:s??;#{ y?q?G%? n74?(
??U???5??B??"?????&??̿??a?
mp?v_?%??%???bzg?X??6W???Mȟ????}?6?ô? n,???/????߃Z4??Q|?`Mn??.?U1C?ȡ(N???^?Bf?p?_?b<???m??4?7e5???? ???x⊪??w??4??????!_#??vǃ\B???j?q}??^?????_?ȣ$?n?b??F??750??s?u?4?Q?5k0?e?UƸ3?v?=??<?Q?nr??Ы"???hQfPQ??)??C8ph?9?f?DhW+\-?4?	\??3?Z?u?a&	?@?kE?N?FAW???t]?@=?D?2??(?ިk?E??Ew?*? 7zU??g?<jo9?!??O??R3??_??5?X?0?a??,tX?^?$?1j??f?y???ېEÇ??;??eGa0?t?????[Y????z?&d??~?>??N?4?E?B?/u-r?`X`?i??^????o2/???}3 1O??z_]????c?!            x?34?I-.?24ӆ\1z\\\ ?            x?3?I-.?4?????? ??          /   x?3?))I-.?24???́L???g???,(H-?????? k?'         ?   x??A
?0D?3???????H(?-$??!xq+??r$?Ճ?3????"?0??oML?{8?!??v???#??RZ??-??PNe$=?t?
<e?V??U?+ָ5ի?'???Z.Q?u???y?i?T???^4
{.?????#?yk+?         ?   x?%??D!B?X?'࿗鿎!y?k ???? k????-P9n???K\?ăN??:,?o3?Y?	??+r27f??Y??O?Pa
??P??*w,?&???Y???w?E?sQ?zn?y??h???)'$ݳ?9ܳ??Z??,G     