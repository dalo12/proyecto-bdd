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

CREATE TABLE Sucursal() ENGINE=InnoDB;
CREATE TABLE Sucursal() ENGINE=InnoDB;
CREATE TABLE Sucursal() ENGINE=InnoDB;
CREATE TABLE Sucursal() ENGINE=InnoDB;
CREATE TABLE Sucursal() ENGINE=InnoDB;
CREATE TABLE Sucursal() ENGINE=InnoDB;
