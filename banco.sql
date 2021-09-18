CREATE DATABASE banco CHARACTER SET latin1 COLLATE latin1_spanish_ci;

USE banco;

#--------------------------------------------------
# CREACIÓN DE ENTIDADES

CREATE TABLE Ciudad(
	cod_postal SMALLINT CHECK (cod_postal > 999 AND cod_postal < 10000),
	nombre VARCHAR(45),
	PRIMARY KEY (cod_postal)
) ENGINE=InnoDB;

CREATE TABLE Sucursal(
	nro_suc SMALLINT CHECK (nro_suc > 99 AND nro_suc < 1000),
	nombre VARCHAR(45),
	direccion VARCHAR(45),
	telefono VARCHAR(45),
	horario VARCHAR(45),
	cod_postal SMALLINT CHECK (cod_postal > 999 AND cod_postal < 10000) REFERENCES Ciudad.cod_postal,
	PRIMARY KEY (nro_suc)
) ENGINE=InnoDB;

CREATE TABLE Empleado(
	legajo SMALLINT CHECK (legajo > 999 AND legajo < 10000),
	apellido VARCHAR(45),
	nombre VARCHAR(45),
	tipo_doc VARCHAR(3),
	nro_doc INT CHECK (nro_doc > 9999999 AND nro_doc < 100000000),
	direccion VARCHAR(45),
	telefono VARCHAR(25),
	cargo VARCHAR(45),
	password CHAR(32),
	nro_suc SMALLINT CHECK (nro_suc > 99 AND nro_suc < 1000) REFERENCES Sucursal.nro_suc, /* ¿es necesario especificar que respete las restricciones definidas en la clave foránea? */
	PRIMARY KEY (legajo)
) ENGINE=InnoDB;

CREATE TABLE Cliente(
	nro_cliente SMALLINT CHECK (nro_cliente > 9999 AND nro_cliente < 100000), 
	apellido VARCHAR(45),
	nombre VARCHAR(45),
	tipo_doc VARCHAR(3),
	nro_doc INT CHECK (nro_doc > 9999999 AND nro_doc < 100000000),
	direccion VARCHAR(45),
	telefono VARCHAR(25),
	PRIMARY KEY (nro_cliente) 	
) ENGINE=InnoDB;

CREATE TABLE Plazo_Fijo(
	nro_plazo INT CHECK (nro_doc > 9999999 AND nro_doc < 100000000),
	capital DOUBLE CHECK (capital > 0),
	fecha_inicio DATE,
	fecha_fin DATE,
	tasa_interes DOUBLE (tasa_interes > 0),
	interes DOUBLE (interes > 0),
	nro_suc SMALLINT CHECK (nro_suc > 99 AND nro_suc < 1000) REFERENCES Sucursal.nro_suc,
	PRIMARY KEY (nro_plazo)
) ENGINE=InnoDB;

CREATE TABLE Tasa_Plazo_Fijo(
	periodo SMALLINT CHECK (periodo > 99 AND periodo < 1000),
	monto_inf DOUBLE CHECK (monto_inf > 0),
	monto_sup DOUBLE CHECK (monto_inf > 0),
	tasa DOUBLE CHECK (monto_inf > 0),
	PRIMARY KEY (periodo, monto_inf, monto_sup)
) ENGINE=InnoDB;

CREATE TABLE Plazo_Cliente(
	nro_plazo INT CHECK (nro_doc > 9999999 AND nro_doc < 100000000) REFERENCES Plazo_Fijo.nro_plazo,
	nro_cliente SMALLINT CHECK (nro_cliente > 9999 AND nro_cliente < 100000) REFERENCES Cliente.nro_cliente,
	PRIMARY KEY (nro_plazo, nro_cliente)
) ENGINE=InnoDB;

CREATE TABLE Prestamo(
	nro_prestamo INT CHECK (nro_doc > 9999999 AND nro_doc < 100000000),
	fecha DATE,
	cant_meses TINYINT CHECK (cant_meses > 9 AND cant_meses < 100),
	monto DOUBLE CHECK (monto > 0),
	tasa_interes DOUBLE CHECK (tasa_interes > 0),
	interes DOUBLE CHECK (interes > 0),
	valor_cuota DOUBLE CHECK (valor_cuota > 0),
	legajo SMALLINT CHECK (legajo > 999 AND legajo < 10000) REFERENCES Empleado.legajo,
	nro_cliente SMALLINT CHECK (nro_cliente > 9999 AND nro_cliente < 100000) REFERENCES Cliente.nro_cliente,
	PRIMARY KEY (nro_prestamo)
) ENGINE=InnoDB;

