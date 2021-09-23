#---------------------------------------------------------------------------
#Carga de datos de prueba

USE banco;

#Tabla de ciudad
# ciudad(cod_posta, nombre)

INSERT INTO ciudad VALUES (8000,"Bahia Blanca");
INSERT INTO ciudad VALUES (8109,"Punta Alta");
INSERT INTO ciudad VALUES (8135,"Monte Hermoso");
INSERT INTO ciudad VALUES (8700,"Tandil");
INSERT INTO ciudad VALUES (7600,"Mar del Plata");
INSERT INTO ciudad VALUES (1900,"La Plata");

#Tabla de sucursal
# sucursal(nro_suc, nombre, direccion, telefono, horario, cod_postal)

INSERT INTO sucursal VALUES (100,"Banco Bahia","Brown 50","291402339","9 a 16", 8000);
INSERT INTO sucursal VALUES (150,"Banco Nacion","Rivadavia 150","291402339","9 a 16", 7600);
INSERT INTO sucursal VALUES (200,"Banco Nacion","Brandsen 36","291402539","9 a 16", 7600);
INSERT INTO sucursal VALUES (250,"Banco Moneda","Don Bosco 1250","291402339","9 a 16", 1900);
INSERT INTO sucursal VALUES (300,"Banco Patagonia","Alberdi 350","291402339","9 a 16", 8109);

#Tabla de empleado
# empleado(legajo, apellido, nombre, tipo_doc, nro_doc, direccion, telefono, cargo, password, nro_suc)

INSERT INTO empleado VALUES (1100,"Perez","Juan","DNI",35444555,"San Martin 300","2932111111", "Presidente", md5("12345"), 100);
INSERT INTO empleado VALUES (1200,"Gonzalez","Matias","DNI",35333444,"San Martin 300","2932111111", "Vice regente general", md5("abcde"), 150);
INSERT INTO empleado VALUES (1300,"Riquelme","Agustina","DNI",35999555,"San Martin 300","2932111111", "Oficinista", md5("vamoñuels"), 200);
INSERT INTO empleado VALUES (1400,"Rodriguez","Luciana","DNI",35888555,"San Martin 300","2932111111", "Delegado sindical", md5("vivaperon"), 250);
INSERT INTO empleado VALUES (1500,"Cattafi","Juan","DNI",35777555,"San Martin 300","2932111111", "Logistica", md5("boquitaelmasgrande"), 300);

#Tabla de cliente
# cliente(nro_cliente, apellido, nombre, tipo_doc, nro_doc, direccion, telefono, fecha_nac)

INSERT INTO cliente VALUES (10000,"Cordoba","Oscar","DNI",40771337,"Alberdi 2000","291402333", '1970-02-03');
INSERT INTO cliente VALUES (10001,"Bermudez","Jorge","DNI",40777777,"Rodriguez Peña 30","291402333", '1971-06-18');
INSERT INTO cliente VALUES (10003,"Ibarra","Hugo","LE",40771339,"San Martin 2001","291400333", '1974-04-01');
INSERT INTO cliente VALUES (10004,"Serna","Mauricio","LE",40771317,"Brown 2500","291400003", '1968-01-22');
INSERT INTO cliente VALUES (10005,"Delgado","Marcelo","DNI",40773237,"Paso 300","291401233", '1973-03-24');
INSERT INTO cliente VALUES (10020,"Gaitan","Walter","LE",40723777,"Villanueva 3500","291222333", '1977-03-13');
INSERT INTO cliente VALUES (10010,"Riquelme","Juan Roman","DNI",40456123,"Espora 200","291234333", '1978-06-24');

#Tabla de plazo_fijo (¿2 decimales?)
# plazo_fijo(nro_plazo, capital, fecha_inicio, fecha_fin, tasa_interes, interes, nro_suc)

INSERT INTO plazo_fijo VALUES (12345678,20000.00,'2021-10-26','2021-12-02',50.00,10000.00,150);
INSERT INTO plazo_fijo VALUES (87654321,20000.00,'2021-02-26','2021-07-01',25.00,5000.00,150);
INSERT INTO plazo_fijo VALUES (12341234,25000.00,'2021-05-26','2021-12-10',20.00,4000.00,250);
INSERT INTO plazo_fijo VALUES (43214321,10000.00,'2020-01-20','2020-12-20',10.00,1000.00,300);

