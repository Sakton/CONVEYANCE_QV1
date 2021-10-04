
INSERT INTO vat.vats ( vat_stavka )
VALUES (20), (13), (10),(0.5),(12),(6),(9),(5),(27),(18),(19),(7),(24),(25),(13.5),(4.8),(11),(4),(8),(3.8),(2.5),(17),
(14), (3), (15), (23), (9.5), (1), (5.5), (2.1), (7.7), (3.7), (22), (21)
ON CONFLICT ( vat_stavka ) DO NOTHING;

INSERT INTO vat.vatnames( vatname_name )
VALUES ('USt'),('TVSH'),('BTW/TVA'),('DDS'),('VAT'),('AFA'),('USt'),('BTW'),('FPA'),('MOMS'),('VAT'),('VASK'),('IVA'),('IVA'),('FPA'),
('PVN'),('PVM'),('MwSt'),('MwSt'),('VAT'),('TVA'),( 'MVA'),('PTU/VAT'),('IVA'),('НДС'),('TVA'),('PDV'),('DPH'),('DDV'),('KDV'),
('ПДВ'),('ALV'),('TVA'),('PDV'),('PDV'),('DPH'),('MwSt'),('MOMS'),('KM')
ON CONFLICT ( vatname_name ) DO NOTHING;

