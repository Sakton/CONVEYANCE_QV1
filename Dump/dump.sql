PGDMP     5                    y            conveyance_db    13.1    13.4     D           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            E           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            F           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            G           1262    16982    conveyance_db    DATABASE     j   CREATE DATABASE conveyance_db WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Russian_Russia.1251';
    DROP DATABASE conveyance_db;
                postgres    false            �            1259    17342    description_semitrailers    TABLE     �   CREATE TABLE cars.description_semitrailers (
    description_semitrailer_id integer NOT NULL,
    description_semitrailer_description text
);
 *   DROP TABLE cars.description_semitrailers;
       cars         heap    postgres    false            �            1259    17340 7   description_semitrailers_description_semitrailer_id_seq    SEQUENCE     �   CREATE SEQUENCE cars.description_semitrailers_description_semitrailer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 L   DROP SEQUENCE cars.description_semitrailers_description_semitrailer_id_seq;
       cars          postgres    false    250            H           0    0 7   description_semitrailers_description_semitrailer_id_seq    SEQUENCE OWNED BY     �   ALTER SEQUENCE cars.description_semitrailers_description_semitrailer_id_seq OWNED BY cars.description_semitrailers.description_semitrailer_id;
          cars          postgres    false    249            �           2604    17345 3   description_semitrailers description_semitrailer_id    DEFAULT     �   ALTER TABLE ONLY cars.description_semitrailers ALTER COLUMN description_semitrailer_id SET DEFAULT nextval('cars.description_semitrailers_description_semitrailer_id_seq'::regclass);
 `   ALTER TABLE cars.description_semitrailers ALTER COLUMN description_semitrailer_id DROP DEFAULT;
       cars          postgres    false    250    249    250            A          0    17342    description_semitrailers 
   TABLE DATA           q   COPY cars.description_semitrailers (description_semitrailer_id, description_semitrailer_description) FROM stdin;
    cars          postgres    false    250   *       I           0    0 7   description_semitrailers_description_semitrailer_id_seq    SEQUENCE SET     c   SELECT pg_catalog.setval('cars.description_semitrailers_description_semitrailer_id_seq', 5, true);
          cars          postgres    false    249            �           2606    17350 6   description_semitrailers description_semitrailers_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY cars.description_semitrailers
    ADD CONSTRAINT description_semitrailers_pkey PRIMARY KEY (description_semitrailer_id);
 ^   ALTER TABLE ONLY cars.description_semitrailers DROP CONSTRAINT description_semitrailers_pkey;
       cars            postgres    false    250            A   �   x��PK
�0]7�����6�P���u���4�~���F��
�Q!3��̛���DHQ#C*�Z�5Z4xH�V� G�%��\�z�x*_�=�Y�JD�%IF�JH�VG����&�"�������*�!�_�D�t�'	}��-I�9݌l;}���J"!�'�.=	����2=ո��c�.e?7�_yÌ����	�װ�0_�}��	3c>     