#Tabla tasa_plazo_fijo
# tasa_plazo_fijo(periodo, monto_inf, monto_sup, tasa)

INSERT INTO tasa_plazo_fijo VALUES (100,200.00,500.00,25.00);
INSERT INTO tasa_plazo_fijo VALUES (600,100.00,600.00,30.00);
INSERT INTO tasa_plazo_fijo VALUES (700,250.00,500.00,10.00);

#Tabla plazo_cliente
# plazo_cliente(nro_plazo, nro_cliente)

INSERT INTO plazo_cliente VALUES (12345678,10000);
INSERT INTO plazo_cliente VALUES (87654321,10005);
INSERT INTO plazo_cliente VALUES (12341234,10003);
INSERT INTO plazo_cliente VALUES (43214321,10004);
#INSERT INTO plazo_cliente VALUES (10000004,10010);
#INSERT INTO plazo_cliente VALUES (10000005,10001);

#Tabla prestamo
# prestamo(nro_prestamo, fecha, cant_meses, monto, tasa_interes, interes, valor_cuota, legajo, nro_cliente)
INSERT INTO prestamo VALUES (1000000,'2021-01-30',12,100000,15.00,10.00,17000.00,1100,10010);
INSERT INTO prestamo VALUES (1000020,'2021-06-15',11,100000,10.00,05.00,20000.00,1500,10005);

#Tabla pago
# pago(nro_prestamo, nro_pago, fecha_venc, fecha_pago)

INSERT INTO pago VALUES (1000000,10,'2021-11-20','2021-10-10');
INSERT INTO pago VALUES (1000000,11,'2021-12-31','2021-11-10');
INSERT INTO pago VALUES (1000000,12,'2021-12-31','2021-10-10');
INSERT INTO pago VALUES (1000020,30,'2021-11-20','2021-11-10');
INSERT INTO pago VALUES (1000020,31,'2021-12-20','2021-12-15');

#Tabla tasa_prestamo
# tasa_prestamo(periodo, monto_inf, monto_sup, tasa)

INSERT INTO tasa_prestamo VALUES (120,2000,10000,20.00);
INSERT INTO tasa_prestamo VALUES (150,3000,15000,95.00);
INSERT INTO tasa_prestamo VALUES (190,5000,10000,10.00);
INSERT INTO tasa_prestamo VALUES (220,200,1000,05.00);
INSERT INTO tasa_prestamo VALUES (920,200,100000,50.00);

#Tabla caja_ahorro
# caja_ahorro(nro_ca, cbu, saldo)

INSERT INTO caja_ahorro VALUES (10000000, 302958473642430501, 25.50);
INSERT INTO caja_ahorro VALUES (10000001, 302958473642430602, 250000000000.00);
INSERT INTO caja_ahorro VALUES (10000002, 302958473642430703, 20000.50);
INSERT INTO caja_ahorro VALUES (10000003, 302958473642430804, 85000.50);
INSERT INTO caja_ahorro VALUES (10000004, 302958473642430905, 9500.50);

#Tabla cliente_ca
# cliente_ca(nro_cliente, nro_ca)

INSERT INTO cliente_ca VALUES (10000,10000000);
INSERT INTO cliente_ca VALUES (10001,10000004);
INSERT INTO cliente_ca VALUES (10020,10000003);
INSERT INTO cliente_ca VALUES (10003,10000002);
INSERT INTO cliente_ca VALUES (10004,10000001);

#Tabla tarjeta
# tarjeta(nro_tarjeta, pin, cvt, fecha_venc, nro_cliente, nro_ca)

INSERT INTO tarjeta VALUES (1234567812345678,md5("12345"),md5("67890"),'2025-12-30',10000,10000000);
INSERT INTO tarjeta VALUES (2525179637926187,md5("abcde"),md5("fghai"),'2027-12-30',10001,10000004);
INSERT INTO tarjeta VALUES (6858392754891925,md5("a1b2c"),md5("d3e4f"),'2025-12-30',10003,10000002);
INSERT INTO tarjeta VALUES (1883191824046521,md5("23456"),md5("78901"),'2023-12-30',10004,10000001);

#Tabla caja
# caja(cod_caja)