INSERT INTO adres.countrys ( vat_id, vatname_id, country_name, country_abbreviated_2, country_abbreviated_3, country_icon )
VALUES
( ( SELECT vat.getvatid(  20::DECIMAL ) ), ( SELECT vat.getvatnames( 'USt'    ) ), 'Австрия', 'AT', 'AUT', 'austria.png' ),
( ( SELECT vat.getvatid(  20::DECIMAL ) ), ( SELECT vat.getvatnames( 'TVSH'   ) ), 'Белоруссия', 'BY', 'BLR', 'belarus.png' ),
( ( SELECT vat.getvatid(  21::DECIMAL ) ), ( SELECT vat.getvatnames( 'BTW/TVA') ), 'Бельгия', 'BE', 'BEL', 'belgium.png' ),
( ( SELECT vat.getvatid(  20::DECIMAL ) ), ( SELECT vat.getvatnames( 'DDS'    ) ), 'Болгария', 'BG', 'BGR', 'bulgaria.png' ),
( ( SELECT vat.getvatid(  20::DECIMAL ) ), ( SELECT vat.getvatnames( 'VAT'    ) ), 'Великобритания', 'GB', 'GBR', 'united_kingdom.png' ),
( ( SELECT vat.getvatid(  27::DECIMAL ) ), ( SELECT vat.getvatnames( 'AFA'    ) ), 'Венгрия', 'HU', 'HUN', 'hungary.png'),
( ( SELECT vat.getvatid(  19::DECIMAL ) ), ( SELECT vat.getvatnames( 'USt'	  ) ), 'Германия', 'DE', 'DEU', 'germany.png' ),
( ( SELECT vat.getvatid(  21::DECIMAL ) ), ( SELECT vat.getvatnames( 'BTW'	  ) ), 'Нидерланды', 'NL', 'NLD', 'netherlands.png' ),
( ( SELECT vat.getvatid(  24::DECIMAL ) ), ( SELECT vat.getvatnames( 'FPA'	  ) ), 'Греция', 'GR', 'GRC', 'greece.png' ),
( ( SELECT vat.getvatid(  25::DECIMAL ) ), ( SELECT vat.getvatnames( 'MOMS'	  ) ), 'Дания', 'DK', 'DNK', 'denmark.png' ),
( ( SELECT vat.getvatid(  21::DECIMAL ) ), ( SELECT vat.getvatnames( 'VAT'	  ) ), 'Ирландия', 'IE', 'IRL', 'ireland.png' ),
( ( SELECT vat.getvatid(  24::DECIMAL ) ), ( SELECT vat.getvatnames( 'VASK'	  ) ), 'Исландия', 'IS', 'ISL', 'iceland.png' ),
( ( SELECT vat.getvatid(  21::DECIMAL ) ), ( SELECT vat.getvatnames( 'IVA'	  ) ), 'Испания', 'ES', 'ESP', 'spain.png' ),
( ( SELECT vat.getvatid(  22::DECIMAL ) ), ( SELECT vat.getvatnames( 'IVA'	  ) ), 'Италия', 'IT', 'ITA', 'italy.png' ),
( ( SELECT vat.getvatid(  19::DECIMAL ) ), ( SELECT vat.getvatnames( 'FPA'	  ) ), 'Кипр', 'CY', 'CYP', 'cyprus.png' ),
( ( SELECT vat.getvatid(  21::DECIMAL ) ), ( SELECT vat.getvatnames( 'PVN'	  ) ), 'Латвия', 'LV', 'LVA', 'latvia.png' ),
( ( SELECT vat.getvatid(  21::DECIMAL ) ), ( SELECT vat.getvatnames( 'PVM'	  ) ), 'Литва', 'LT', 'LTU', 'lithuania.png' ),
( ( SELECT vat.getvatid(   8::DECIMAL ) ), ( SELECT vat.getvatnames( 'MwSt'	  ) ), 'Лихтенштейн', 'LI', 'LIE', 'liechtenstein.png' ),
( ( SELECT vat.getvatid(  17::DECIMAL ) ), ( SELECT vat.getvatnames( 'MwSt'	  ) ), 'Люксембург', 'LU', 'LUX', 'luxembourg.png' ),
( ( SELECT vat.getvatid(  18::DECIMAL ) ), ( SELECT vat.getvatnames( 'VAT'	  ) ), 'Мальта', 'MT', 'MLT', 'malta.png'),
( ( SELECT vat.getvatid(  20::DECIMAL ) ), ( SELECT vat.getvatnames( 'TVA'	  ) ), 'Молдавия', 'MD', 'MDA', 'moldova.png' ),
( ( SELECT vat.getvatid(  25::DECIMAL ) ), ( SELECT vat.getvatnames( 'MVA'	  ) ), 'Норвегия', 'NO', 'NOR', 'norway.png' ),
( ( SELECT vat.getvatid(  23::DECIMAL ) ), ( SELECT vat.getvatnames( 'PTU/VAT') ), 'Польша', 'PL', 'POL', 'poland.png' ),
( ( SELECT vat.getvatid(  23::DECIMAL ) ), ( SELECT vat.getvatnames( 'IVA'	  ) ), 'Португалия', 'PT', 'PRT', 'portugal.png' ),
( ( SELECT vat.getvatid(  20::DECIMAL ) ), ( SELECT vat.getvatnames( 'НДС'	  ) ), 'Россия', 'RU', 'RUS', 'russia.png' ),
( ( SELECT vat.getvatid(  19::DECIMAL ) ), ( SELECT vat.getvatnames( 'TVA'	  ) ), 'Румыния', 'RO', 'ROU', 'romania.png' ),
( ( SELECT vat.getvatid(  20::DECIMAL ) ), ( SELECT vat.getvatnames( 'PDV'	  ) ), 'Сербия', 'RS', 'SRB', 'serbia.png' ),
( ( SELECT vat.getvatid(  20::DECIMAL ) ), ( SELECT vat.getvatnames( 'DPH'	  ) ), 'Словакия', 'SK', 'SVK', 'slovakia.png' ),
( ( SELECT vat.getvatid(  22::DECIMAL ) ), ( SELECT vat.getvatnames( 'DDV'	  ) ), 'Словения', 'SI', 'SVN', 'slovenia.png' ),
( ( SELECT vat.getvatid(  18::DECIMAL ) ), ( SELECT vat.getvatnames( 'KDV'	  ) ), 'Турция', 'TR', 'TUR', 'turkey.png'),
( ( SELECT vat.getvatid(  20::DECIMAL ) ), ( SELECT vat.getvatnames( 'ПДВ'	  ) ), 'Украина', 'UA', 'UKR', 'ukraine.png' ),
( ( SELECT vat.getvatid(  24::DECIMAL ) ), ( SELECT vat.getvatnames( 'ALV'	  ) ), 'Финляндия', 'FI', 'FIN', 'finland.png' ),
( ( SELECT vat.getvatid(  20::DECIMAL ) ), ( SELECT vat.getvatnames( 'TVA'	  ) ), 'Франция', 'FR', 'FRA', 'france.png' ),
( ( SELECT vat.getvatid(  25::DECIMAL ) ), ( SELECT vat.getvatnames( 'PDV'	  ) ), 'Хорватия', 'HR', 'HRV', 'croatia.png' ),
( ( SELECT vat.getvatid(  19::DECIMAL ) ), ( SELECT vat.getvatnames( 'PDV'	  ) ), 'Черногория', 'ME', 'MNE', 'montenegro.png' ),
( ( SELECT vat.getvatid(  21::DECIMAL ) ), ( SELECT vat.getvatnames( 'DPH'	  ) ), 'Чехия', 'CZ', 'CZE', 'czech_republic.png' ),
( ( SELECT vat.getvatid( 7.7::DECIMAL ) ), ( SELECT vat.getvatnames( 'MwSt'   ) ), 'Швейцария', 'CH', 'CHE', 'switzerland.png' ),
( ( SELECT vat.getvatid(  25::DECIMAL ) ), ( SELECT vat.getvatnames( 'MOMS'	  ) ), 'Швеция', 'SE', 'SWE', 'sweden.png' ),
( ( SELECT vat.getvatid(  20::DECIMAL ) ), ( SELECT vat.getvatnames( 'KM'	  ) ), 'Эстония', 'EE', 'EST', 'estonia.png' );


