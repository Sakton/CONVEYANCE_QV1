PGDMP     2                    y            demo_coveyance_db    13.1    13.3 C               0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false                       0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false                       0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            	           1262    50208    demo_coveyance_db    DATABASE     n   CREATE DATABASE demo_coveyance_db WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Russian_Russia.1251';
 !   DROP DATABASE demo_coveyance_db;
                postgres    false            �           1247    50278    type_adress    TYPE     D   CREATE TYPE public.type_adress AS ENUM (
    'FACT',
    'LEGAL'
);
    DROP TYPE public.type_adress;
       public          postgres    false            �            1255    58594    get_vat_id(real)    FUNCTION     �   CREATE FUNCTION public.get_vat_id(vat_st real) RETURNS integer
    LANGUAGE sql
    AS $$ SELECT vat_id FROM vats WHERE vat_stavka = vat_st; $$;
 .   DROP FUNCTION public.get_vat_id(vat_st real);
       public          postgres    false            �            1255    50268    get_vat_id(numeric)    FUNCTION     �   CREATE FUNCTION public.get_vat_id(vat_st numeric) RETURNS integer
    LANGUAGE sql
    AS $$ SELECT vat_id FROM vats WHERE vat_stavka = vat_st; $$;
 1   DROP FUNCTION public.get_vat_id(vat_st numeric);
       public          postgres    false            �            1255    50333    id_city(character varying)    FUNCTION     �   CREATE FUNCTION public.id_city(ct character varying) RETURNS integer
    LANGUAGE sql
    AS $$ SELECT city_id FROM cities WHERE city_name = ct $$;
 4   DROP FUNCTION public.id_city(ct character varying);
       public          postgres    false            �            1255    50332    id_country(character varying)    FUNCTION     �   CREATE FUNCTION public.id_country(cntr character varying) RETURNS integer
    LANGUAGE sql
    AS $$SELECT country_id FROM countrys WHERE country_name = cntr$$;
 9   DROP FUNCTION public.id_country(cntr character varying);
       public          postgres    false            �            1255    50335    id_street(character varying)    FUNCTION     �   CREATE FUNCTION public.id_street(st character varying) RETURNS integer
    LANGUAGE sql
    AS $$SELECT street_id FROM streets WHERE street_name = st$$;
 6   DROP FUNCTION public.id_street(st character varying);
       public          postgres    false            �            1255    58581    id_vatnames(character varying)    FUNCTION     �   CREATE FUNCTION public.id_vatnames(nm character varying) RETURNS integer
    LANGUAGE sql
    AS $$ SELECT vatname_id FROM vatnames WHERE vatname_name = nm $$;
 8   DROP FUNCTION public.id_vatnames(nm character varying);
       public          postgres    false            �            1255    50337 Z   insert_adress(character varying, character varying, character varying, public.type_adress)    FUNCTION     �  CREATE FUNCTION public.insert_adress(cntr character varying, ct character varying, strt character varying, type_adress public.type_adress DEFAULT 'FACT'::public.type_adress) RETURNS void
    LANGUAGE sql
    AS $$ INSERT INTO adress ( country_id, city_id, street_id, adres_type )
