PGDMP     8                    y            conveyance_db    13.1    13.3     =           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            >           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            ?           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            @           1262    16982    conveyance_db    DATABASE     j   CREATE DATABASE conveyance_db WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Russian_Russia.1251';
    DROP DATABASE conveyance_db;
                postgres    false            	            2615    16987    orders    SCHEMA        CREATE SCHEMA orders;
    DROP SCHEMA orders;
                postgres    false                       1255    17005 T   addorder(integer, integer, integer, integer, integer, date, character varying, text) 	   PROCEDURE     �  CREATE PROCEDURE orders.addorder(idshipper integer, idemploee integer, idpayment integer, idroute integer, iddocuments integer, dataorder date, contractnumber character varying, noteorder text)
    LANGUAGE sql
    AS $$
    INSERT INTO orders.orders( shipper_id, emploee_id, payment_id, route_id, document_id, order_data, order_contractNumber, order_note )
        VALUES ( idShipper, idEmploee, idPayment, idRoute, idDocuments, dataOrder, contractNumber, noteOrder );
$$;
 �   DROP PROCEDURE orders.addorder(idshipper integer, idemploee integer, idpayment integer, idroute integer, iddocuments integer, dataorder date, contractnumber character varying, noteorder text);
       orders          postgres    false    9                       1255    17323 �   addtoorder(character varying, character varying, integer, integer, numeric, character varying, character varying, integer, integer, character varying, integer, integer, character varying) 	   PROCEDURE     |  CREATE PROCEDURE orders.addtoorder(orderdate character varying, ordernumber character varying, shipperid integer, emploeeid integer, paymentcost numeric, paymentperiod character varying, paymentcurrency character varying, routesarrival integer, routesroute integer, documentpostperiod character varying, document2copycmr integer, documentoriginal integer, odernote character varying)
    LANGUAGE sql
    AS $$
    INSERT INTO orders.orders ( shipper_id, emploee_id, payment_id, route_id, document_id, order_data, order_contractNumber, order_note )
    VALUES ( shipperId, emploeeId,
				    ( SELECT payment.getPayment_id( paymentCost, paymentPeriod, paymentCurrency ) ),
				    ( SELECT route.getRouteId( routesArrival, routesRoute ) ),
				    ( SELECT document.getDocumentId( documentPostPeriod, document2CopyCmr, documentOriginal ) ),
	    orderDate::date, orderNumber, oderNote );
$$;
   DROP PROCEDURE orders.addtoorder(orderdate character varying, ordernumber character varying, shipperid integer, emploeeid integer, paymentcost numeric, paymentperiod character varying, paymentcurrency character varying, routesarrival integer, routesroute integer, documentpostperiod character varying, document2copycmr integer, documentoriginal integer, odernote character varying);
       orders          postgres    false    9                       1255    17325 �   updateorder(integer, character varying, character varying, integer, integer, numeric, character varying, character varying, integer, integer, character varying, integer, integer, character varying) 	   PROCEDURE     �  CREATE PROCEDURE orders.updateorder(orderid integer, orderdate character varying, ordernumber character varying, shipperid integer, emploeeid integer, paymentcost numeric, paymentperiod character varying, paymentcurrency character varying, routesarrival integer, routesroute integer, documentpostperiod character varying, document2copycmr integer, documentoriginal integer, odernote character varying)
    LANGUAGE sql
    AS $$
    UPDATE orders.orders
    SET shipper_id  = shipperId,
	emploee_id  = emploeeId,
	payment_id  = ( SELECT payment.getPayment_id( paymentCost, paymentPeriod, paymentCurrency ) ),
	route_id    = ( SELECT route.getRouteId( routesArrival, routesRoute ) ),
	document_id = ( SELECT document.getDocumentId( documentPostPeriod, document2CopyCmr, documentOriginal ) ),
	order_data  = orderDate::date,
	order_contractNumber = orderNumber,
	order_note  = oderNote
    WHERE order_id  = orderId;