INSERT INTO cars.autocategories ( autocategory_name, autocategory_symbol, autocategory_icon, autocategory_description )
VALUES ( 'Мопеды и Легкие квадрициклы','M','M.png','Категория М дает право водить мопеды и легкие квадрициклы.
Особенность управления этими ТС в том, что ими можно управлять
имея любую другую категорию водительских прав. За исключением
удостоверения тракториста-машиниста и наличия иностранных водительских прав.
Важно! Чтобы водить квадроцикл или снегоход,
эта категория прав не подходит.
Для управления этими ТС нужно иметь удостоверение тракториста-машиниста
категории А1 — внедорожные транспортные средства.
При этом А1 относится не к автомобильным категориям прав,
а к категориям управления специальной техникой.' ),
( 'Мотоциклы', 'A', 'A.png', 'Категория A дает право управлять любыми мотоциклами' ),
( 'Легкие мотоциклы', 'A1', 'A1.png', 'Позволяет управлять мотоциклами с объемом двигателя, не превышающим 125 куб. см и максимальной мощностью не более 11 киловатт.' ),
( 'Легковые автомобили и небольшие грузовики', 'B', 'B.png', 'Автомобили, масса которых не превышает 3,5 тонны, а число сидячих мест
(помимо сиденья водителя) не превышает восьми;
автомобили, сцепленные с прицепом, разрешенная масса которого не более 750 кг;
автомобили, сцепленные с прицепом, разрешенная максимальная масса которого превышает 750 кг,
но не превышает массы автомобиля без нагрузки, при условии, что общая максимальная масса такого
состава транспортных средств не превышает 3,5 тонны.
К перечисленным выше условиям могут относиться не только легковые автомобили,
но и небольшие грузовики, микроавтобусы и джипы.' ),
( 'Трициклы и квадрициклы', 'B1', 'B1.png', 'Дает право на управление трициклами и квадрициклами. Это транспортные средства с тремя и четырьмя колесами соответственно.' ),
( 'Легковые автомобили с прицепом', 'BE', 'BE.png', 'Позволяет управлять автомобилем категории В с тяжелым прицепом:
разрешенная максимальная масса которого превышает 750 кг и превышает массу автомобиля без нагрузки;
разрешенная максимальная масса которого превышает 750 кг,
при условии, что общая разрешенная максимальная масса такого
состава транспортных средств превышает 3,5 тонны.' ),
( 'Грузовые автомобили от 3,5 тонн', 'C', 'C.png', 'Позволяют управлять автомобилями, максимальная масса которых превышает 3,5 тонны, за исключением машин категории D;
автомобилями, сцепленными с прицепами, разрешенная максимальная масса которых не превышает 750 кг.' ),
( 'Средние грузовики (от 3,5 до 7,5 тонн)', 'C1', 'C1.png', 'Дает право управлять автомобилем, разрешенная максимальная масса которого превышает 3,5 тонны,
но не превышает 7,5 тонн, за исключение автомобилей категории D.
автомобилем с прицепом, разрешенная максимальная масса которого не более 750 кг.' ),
( 'Средние грузовые автомобили с прицепом', 'C1E', 'C1E.png', 'Позволяет управлять:
автомобилями подкатегории С1, сцепленными с тяжелым прицепом (более 750 кг).
При условии, что общая масса этого состава ТС не более 12 тонн.' ),
( 'Грузовые автомобили с прицепом', 'CE', 'CE.png', 'Дает возможность управлять автомобилями категории С, сцепленными прицепами,
разрешенная максимальная масса которых превышает 750 кг.' ),
( 'Автобусы, имеющие более 8 сидячих мест', 'D', 'D.png', 'Дает право управлять:
автомобилями для перевозки пассажиров и имеющими более 8 сидячих мест, помимо сиденья водителя;
автобусами с прицепом, вес которого не превышает 750 кг.
То есть к этой категории относятся как маленькие, так и большие туристические автобусы.
Единственное исключение — автобусы с «гармошкой».' ),
( 'Небольшие автобусы', 'D1', 'D1.png', 'Позволяет управлять небольшими автобусами, которые имеют от 9 до 16 сидячих мест, помимо сиденья водителя.
Также дает право использовать легкий прицеп до 750 кг.' ),
( 'Небольшие автобусы с прицепом', 'D1E', 'D1E.png', 'Дает право управлять автомобилем подкатегории D1, сцепленными с прицепом, разрешенная масса
которого превышает 750 кг, но не превышает массу автомобиля без нагрузки.
Суммарный вес такого ТС не должен превышать 12 тонн, а прицеп не должен быть предназначен для перевозки пассажиров.
Важно! Водители, имеющие права категории D, могут управлять автобусами подкатегории D1, а категория DE дает возможность
управлять автобусами с прицепом подкатегории D1Е.' ),
( 'Автобусы с прицепом', 'DE', 'DE.png', 'Дает возможность управлять сочленными автобусами и буксировать прицепы весом более 750 кг.' ),
( 'Троллейбусы', 'Tb', 'Tb.png', 'Дают право управлять троллейбусами' ),
( 'Трамваи', 'Tm', 'Tm.png', 'Дают право управлять трамваями' );

INSERT INTO emploee.functionworker( functionworker_name ) VALUES ('Водитель');


--INSERT INTO cars.paletypes ( paletype_name, paletype_lenth, paletype_width )
--VALUES ('Финский', 1.2, 1),
--       ('Американский', 1.2, 1.2),
--       ('Европейский', 1.2, 0.8);


--INSERT INTO cars.description_semitrailers( description_semitrailer_description )
--VALUES ('Стандартный полуприцеп с ровным полом.'),
--       ('Конструкция полуприцепа с ломаным полом, уменьшенный диаметр колёс.'),
--       ('Стандартный полуприцеп увеличенной высоты с ровным полом.'),
--       ('Автопоезд - грузовик с прицепом увеличенной высоты и уменьшенным диаметром колёс.'),
--       ('Автопоезд - грузовик с прицепом.');

--INSERT INTO cars.semitrailers ( semitrailer_name,
--				semitrailer_carrying,
--				semitrailer_gabarit_lenth,
--				semitrailer_gabarit_width,
--				semitrailer_gabarit_height,
--				description_semitrailer_id,
--				semitrailer_img
--				)
--VALUES ( 'Еврофура 82 м³', 24, 13.6, 2.45, 2.45, 1, 'eurofura-82-kuba.png' ),
--       ( 'Еврофура 86 м³', 24, 13.6, 2.45, 2.60, 1, 'eurofura-86-kubov.png' ),
--       ( 'Еврофура 90 м³', 24, 13.6, 2.45, 2.70, 1, 'eurofura-90-kubov.png' ),
--       ( 'Джамбо фура (JUMBO)', 24, 13.8, 2.45, 3, 2, 'jumbo-fura-96-kubov.png' ),
--       ( 'Мега фура (MEGA)', 25, 13.6, 2.45, 3, 4, 'mega-fura-100-kubov.png' ),
--       ( 'Сцепка / Автопоезд', 25, 15.1, 2.45, 3, 5, 'scepka-mega-120-kubov.png' );


-- WAGONS *****************
--INSERT INTO wagons.description_semitrailers( description_semitrailer_description )
--VALUES ('Стандартный полуприцеп с ровным полом.'),
--       ('Конструкция полуприцепа с ломаным полом, уменьшенный диаметр колёс.'),
--       ('Стандартный полуприцеп увеличенной высоты с ровным полом.'),
--       ('Автопоезд - грузовик с прицепом увеличенной высоты и уменьшенным диаметром колёс.'),
--       ('Автопоезд - грузовик с прицепом.');

--INSERT INTO wagons.semitrailers ( semitrailer_name,
--				semitrailer_carrying,
--				semitrailer_gabarit_lenth,
--				semitrailer_gabarit_width,
--				semitrailer_gabarit_height,
--				description_semitrailer_id,
--				semitrailer_img
--				)
--VALUES ( 'Еврофура 82 м³', 24, 13.6, 2.45, 2.45, 1, 'eurofura-82-kuba.png' ),
--       ( 'Еврофура 86 м³', 24, 13.6, 2.45, 2.60, 1, 'eurofura-86-kubov.png' ),
--       ( 'Еврофура 90 м³', 24, 13.6, 2.45, 2.70, 1, 'eurofura-90-kubov.png' ),
--       ( 'Джамбо фура (JUMBO)', 24, 13.8, 2.45, 3, 2, 'jumbo-fura-96-kubov.png' ),
--       ( 'Мега фура (MEGA)', 25, 13.6, 2.45, 3, 4, 'mega-fura-100-kubov.png' ),
--       ( 'Сцепка / Автопоезд', 25, 15.1, 2.45, 3, 5, 'scepka-mega-120-kubov.png' );
