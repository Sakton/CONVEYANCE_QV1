PGDMP                         y            conveyance_db    13.1    13.4     Y           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            Z           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            [           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            \           1262    16982    conveyance_db    DATABASE     j   CREATE DATABASE conveyance_db WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Russian_Russia.1251';
    DROP DATABASE conveyance_db;
                postgres    false                       1259    17469    autos    TABLE     "  CREATE TABLE wagons.autos (
    auto_id integer NOT NULL,
    auto_brand character varying(64),
    auto_lenthtrailer numeric(4,2),
    auto_widthtrailer numeric(4,2),
    auto_heighttrailer numeric(4,2),
    auto_vin character varying(17),
    auto_datawork date,
    auto_datagto date
);
    DROP TABLE wagons.autos;
       wagons         heap    postgres    false                       1259    17467    autos_auto_id_seq    SEQUENCE     ?   CREATE SEQUENCE wagons.autos_auto_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE wagons.autos_auto_id_seq;
       wagons          postgres    false    259            ]           0    0    autos_auto_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE wagons.autos_auto_id_seq OWNED BY wagons.autos.auto_id;
          wagons          postgres    false    258            ?           2604    17472    autos auto_id    DEFAULT     n   ALTER TABLE ONLY wagons.autos ALTER COLUMN auto_id SET DEFAULT nextval('wagons.autos_auto_id_seq'::regclass);
 <   ALTER TABLE wagons.autos ALTER COLUMN auto_id DROP DEFAULT;
       wagons          postgres    false    258    259    259            V          0    17469    autos 
   TABLE DATA           ?   COPY wagons.autos (auto_id, auto_brand, auto_lenthtrailer, auto_widthtrailer, auto_heighttrailer, auto_vin, auto_datawork, auto_datagto) FROM stdin;
    wagons          postgres    false    259   ?       ^           0    0    autos_auto_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('wagons.autos_auto_id_seq', 1, true);
          wagons          postgres    false    258            ?           2606    17476    autos autos_auto_vin_key 
   CONSTRAINT     W   ALTER TABLE ONLY wagons.autos
    ADD CONSTRAINT autos_auto_vin_key UNIQUE (auto_vin);
 B   ALTER TABLE ONLY wagons.autos DROP CONSTRAINT autos_auto_vin_key;
       wagons            postgres    false    259            ?           2606    17474    autos autos_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY wagons.autos
    ADD CONSTRAINT autos_pkey PRIMARY KEY (auto_id);
 :   ALTER TABLE ONLY wagons.autos DROP CONSTRAINT autos_pkey;
       wagons            postgres    false    259            V   =   x?3??0??֋/l???j?44?32?4??F?F?F??@d?&??\1z\\\ C?J     