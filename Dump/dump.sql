PGDMP     $    +                y            demo_coveyance_db    13.1    13.3     �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    50208    demo_coveyance_db    DATABASE     n   CREATE DATABASE demo_coveyance_db WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Russian_Russia.1251';
 !   DROP DATABASE demo_coveyance_db;
                postgres    false            �            1259    50232    streets    TABLE     q   CREATE TABLE public.streets (
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
       public          postgres    false    205            �           0    0    streets_street_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.streets_street_id_seq OWNED BY public.streets.street_id;
          public          postgres    false    204            J           2604    50235    streets street_id    DEFAULT     v   ALTER TABLE ONLY public.streets ALTER COLUMN street_id SET DEFAULT nextval('public.streets_street_id_seq'::regclass);
 @   ALTER TABLE public.streets ALTER COLUMN street_id DROP DEFAULT;
       public          postgres    false    205    204    205            �          0    50232    streets 
   TABLE DATA           9   COPY public.streets (street_id, street_name) FROM stdin;
    public          postgres    false    205   `       �           0    0    streets_street_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.streets_street_id_seq', 33, true);
          public          postgres    false    204            L           2606    50244    streets streets_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY public.streets
    ADD CONSTRAINT streets_pkey PRIMARY KEY (street_id);
 >   ALTER TABLE ONLY public.streets DROP CONSTRAINT streets_pkey;
       public            postgres    false    205            N           2606    50274    streets streets_street_id_key 
   CONSTRAINT     ]   ALTER TABLE ONLY public.streets
    ADD CONSTRAINT streets_street_id_key UNIQUE (street_id);
 G   ALTER TABLE ONLY public.streets DROP CONSTRAINT streets_street_id_key;
       public            postgres    false    205            P           2606    58620    streets streets_street_name_key 
   CONSTRAINT     a   ALTER TABLE ONLY public.streets
    ADD CONSTRAINT streets_street_name_key UNIQUE (street_name);
 I   ALTER TABLE ONLY public.streets DROP CONSTRAINT streets_street_name_key;
       public            postgres    false    205            �     x�-�AN�0E��O��q�4+T$D%*JP7l�f��J�Q����
K�\ �ӄ'����|�PT�BWWO�2��L�t��g�x}z/�T�z�����j��ԡ/�Hi�_K-���]O�Q^Cx���Z��%Q�#��i�̦��hx�0��`�t+>������*��3ꦊ�c�����Rs�����b1i"�Z&��
�Ps81l�)���wsȲ8���}o~�7xD/{q���x�a${��!�e�r�XK��� � �Ses     