CREATE TABLE Pago(
	nro_prestamo INT CHECK (nro_doc > 9999999 AND nro_doc < 100000000) REFERENCES Prestamo.nro_prestamo,
	nro_pago TINYINT CHECK (nro_pago > 9 AND nro_pago < 100),
	fecha_venc DATE,
	fecha_pago DATE,
	PRIMARY KEY (nro_prestamo, nro_pago)
) ENGINE=InnoDB;

CREATE TABLE Tasa_Prestamo(
	periodo SMALLINT CHECK (periodo > 99 AND periodo < 1000),
	monto_inf DOUBLE CHECK (monto_inf > 0),
	monto_sup DOUBLE CHECK (monto_inf > 0),
	tasa DOUBLE CHECK (monto_inf > 0),
	PRIMARY KEY (periodo, monto_inf, monto_sup)
) ENGINE=InnoDB;

CREATE TABLE Caja_Ahorro(
	nro_ca INT CHECK (nro_doc > 9999999 AND nro_doc < 100000000),
	CBU BIGINT CHECK (CBU > 99999999999999999 AND CBU < 1000000000000000000),
	saldo DOUBLE,
	PRIMARY KEY (nro_ca)
) ENGINE=InnoDB;

CREATE TABLE Cliente_CA(
	nro_cliente SMALLINT CHECK (nro_cliente > 9999 AND nro_cliente < 100000) REFERENCES Cliente.nro_cliente,
	nro_ca INT CHECK (nro_doc > 9999999 AND nro_doc < 100000000) REFERENCES Caja_Ahorro.nro_ca,
	PRIMARY KEY (nro_cliente, nro_ca)
) ENGINE=InnoDB;

CREATE TABLE Tarjeta(
	nro_tarjeta BIGINT CHECK (nro_tarjeta > 999999999999999 AND nro_tarjeta < 10000000000000000),
	PIN CHAR(32),
	CVT CHAR(32),
	fecha_venc DATE,
	nro_cliente SMALLINT CHECK (nro_cliente > 9999 AND nro_cliente < 100000) REFERENCES Cliente_CA.nro_cliente,
	nro_ca INT CHECK (nro_doc > 9999999 AND nro_doc < 100000000) REFERENCES Cliente_CA.nro_ca,
	PRIMARY KEY (nro_tarjeta)
) ENGINE=InnoDB;

CREATE TABLE Caja(
	cod_caja MEDIUMINT CHECK (cod_caja > 9999 AND cod_caja < 100000),
	PRIMARY KEY (cod_caja)
) ENGINE=InnoDB;

CREATE TABLE Ventanilla(
	cod_caja MEDIUMINT CHECK (cod_caja > 9999 AND cod_caja < 100000) REFERENCES Caja.cod_caja,
	nro_suc SMALLINT CHECK (nro_suc > 99 AND nro_suc < 1000) REFERENCES Sucursal.nro_suc,
	PRIMARY KEY (cod_caja)
) ENGINE=InnoDB;

CREATE TABLE ATM(
	cod_caja MEDIUMINT CHECK (cod_caja > 9999 AND cod_caja < 100000) REFERENCES Caja.cod_caja,
	cod_postal SMALLINT CHECK (cod_postal > 999 AND cod_postal < 10000) REFERENCES Ciudad.cod_postal,
	direccion VARCHAR(45),
	PRIMARY KEY (cod_caja) 
) ENGINE=InnoDB;

CREATE TABLE Transaccion(
	nro_trans BIGINT CHECK (nro_trans > 999999999 AND nro_trans < 10000000000),
	fecha DATE,
	hora TIME,
	monto DOUBLE CHECK (monto > 0),
	PRIMARY KEY (nro_trans)
) ENGINE=InnoDB;