$$;
 �  DROP PROCEDURE orders.updateorder(orderid integer, orderdate character varying, ordernumber character varying, shipperid integer, emploeeid integer, paymentcost numeric, paymentperiod character varying, paymentcurrency character varying, routesarrival integer, routesroute integer, documentpostperiod character varying, document2copycmr integer, documentoriginal integer, odernote character varying);
       orders          postgres    false    9            �            1259    17095    orders    TABLE       CREATE TABLE orders.orders (
    order_id integer NOT NULL,
    shipper_id integer,
    emploee_id integer,
    payment_id integer,
    route_id integer,
    document_id integer,
    order_data date,
    order_contractnumber character varying(200) NOT NULL,
    order_note text
);
    DROP TABLE orders.orders;
       orders         heap    postgres    false    9            �            1259    17101    orders_order_id_seq    SEQUENCE     �   CREATE SEQUENCE orders.orders_order_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE orders.orders_order_id_seq;
       orders          postgres    false    233    9            A           0    0    orders_order_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE orders.orders_order_id_seq OWNED BY orders.orders.order_id;
          orders          postgres    false    234            �            1259    17314 
   ordersview    VIEW       CREATE VIEW orders.ordersview AS
 SELECT ord.order_data,
    ord.order_contractnumber,
    shp.shipper_name,
    emp.emploee_name,
    pay.payment_cost,
    pay.payment_currency,
    pay.payment_period,
    rou.route_arrival,
    rou.route_route,
        CASE
            WHEN ((rou.route_arrival + rou.route_route) = 0) THEN (0)::numeric
            ELSE (pay.payment_cost / ((rou.route_arrival + rou.route_route))::numeric)
        END AS stavka,
    doc.document_original,
    doc.document_2copycmr,
    doc.document_postperiod,
    ord.order_note,
    ord.order_id,
    ord.shipper_id,
    ord.emploee_id,
    ord.payment_id,
    ord.route_id,
    ord.document_id
   FROM (((((orders.orders ord
     JOIN shipper.shippers shp ON ((ord.shipper_id = shp.shipper_id)))
     JOIN emploee.emploees emp ON ((ord.emploee_id = emp.emploee_id)))
     JOIN payment.payments pay ON ((ord.payment_id = pay.payment_id)))
     JOIN route.routes rou ON ((ord.route_id = rou.route_id)))
     JOIN document.documents doc ON ((ord.document_id = doc.document_id)));
    DROP VIEW orders.ordersview;
       orders          postgres    false    233    233    233    233    233    233    233    233    233    9            �           2604    17152    orders order_id    DEFAULT     r   ALTER TABLE ONLY orders.orders ALTER COLUMN order_id SET DEFAULT nextval('orders.orders_order_id_seq'::regclass);
 >   ALTER TABLE orders.orders ALTER COLUMN order_id DROP DEFAULT;
       orders          postgres    false    234    233            9          0    17095    orders 
   TABLE DATA           �   COPY orders.orders (order_id, shipper_id, emploee_id, payment_id, route_id, document_id, order_data, order_contractnumber, order_note) FROM stdin;
    orders          postgres    false    233   �(       B           0    0    orders_order_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('orders.orders_order_id_seq', 24, true);
          orders          postgres    false    234            �           2606    17277 &   orders orders_order_contractnumber_key 
   CONSTRAINT     q   ALTER TABLE ONLY orders.orders
    ADD CONSTRAINT orders_order_contractnumber_key UNIQUE (order_contractnumber);
 P   ALTER TABLE ONLY orders.orders DROP CONSTRAINT orders_order_contractnumber_key;
       orders            postgres    false    233            �           2606    17279 '   orders orders_order_contractnumber_key1 
   CONSTRAINT     r   ALTER TABLE ONLY orders.orders
    ADD CONSTRAINT orders_order_contractnumber_key1 UNIQUE (order_contractnumber);
 Q   ALTER TABLE ONLY orders.orders DROP CONSTRAINT orders_order_contractnumber_key1;
       orders            postgres    false    233            �           2606    17193    orders orders_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY orders.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (order_id);
 <   ALTER TABLE ONLY orders.orders DROP CONSTRAINT orders_pkey;
       orders            postgres    false    233            �           2606    17255    orders orders_emploee_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY orders.orders
    ADD CONSTRAINT orders_emploee_id_fkey FOREIGN KEY (emploee_id) REFERENCES emploee.emploees(emploee_id);
 G   ALTER TABLE ONLY orders.orders DROP CONSTRAINT orders_emploee_id_fkey;
       orders          postgres    false    233            �           2606    17260    orders orders_payment_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY orders.orders
    ADD CONSTRAINT orders_payment_id_fkey FOREIGN KEY (payment_id) REFERENCES payment.payments(payment_id);
 G   ALTER TABLE ONLY orders.orders DROP CONSTRAINT orders_payment_id_fkey;
       orders          postgres    false    233            �           2606    17270    orders orders_shipper_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY orders.orders
    ADD CONSTRAINT orders_shipper_id_fkey FOREIGN KEY (shipper_id) REFERENCES shipper.shippers(shipper_id);
 G   ALTER TABLE ONLY orders.orders DROP CONSTRAINT orders_shipper_id_fkey;
       orders          postgres    false    233            9   �   x�uN��@��)����/!��h)Y �@
F@��A�"38+0	/9)�u�N�g%�h��|t����/�녌?dA,~�
��Xd]Q tXt]QhH�MG&�vbE�t>�$.��"��`O��c��.7�'�X�Y����7M��}l����N��	kj�i��:;w� 0#��a�7:PRH     