PGDMP     	    
    
            y            demo_coveyance_db    13.1    13.3     �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    50208    demo_coveyance_db    DATABASE     n   CREATE DATABASE demo_coveyance_db WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Russian_Russia.1251';
 !   DROP DATABASE demo_coveyance_db;
                postgres    false            �            1259    58704    autocategoryes    TABLE     	  CREATE TABLE auto.autocategoryes (
    autocategory_id integer NOT NULL,
    autocategory_name character varying(256) NOT NULL,
    autocategory_symbol character varying(5) NOT NULL,
    autocategory_icon character varying(64),
    autocategory_description text
);
     DROP TABLE auto.autocategoryes;
       auto         heap    postgres    false            �            1259    58702 "   autocategoryes_autocategory_id_seq    SEQUENCE     �   CREATE SEQUENCE auto.autocategoryes_autocategory_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 7   DROP SEQUENCE auto.autocategoryes_autocategory_id_seq;
       auto          postgres    false    217            �           0    0 "   autocategoryes_autocategory_id_seq    SEQUENCE OWNED BY     e   ALTER SEQUENCE auto.autocategoryes_autocategory_id_seq OWNED BY auto.autocategoryes.autocategory_id;
          auto          postgres    false    216            W           2604    58707    autocategoryes autocategory_id    DEFAULT     �   ALTER TABLE ONLY auto.autocategoryes ALTER COLUMN autocategory_id SET DEFAULT nextval('auto.autocategoryes_autocategory_id_seq'::regclass);
 K   ALTER TABLE auto.autocategoryes ALTER COLUMN autocategory_id DROP DEFAULT;
       auto          postgres    false    216    217    217            �          0    58704    autocategoryes 
   TABLE DATA           �   COPY auto.autocategoryes (autocategory_id, autocategory_name, autocategory_symbol, autocategory_icon, autocategory_description) FROM stdin;
    auto          postgres    false    217   �       �           0    0 "   autocategoryes_autocategory_id_seq    SEQUENCE SET     O   SELECT pg_catalog.setval('auto.autocategoryes_autocategory_id_seq', 16, true);
          auto          postgres    false    216            Y           2606    58712 1   autocategoryes autocategoryes_autocategory_id_key 
   CONSTRAINT     u   ALTER TABLE ONLY auto.autocategoryes
    ADD CONSTRAINT autocategoryes_autocategory_id_key UNIQUE (autocategory_id);
 Y   ALTER TABLE ONLY auto.autocategoryes DROP CONSTRAINT autocategoryes_autocategory_id_key;
       auto            postgres    false    217            �   )  x��Y�r�F>KO1�A�F��'9�^�q�)��B��x��Y�T�	e.R�Z�+,�oO0z�<I����4iH���QO�|�uOo��z�:ң��t����|��:֑��z�G�:N���XO����{���{O���d���y�@�J��J��)���!$����q��+=-m9i�2�y������G��� �rf��'=�(��T��#�0y�c耍��S��pc����'�>%5?��%Aɀe7(D""��$9�g�~r��&��_�%ם|�ۓ�&�%��̏�ҿ�!d�N�*�;mP��/������c�czĪТ��0`�B�,�ű�a�w$�q�n��'}Ҹє���"v�WJ`��+K(ʁ2O�B�@9��fƷO�N�w��}�2��p�sA�D&�4���%gX&p3�1��ʴ�[��%�I���k����8��I?�x//��6z�ވ�Ep��6O y_�Lq�{v�X�e%�zL�❧���M����s��"�#�#��Pt�>W�"�1c(�F�1�r|r���6��s�ʝ�1���x��V��[��iU����
_rzaV���u#�Cq~�D4$q�[:i�0@�A�xx��U���cǳ��;Uba�ǹPt3kq��<1'�>#�!=Ra���	��@��wr�Iz�(ژI.q(�`�d�d}�mz��U)�
��V�o�B�UO��ow֥1�v�̲=�C�'F�ā)�w@{���)�0�@(�U�2Gn�*F+��1I�ֵ�͟b�g��0�R���gR	o��?��R>$Mm��D����[�E�.�+=+�m4���Ԇ�ӆYf�%bfC��U�(�.����3j����:�z�7F��G�m����;]�P�&������ ���e9:8�b*�H����,$R�%wHe!gR#�W�W�y�b�1crݤ��xKrb��'�Y���=�r�P�c8���~��m�
{���{ei�g�J�L{��T9j����v�dԵn7(Yy1���ğ�F��ұ�S>M�9�q�����w[�Kx�۸V��U����!��4�D��~����ƙq��q�촿;9)�A�m��(��9��N�{��9�G5/��my[�|@�2�z�֪}P��j�n]֟��3�-�+6���cj!��Y�9�l@S��}O�
.}W+������^��7��Wm�h�~_��*���W�|��v^YQ��\���˷�5�v�?paf�ҹn�����Y���Lsl�4tegC�EfT�s��w+��i%��Ʌ��do�I�3�Z���o�$qkt��Rn�s����e�����>�6
6�t9���u�$σ0�'���=x,��~����z���)0����Lǒ�z:)p��s?W��E����V�D�+�����B{����(�BwxO""�p=N�����ᐃԓȐ���5q�L�:��S�O��^��&�1jz�X�t�s��kr3u��cI��*� �ώp�?x��˃�C�u~� �k���z6-I�!�U�E��.�΂��R��U�rJW�S	�~�6�������XZq�i��f��m��@mڬ�gn�q������ݰ������Kh�YA�3�s:{�#�j7:[�p(���X8eٻ숫����b�1�R�1+��)�rΓ�e�T%��]��"���o��X��i�����b�p��Ja����o�Nq���e�8Qi����]HSk7�<m�T�}���5��N����4R��]7����Z*N���`!%��F�]m�õ�����#=�3PV }�+�D���M<�(�u���B�ќ1���ke��}���������     