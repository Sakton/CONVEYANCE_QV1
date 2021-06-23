PGDMP                         y            demo_coveyance_db    13.1    13.3     �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    50208    demo_coveyance_db    DATABASE     n   CREATE DATABASE demo_coveyance_db WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Russian_Russia.1251';
 !   DROP DATABASE demo_coveyance_db;
                postgres    false            �            1259    50309    adress    TABLE     P  CREATE TABLE public.adress (
    adres_id integer NOT NULL,
    country_id integer,
    city_id integer,
    street_id integer,
    adres_type public.type_adress,
    adres_index character varying(10),
    CONSTRAINT adress_adres_type_check CHECK ((adres_type = ANY (ARRAY['FACT'::public.type_adress, 'LEGAL'::public.type_adress])))
);
    DROP TABLE public.adress;
       public         heap    postgres    false            �            1259    50307    adress_adres_id_seq    SEQUENCE     �   CREATE SEQUENCE public.adress_adres_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.adress_adres_id_seq;
       public          postgres    false    207            �           0    0    adress_adres_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.adress_adres_id_seq OWNED BY public.adress.adres_id;
          public          postgres    false    206            J           2604    50312    adress adres_id    DEFAULT     r   ALTER TABLE ONLY public.adress ALTER COLUMN adres_id SET DEFAULT nextval('public.adress_adres_id_seq'::regclass);
 >   ALTER TABLE public.adress ALTER COLUMN adres_id DROP DEFAULT;
       public          postgres    false    207    206    207            �          0    50309    adress 
   TABLE DATA           c   COPY public.adress (adres_id, country_id, city_id, street_id, adres_type, adres_index) FROM stdin;
    public          postgres    false    207   �       �           0    0    adress_adres_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.adress_adres_id_seq', 10, true);
          public          postgres    false    206            M           2606    50315    adress adress_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.adress
    ADD CONSTRAINT adress_pkey PRIMARY KEY (adres_id);
 <   ALTER TABLE ONLY public.adress DROP CONSTRAINT adress_pkey;
       public            postgres    false    207            N           2606    50321    adress adress_city_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.adress
    ADD CONSTRAINT adress_city_id_fkey FOREIGN KEY (city_id) REFERENCES public.cities(city_id) ON DELETE SET NULL;
 D   ALTER TABLE ONLY public.adress DROP CONSTRAINT adress_city_id_fkey;
       public          postgres    false    207            O           2606    50326    adress adress_street_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.adress
    ADD CONSTRAINT adress_street_id_fkey FOREIGN KEY (street_id) REFERENCES public.streets(street_id) ON DELETE SET NULL;
 F   ALTER TABLE ONLY public.adress DROP CONSTRAINT adress_street_id_fkey;
       public          postgres    false    207            �   \   x�]�;
�0E�z�^"�K&)E������!FH��p�N*T)�܏��M�5U�ק�!�,Hm*K*b���8k0�И�6��'���_h��}� ���     