VALUES (  ( SELECT id_country( cntr ) ), ( SELECT id_city( ct ) ), ( SELECT id_street( strt ) ), type_adress )$$;
 �   DROP FUNCTION public.insert_adress(cntr character varying, ct character varying, strt character varying, type_adress public.type_adress);
       public          postgres    false    653    653            �            1259    50309    adress    TABLE     P  CREATE TABLE public.adress (
    adres_id integer NOT NULL,
    country_id integer,
    city_id integer,
    street_id integer,
    adres_type public.type_adress,
    adres_index character varying(10),
    CONSTRAINT adress_adres_type_check CHECK ((adres_type = ANY (ARRAY['FACT'::public.type_adress, 'LEGAL'::public.type_adress])))
);
    DROP TABLE public.adress;
       public         heap    postgres    false    653    653            �            1259    50307    adress_adres_id_seq    SEQUENCE     �   CREATE SEQUENCE public.adress_adres_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.adress_adres_id_seq;
       public          postgres    false    207            
           0    0    adress_adres_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.adress_adres_id_seq OWNED BY public.adress.adres_id;
          public          postgres    false    206            �            1259    50218    cities    TABLE     l   CREATE TABLE public.cities (
    city_id integer NOT NULL,
    city_name character varying(256) NOT NULL
);
    DROP TABLE public.cities;
       public         heap    postgres    false            �            1259    58555    countrys    TABLE     M  CREATE TABLE public.countrys (
    country_id integer NOT NULL,
    vat_id integer NOT NULL,
    vatname_id integer NOT NULL,
    country_name character varying(256) NOT NULL,
    country_abbreviated_2 character varying(4) NOT NULL,
    country_abbreviated_3 character varying(4) NOT NULL,
    country_icon character varying(256)
);
    DROP TABLE public.countrys;
       public         heap    postgres    false            �            1259    58553    countrys_country_id_seq    SEQUENCE     �   CREATE SEQUENCE public.countrys_country_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.countrys_country_id_seq;
       public          postgres    false    209                       0    0    countrys_country_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.countrys_country_id_seq OWNED BY public.countrys.country_id;
          public          postgres    false    208            �            1259    50216    sities_city_id_seq    SEQUENCE     �   CREATE SEQUENCE public.sities_city_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.sities_city_id_seq;
       public          postgres    false    203                       0    0    sities_city_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.sities_city_id_seq OWNED BY public.cities.city_id;
          public          postgres    false    202            �            1259    50232    streets    TABLE     q   CREATE TABLE public.streets (
    street_id integer NOT NULL,
    street_name character varying(256) NOT NULL
);
    DROP TABLE public.streets;
       public         heap    postgres    false            �            1259    50230    streets_street_id_seq    SEQUENCE     �   CREATE SEQUENCE public.streets_street_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.streets_street_id_seq;
       public          postgres    false    205                       0    0    streets_street_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.streets_street_id_seq OWNED BY public.streets.street_id;
          public          postgres    false    204            �            1259    58586    vatnames    TABLE     j   CREATE TABLE public.vatnames (
    vatname_id integer NOT NULL,
    vatname_name character varying(10)
);
    DROP TABLE public.vatnames;
       public         heap    postgres    false            �            1259    58584    vatnames_vatname_id_seq    SEQUENCE     �   CREATE SEQUENCE public.vatnames_vatname_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.vatnames_vatname_id_seq;
       public          postgres    false    211                       0    0    vatnames_vatname_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.vatnames_vatname_id_seq OWNED BY public.vatnames.vatname_id;
          public          postgres    false    210            �            1259    50211    vats    TABLE     �   CREATE TABLE public.vats (
    vat_id integer NOT NULL,
    vat_stavka numeric(4,2) NOT NULL,
    CONSTRAINT vats_valid CHECK (((vat_stavka > (0)::numeric) AND (vat_stavka < (100)::numeric)))
);
    DROP TABLE public.vats;
       public         heap    postgres    false            �            1259    50209    vats_vat_id_seq    SEQUENCE     �   CREATE SEQUENCE public.vats_vat_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.vats_vat_id_seq;
       public          postgres    false    201                       0    0    vats_vat_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.vats_vat_id_seq OWNED BY public.vats.vat_id;
          public          postgres    false    200            O           2604    50312    adress adres_id    DEFAULT     r   ALTER TABLE ONLY public.adress ALTER COLUMN adres_id SET DEFAULT nextval('public.adress_adres_id_seq'::regclass);
 >   ALTER TABLE public.adress ALTER COLUMN adres_id DROP DEFAULT;
       public          postgres    false    206    207    207            M           2604    50221    cities city_id    DEFAULT     p   ALTER TABLE ONLY public.cities ALTER COLUMN city_id SET DEFAULT nextval('public.sities_city_id_seq'::regclass);
 =   ALTER TABLE public.cities ALTER COLUMN city_id DROP DEFAULT;
       public          postgres    false    202    203    203            Q           2604    58558    countrys country_id    DEFAULT     z   ALTER TABLE ONLY public.countrys ALTER COLUMN country_id SET DEFAULT nextval('public.countrys_country_id_seq'::regclass);
 B   ALTER TABLE public.countrys ALTER COLUMN country_id DROP DEFAULT;
       public          postgres    false    209    208    209            N           2604    50235    streets street_id    DEFAULT     v   ALTER TABLE ONLY public.streets ALTER COLUMN street_id SET DEFAULT nextval('public.streets_street_id_seq'::regclass);
 @   ALTER TABLE public.streets ALTER COLUMN street_id DROP DEFAULT;
       public          postgres    false    204    205    205            R           2604    58589    vatnames vatname_id    DEFAULT     z   ALTER TABLE ONLY public.vatnames ALTER COLUMN vatname_id SET DEFAULT nextval('public.vatnames_vatname_id_seq'::regclass);
 B   ALTER TABLE public.vatnames ALTER COLUMN vatname_id DROP DEFAULT;
       public          postgres    false    210    211    211            K           2604    50214    vats vat_id    DEFAULT     j   ALTER TABLE ONLY public.vats ALTER COLUMN vat_id SET DEFAULT nextval('public.vats_vat_id_seq'::regclass);
 :   ALTER TABLE public.vats ALTER COLUMN vat_id DROP DEFAULT;
       public          postgres    false    201    200    201            �          0    50309    adress 
   TABLE DATA           c   COPY public.adress (adres_id, country_id, city_id, street_id, adres_type, adres_index) FROM stdin;
    public          postgres    false    207   OP       �          0    50218    cities 
   TABLE DATA           4   COPY public.cities (city_id, city_name) FROM stdin;
    public          postgres    false    203   P                 0    58555    countrys 
   TABLE DATA           �   COPY public.countrys (country_id, vat_id, vatname_id, country_name, country_abbreviated_2, country_abbreviated_3, country_icon) FROM stdin;
    public          postgres    false    209   �P       �          0    50232    streets 
   TABLE DATA           9   COPY public.streets (street_id, street_name) FROM stdin;
    public          postgres    false    205   �T                 0    58586    vatnames 
   TABLE DATA           <   COPY public.vatnames (vatname_id, vatname_name) FROM stdin;
    public          postgres    false    211   jU       �          0    50211    vats 
   TABLE DATA           2   COPY public.vats (vat_id, vat_stavka) FROM stdin;
    public          postgres    false    201   V                  0    0    adress_adres_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.adress_adres_id_seq', 2, true);
          public          postgres    false    206                       0    0    countrys_country_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.countrys_country_id_seq', 53, true);
          public          postgres    false    208                       0    0    sities_city_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.sities_city_id_seq', 8, true);
          public          postgres    false    202                       0    0    streets_street_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.streets_street_id_seq', 7, true);
          public          postgres    false    204                       0    0    vatnames_vatname_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.vatnames_vatname_id_seq', 39, true);
          public          postgres    false    210                       0    0    vats_vat_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.vats_vat_id_seq', 43, true);
          public          postgres    false    200            f           2606    50315    adress adress_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.adress
    ADD CONSTRAINT adress_pkey PRIMARY KEY (adres_id);
 <   ALTER TABLE ONLY public.adress DROP CONSTRAINT adress_pkey;
       public            postgres    false    207            h           2606    58567 +   countrys countrys_country_abbreviated_2_key 
   CONSTRAINT     w   ALTER TABLE ONLY public.countrys
    ADD CONSTRAINT countrys_country_abbreviated_2_key UNIQUE (country_abbreviated_2);
 U   ALTER TABLE ONLY public.countrys DROP CONSTRAINT countrys_country_abbreviated_2_key;
       public            postgres    false    209            j           2606    58569 +   countrys countrys_country_abbreviated_3_key 
   CONSTRAINT     w   ALTER TABLE ONLY public.countrys
    ADD CONSTRAINT countrys_country_abbreviated_3_key UNIQUE (country_abbreviated_3);
 U   ALTER TABLE ONLY public.countrys DROP CONSTRAINT countrys_country_abbreviated_3_key;
       public            postgres    false    209            l           2606    58565 "   countrys countrys_country_name_key 
   CONSTRAINT     e   ALTER TABLE ONLY public.countrys
    ADD CONSTRAINT countrys_country_name_key UNIQUE (country_name);
 L   ALTER TABLE ONLY public.countrys DROP CONSTRAINT countrys_country_name_key;
       public            postgres    false    209            n           2606    58563    countrys countrys_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.countrys
    ADD CONSTRAINT countrys_pkey PRIMARY KEY (country_id);
 @   ALTER TABLE ONLY public.countrys DROP CONSTRAINT countrys_pkey;
       public            postgres    false    209            Z           2606    50272    cities sities_city_id_key 
   CONSTRAINT     W   ALTER TABLE ONLY public.cities
    ADD CONSTRAINT sities_city_id_key UNIQUE (city_id);
 C   ALTER TABLE ONLY public.cities DROP CONSTRAINT sities_city_id_key;
       public            postgres    false    203            \           2606    50223    cities sities_city_name_key 
   CONSTRAINT     [   ALTER TABLE ONLY public.cities
    ADD CONSTRAINT sities_city_name_key UNIQUE (city_name);
 E   ALTER TABLE ONLY public.cities DROP CONSTRAINT sities_city_name_key;
       public            postgres    false    203            ^           2606    50250    cities sities_city_name_key1 
   CONSTRAINT     \   ALTER TABLE ONLY public.cities
    ADD CONSTRAINT sities_city_name_key1 UNIQUE (city_name);
 F   ALTER TABLE ONLY public.cities DROP CONSTRAINT sities_city_name_key1;
       public            postgres    false    203            `           2606    50242    cities sities_pkey 
   CONSTRAINT     U   ALTER TABLE ONLY public.cities
    ADD CONSTRAINT sities_pkey PRIMARY KEY (city_id);
 <   ALTER TABLE ONLY public.cities DROP CONSTRAINT sities_pkey;
       public            postgres    false    203            b           2606    50244    streets streets_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY public.streets
    ADD CONSTRAINT streets_pkey PRIMARY KEY (street_id);
 >   ALTER TABLE ONLY public.streets DROP CONSTRAINT streets_pkey;
       public            postgres    false    205            d           2606    50274    streets streets_street_id_key 
   CONSTRAINT     ]   ALTER TABLE ONLY public.streets
    ADD CONSTRAINT streets_street_id_key UNIQUE (street_id);
 G   ALTER TABLE ONLY public.streets DROP CONSTRAINT streets_street_id_key;
       public            postgres    false    205            p           2606    58591    vatnames vatnames_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.vatnames
    ADD CONSTRAINT vatnames_pkey PRIMARY KEY (vatname_id);
 @   ALTER TABLE ONLY public.vatnames DROP CONSTRAINT vatnames_pkey;
       public            postgres    false    211            r           2606    58593 "   vatnames vatnames_vatname_name_key 
   CONSTRAINT     e   ALTER TABLE ONLY public.vatnames
    ADD CONSTRAINT vatnames_vatname_name_key UNIQUE (vatname_name);
 L   ALTER TABLE ONLY public.vatnames DROP CONSTRAINT vatnames_vatname_name_key;
       public            postgres    false    211            T           2606    50240    vats vats_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.vats
    ADD CONSTRAINT vats_pkey PRIMARY KEY (vat_id);
 8   ALTER TABLE ONLY public.vats DROP CONSTRAINT vats_pkey;
       public            postgres    false    201            V           2606    50270    vats vats_vat_id_key 
   CONSTRAINT     Q   ALTER TABLE ONLY public.vats
    ADD CONSTRAINT vats_vat_id_key UNIQUE (vat_id);
 >   ALTER TABLE ONLY public.vats DROP CONSTRAINT vats_vat_id_key;
       public            postgres    false    201            X           2606    50248    vats vats_vat_stavka_key 
   CONSTRAINT     Y   ALTER TABLE ONLY public.vats
    ADD CONSTRAINT vats_vat_stavka_key UNIQUE (vat_stavka);
 B   ALTER TABLE ONLY public.vats DROP CONSTRAINT vats_vat_stavka_key;
       public            postgres    false    201            s           2606    50321    adress adress_city_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.adress
    ADD CONSTRAINT adress_city_id_fkey FOREIGN KEY (city_id) REFERENCES public.cities(city_id) ON DELETE SET NULL;
 D   ALTER TABLE ONLY public.adress DROP CONSTRAINT adress_city_id_fkey;
       public          postgres    false    203    2912    207            t           2606    50326    adress adress_street_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.adress
    ADD CONSTRAINT adress_street_id_fkey FOREIGN KEY (street_id) REFERENCES public.streets(street_id) ON DELETE SET NULL;
 F   ALTER TABLE ONLY public.adress DROP CONSTRAINT adress_street_id_fkey;
       public          postgres    false    2914    207    205            u           2606    58570    countrys countrys_vat_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.countrys
    ADD CONSTRAINT countrys_vat_id_fkey FOREIGN KEY (vat_id) REFERENCES public.vats(vat_id) ON UPDATE SET NULL ON DELETE SET NULL;
 G   ALTER TABLE ONLY public.countrys DROP CONSTRAINT countrys_vat_id_fkey;
       public          postgres    false    2900    209    201            �       x�3��"7G� �e�Xp��b���� �a!      �   n   x�%�M�@@�u{X`��q͂�^�MG�� 5�L����^���X���:#��\<f��n/0&6])~�+t���_ޠ�,��;��Y��rT�����"~ �2#�         �  x�U��n�F����R�(Y�d3� Z(�m�-mdB)Pd��Jv� @�����4mS�7���8N^a�F�gw������YY5��E�k��<)O˹�,_Pӧf�SX��,
oL�ц��B���W�}9/!�D���r=:q�3�שF����r�ArE�D��2�y�̴�ڃ���Gẇm�5�ߪ.�[Ĝ+�T��k����Z�GE�bxg%�a�KU6�A[:�Z.L�[ԥ�"A���:��\z��M��Hd�01h5H��v.~����u]h���,��M�&h�A/�'*5>u�ۡQ&�@h�Ju�6I~��~�v��dfcMՈ��++��P�s)���׵*���C����?���uN��lF��`�m@6�J'��&Ey�1m���1��vnC=<�����p�'���|��P��0�gV���3v��3r}(�8ʏ�0YqBM,����S����&�9��\$�\��mB�
,��o��Kl�9�}.��g_��QZd#×~���y���>:��qn:�K�f��M� �?rj�$���=�n�{��
�ni�{ y����PO֮��U��iQ�)��\��4M�~ڼ���p���#�5cWϧ����b�:�o�%_"`u�^ �	��̜��0���%2�+��=����t�v�jqB8��:�s����h&��Va���6g�h�C���bi��m�>�����~tW�b�ۄ=������|�������BO��Fa�������yFA��ޕq���'ZU�Ǻ�W
�*_�o�f���(Y{P��x��^�nzP��fabN��`�1�?��|��Cdi��>�/�ٿ�X�1���R���~��j%�q1�RR�S�s�c�|94x�s���iqG�6K���j�o���޹94����C*��R�+��?eV��Ҙ�s�w��/�6O��'�'1�ӕq_��������      �   �   x�-�9�0E�S���%%�]�����XJ�h<���0\�P��7�Bb!ƫ�3xK�	3�Rc)�9�{�\�}O$C�0ֶ���\�+�������6𑼾T�A���Y`��,3�0�         �   x��A
�0D�3���?���H(�-$��!xq+�r$�Ճ�3���"�0��oML�{8�!��v��#��RZ��-��PNe$=�t�
<e�V��U�+ָ5ի�'��Z.Q�u���y�i�T�^4
{.����#�yk+�      �   �   x�%��D!Ϣ�I�������iJ�X}�F�-&�+Np�f��_�CF��v���K\�ac����WI8�	NVe�ʍٯxn��S|x+�`R+��ZaeNxVVi).����u�C�C#�H��տ�Z�,�     