INSERT INTO caja VALUES (12345);
INSERT INTO caja VALUES (10001);
INSERT INTO caja VALUES (10002);
INSERT INTO caja VALUES (10003);
INSERT INTO caja VALUES (10004);

#Tabla ventanilla
# ventanilla(cod_caja, nro_suc)

INSERT INTO ventanilla VALUES (12345,100);
INSERT INTO ventanilla VALUES (10001,150);
INSERT INTO ventanilla VALUES (10002,200);
INSERT INTO ventanilla VALUES (10003,250);
INSERT INTO ventanilla VALUES (10004,300);

#Tabla atm
# atm(cod_caja, cod_postal, direccion)

INSERT INTO atm VALUES (12345,8109,"Quintana 300");
#INSERT INTO atm VALUES (12345,8109,"Brown 1300");
#INSERT INTO atm VALUES (12345,8135,"Brown 2300");
INSERT INTO atm VALUES (10001,8135,"Paso 500");
#INSERT INTO atm VALUES (10001,8000,"Sarmiento 200");
INSERT INTO atm VALUES (10004,8000,"Alvear 50");
#INSERT INTO atm VALUES (10004,8000,"Mitre 300");
#INSERT INTO atm VALUES (10004,8000,"Mitre 1200");

#Tabla transaccion
# transaccion(nro_trans, fecha, hora, monto)

INSERT INTO transaccion VALUES (2084412882,'2021-08-12','13:30:00',500.00);
INSERT INTO transaccion VALUES (9718274314,'2021-08-13','14:30:00',2500.00);
INSERT INTO transaccion VALUES (1309471449,'2021-08-14','15:30:00',3500.00);
INSERT INTO transaccion VALUES (7718647062,'2021-08-15','09:30:00',4500.00);
INSERT INTO transaccion VALUES (4004184787,'2021-08-19','13:45:00',5500.00);
INSERT INTO transaccion VALUES (1592239192,'2021-09-11','14:00:00',6500.00);
INSERT INTO transaccion VALUES (4827101062,'2021-10-13','12:30:00',7500.00);
INSERT INTO transaccion VALUES (1851707417,'2021-11-14','19:30:00',8500.00);
INSERT INTO transaccion VALUES (9675401086,'2021-12-15','20:00:00',25000.05);
INSERT INTO transaccion VALUES (5096387224,'2021-12-15','20:00:00',25000.05);
INSERT INTO transaccion VALUES (4989267548,'2021-12-15','20:00:00',25000.05);


#Tabla debito
# debito(nro_trans, descripcion, nro_cliente, nro_ca)

INSERT INTO debito VALUES (2084412882,"3 Empanadas",10000, 10000000);
INSERT INTO debito VALUES (9718274314,"pago Supermercado",10000, 10000000);
INSERT INTO debito VALUES (1309471449,"pago Servicio",10000, 10000000);
INSERT INTO debito VALUES (4827101062,"Gomeria",10001, 10000004);
INSERT INTO debito VALUES (1851707417,"pago ABSA",10003, 10000002);
INSERT INTO debito VALUES (9675401086,"pago Camuzzi",10004, 10000001);

#Tabla transaccion_por_caja
# transaccion_por_caja(nro_trans, cod_caja)

INSERT INTO transaccion_por_caja VALUES (4004184787,12345);
INSERT INTO transaccion_por_caja VALUES (7718647062,12345);
INSERT INTO transaccion_por_caja VALUES (1592239192,12345);
INSERT INTO transaccion_por_caja VALUES (5096387224,12345);
INSERT INTO transaccion_por_caja VALUES (4989267548,12345);


#Tabla deposito
# deposito(nro_trans, nro_ca)

INSERT INTO deposito VALUES (4004184787,10000000);

#Tabla extraccion no se si esta bien poner el cliente y caja de ahorro correspondiente, tal vez sea origen-destino
# extraccion(nro_trans, nro_cliente, nro_ca)
INSERT INTO extraccion VALUES (7718647062,10000,10000000);
INSERT INTO extraccion VALUES (1592239192,10001,10000004);

#Tabla transferencia
# transferecia(nro_trans, nro_cliente, origen, destino)
INSERT INTO transferencia VALUES (5096387224,10020,10000003,10000002);
INSERT INTO transferencia VALUES (4989267548,10003,10000002,10000004);
