PGDMP     #                    y            demo_coveyance_db    13.1    13.3                0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false                       0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false                       0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            	           1262    58757    demo_coveyance_db    DATABASE     n   CREATE DATABASE demo_coveyance_db WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Russian_Russia.1251';
 !   DROP DATABASE demo_coveyance_db;
                postgres    false            �            1259    58972    emploees    TABLE     l   CREATE TABLE emploee.emploees (
    emploee_id integer NOT NULL,
    emploee_name character varying(200)
);
    DROP TABLE emploee.emploees;
       emploee         heap    postgres    false            �            1259    58970    emploees_emploee_id_seq    SEQUENCE     �   CREATE SEQUENCE emploee.emploees_emploee_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE emploee.emploees_emploee_id_seq;
       emploee          postgres    false    229            
           0    0    emploees_emploee_id_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE emploee.emploees_emploee_id_seq OWNED BY emploee.emploees.emploee_id;
          emploee          postgres    false    228            |           2604    58975    emploees emploee_id    DEFAULT     |   ALTER TABLE ONLY emploee.emploees ALTER COLUMN emploee_id SET DEFAULT nextval('emploee.emploees_emploee_id_seq'::regclass);
 C   ALTER TABLE emploee.emploees ALTER COLUMN emploee_id DROP DEFAULT;
       emploee          postgres    false    228    229    229                      0    58972    emploees 
   TABLE DATA           =   COPY emploee.emploees (emploee_id, emploee_name) FROM stdin;
    emploee          postgres    false    229                     0    0    emploees_emploee_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('emploee.emploees_emploee_id_seq', 2, true);
          emploee          postgres    false    228            ~           2606    58977     emploees emploees_emploee_id_key 
   CONSTRAINT     b   ALTER TABLE ONLY emploee.emploees
    ADD CONSTRAINT emploees_emploee_id_key UNIQUE (emploee_id);
 K   ALTER TABLE ONLY emploee.emploees DROP CONSTRAINT emploees_emploee_id_key;
       emploee            postgres    false    229               3   x�3�0���{.캰A������_�w��������ɢ+����� �1�     