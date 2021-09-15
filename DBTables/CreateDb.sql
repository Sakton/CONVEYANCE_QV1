-- ЗАПРОС В СУБД НА НАЛИЧИЕ БАЗЫ ДАННЫХ
-- SELECT 1 AS res FROM pg_database WHERE datname = 'demo_coveyance_db';
-- SELECT 1 AS res FROM pg_database WHERE datname = '%1';

-- создание базы

CREATE DATABASE demo_coveyance_db 
	WITH TEMPLATE = template0 ENCODING = 'UTF8'
             LOCALE = 'Russian_Russia.1251';

