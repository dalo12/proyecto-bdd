CREATE DATABASE banco CHARACTER SET latin1 COLLATE latin1_spanish_ci;

USE banco;

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
	nro_cliente SMALLINT CHECK (nro_cliente > 9999 AND nro_cliente < 10000),
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

CREATE TABLE Taza_Plazo_Fijo(
	periodo SMALLINT CHECK (periodo > 99 AND periodo < 1000),
	monto_inf DOUBLE CHECK (monto_inf > 0),
	monto_sup DOUBLE CHECK (monto_inf > 0),
	tasa DOUBLE CHECK (monto_inf > 0),
	PRIMARY KEY (periodo, monto_inf, monto_sup)
) ENGINE=InnoDB;

CREATE TABLE Sucursal() ENGINE=InnoDB;
CREATE TABLE Sucursal() ENGINE=InnoDB;