CREATE TABLE Debito(
	nro_trans BIGINT CHECK (nro_trans > 999999999 AND nro_trans < 10000000000) REFERENCES Transaccion.nro_trans,
	descripcion VARCHAR(255),
	nro_cliente SMALLINT CHECK (nro_cliente > 9999 AND nro_cliente < 100000) REFERENCES Cliente_CA.nro_cliente,
	nro_ca INT CHECK (nro_doc > 9999999 AND nro_doc < 100000000) REFERENCES Cliente_CA.nro_ca,
	PRIMARY KEY (nro_trans)
) ENGINE=InnoDB;

CREATE TABLE Transaccion_por_caja(
	nro_trans BIGINT CHECK (nro_trans > 999999999 AND nro_trans < 10000000000) REFERENCES Transaccion.nro_trans,
	cod_caja MEDIUMINT CHECK (cod_caja > 9999 AND cod_caja < 100000) REFERENCES Caja.cod_caja,
	PRIMARY KEY (nro_trans)
) ENGINE=InnoDB;

CREATE TABLE Deposito(
	nro_trans BIGINT CHECK (nro_trans > 999999999 AND nro_trans < 10000000000) REFERENCES Transaccion_por_caja.nro_trans,
	nro_ca INT CHECK (nro_doc > 9999999 AND nro_doc < 100000000) REFERENCES Caja_Ahorro.nro_ca,
	PRIMARY KEY (nro_trans)
) ENGINE=InnoDB;

CREATE TABLE Extraccion(
	nro_trans BIGINT CHECK (nro_trans > 999999999 AND nro_trans < 10000000000) REFERENCES Transaccion_por_caja.nro_trans,
	nro_cliente SMALLINT CHECK (nro_cliente > 9999 AND nro_cliente < 100000) REFERENCES Cliente_CA.nro_cliente,
	nro_ca INT CHECK (nro_doc > 9999999 AND nro_doc < 100000000) REFERENCES Cliente_CA.nro_ca,
	PRIMARY KEY (nro_trans)
) ENGINE=InnoDB;

CREATE TABLE Transferencia(
	nro_trans BIGINT CHECK (nro_trans > 999999999 AND nro_trans < 10000000000) REFERENCES Transaccion_por_caja.nro_trans,
	nro_cliente SMALLINT CHECK (nro_cliente > 9999 AND nro_cliente < 100000) REFERENCES Cliente_CA.nro_cliente,
	origen INT CHECK (nro_doc > 9999999 AND nro_doc < 100000000) REFERENCES Cliente_CA.nro_ca,
	destino INT CHECK (nro_doc > 9999999 AND nro_doc < 100000000) REFERENCES Cliente_CA.nro_ca,
	PRIMARY KEY (nro_trans)
) ENGINE=InnoDB;

#--------------------------------------------------
# CREACIÓN DE VISTAS

CREATE VIEW trans_cajas_ahorro AS
SELECT banco.Caja_Ahorro.nro_ca, banco.Caja_Ahorro.saldo, banco.Transaccion.nro_trans, banco.Transaccion.fecha, banco.Transaccion.hora,  

#--------------------------------------------------
# CREACIÓN DE USUARIOS

CREATE USER 'admin'@'localhost' IDENTIFIED BY 'admin';
GRANT ALL PRIVILEGES ON banco.* TO 'admin'@'localhost' WITH GRANT OPTION;

DROP USER IF EXISTS ''@'localhost';

CREATE USER 'empleado' IDENTIFIED BY 'empleado';
GRANT SELECT ON banco.Empleado, banco.Sucursal, banco.Tasa_Plazo_Fijo, banco.Tasa_Prestamo, banco.Prestamo, banco.Plazo_Fijo, banco.Plazo_Cliente, banco.Caja_Ahorro, banco.Tarjeta, banco.Cliente_CA, banco.Cliente, banco.Pago TO 'empleado';
GRANT INSERT ON banco.Prestamo, banco.Plazo_Fijo, banco.Plazo_Cliente, banco.Caja_Ahorro, banco.Tarjeta, banco.Cliente_CA, banco.Cliente, banco.Pago TO 'empleado';
GRANT UPDATE ON banco.Cliente_CA, banco.Cliente, banco.Pago TO 'empleado'; 

CREATE USER 'atm'@'localhost' IDENTIFIED BY 'atm';
GRANT SELECT ON banco.trans_cajas_ahorro TO 'atm';


