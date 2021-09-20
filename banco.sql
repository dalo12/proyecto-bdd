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
	cod_postal SMALLINT CHECK (cod_postal > 999 AND cod_postal < 10000),
	PRIMARY KEY (nro_suc),
	CONSTRAINT fk_sucursal_ciudad FOREIGN KEY (cod_postal) REFERENCES Ciudad(cod_postal) ON UPDATE CASCADE
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
	nro_suc SMALLINT CHECK (nro_suc > 99 AND nro_suc < 1000),
	PRIMARY KEY (legajo),
	CONSTRAINT fk_empleado_sucursal FOREIGN KEY (nro_suc) REFERENCES Sucursal(nro_suc) ON UPDATE CASCADE
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
	nro_plazo INT CHECK (nro_plazo > 9999999 AND nro_plazo < 100000000),
	capital DOUBLE CHECK (capital > 0),
	fecha_inicio DATE,
	fecha_fin DATE,
	tasa_interes DOUBLE CHECK (tasa_interes > 0),
	interes DOUBLE CHECK (interes > 0),
	nro_suc SMALLINT CHECK (nro_suc > 99 AND nro_suc < 1000),
	PRIMARY KEY (nro_plazo),
	CONSTRAINT fk_plazo_fijo_sucursal FOREIGN KEY (nro_suc) REFERENCES Sucursal(nro_suc) ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE Tasa_Plazo_Fijo(
	periodo SMALLINT CHECK (periodo > 99 AND periodo < 1000),
	monto_inf DOUBLE CHECK (monto_inf > 0),
	monto_sup DOUBLE CHECK (monto_inf > 0),
	tasa DOUBLE CHECK (monto_inf > 0),
	PRIMARY KEY (periodo, monto_inf, monto_sup)
) ENGINE=InnoDB;

CREATE TABLE Plazo_Cliente(
	nro_plazo INT CHECK (nro_plazo > 9999999 AND nro_plazo < 100000000),
	nro_cliente SMALLINT CHECK (nro_cliente > 9999 AND nro_cliente < 100000),
	PRIMARY KEY (nro_plazo, nro_cliente),
	CONSTRAINT fk_plazo_cliente_plazo FOREIGN KEY (nro_plazo) REFERENCES Plazo_Fijo(nro_plazo) ON UPDATE CASCADE,
	CONSTRAINT fk_plazo_cliente_cliente FOREIGN KEY (nro_cliente) REFERENCES Cliente(nro_cliente) ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE Prestamo(
	nro_prestamo INT CHECK (nro_prestamo > 9999999 AND nro_prestamo < 100000000),
	fecha DATE,
	cant_meses TINYINT CHECK (cant_meses > 9 AND cant_meses < 100),
	monto DOUBLE CHECK (monto > 0),
	tasa_interes DOUBLE CHECK (tasa_interes > 0),
	interes DOUBLE CHECK (interes > 0),
	valor_cuota DOUBLE CHECK (valor_cuota > 0),
	legajo SMALLINT CHECK (legajo > 999 AND legajo < 10000),
	nro_cliente SMALLINT CHECK (nro_cliente > 9999 AND nro_cliente < 100000),
	PRIMARY KEY (nro_prestamo),
	CONSTRAINT fk_prestamo_legajo FOREIGN KEY (legajo) REFERENCES Empleado(legajo) ON UPDATE CASCADE,
	CONSTRAINT fk_prestamo_cliente FOREIGN KEY (nro_cliente) REFERENCES Cliente(nro_cliente) ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE Pago(
	nro_prestamo INT CHECK (nro_prestamo > 9999999 AND nro_prestamo < 100000000),
	nro_pago TINYINT CHECK (nro_pago > 9 AND nro_pago < 100),
	fecha_venc DATE,
	fecha_pago DATE,
	PRIMARY KEY (nro_prestamo, nro_pago),
	CONSTRAINT fk_pago_prestamo FOREIGN KEY (nro_prestamo) REFERENCES Prestamo(nro_prestamo) ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE Tasa_Prestamo(
	periodo SMALLINT CHECK (periodo > 99 AND periodo < 1000),
	monto_inf DOUBLE CHECK (monto_inf > 0),
	monto_sup DOUBLE CHECK (monto_inf > 0),
	tasa DOUBLE CHECK (monto_inf > 0),
	PRIMARY KEY (periodo, monto_inf, monto_sup)
) ENGINE=InnoDB;

CREATE TABLE Caja_Ahorro(
	nro_ca INT CHECK (nro_ca > 9999999 AND nro_ca < 100000000),
	CBU BIGINT CHECK (CBU > 99999999999999999 AND CBU < 1000000000000000000),
	saldo DOUBLE,
	PRIMARY KEY (nro_ca)
) ENGINE=InnoDB;

CREATE TABLE Cliente_CA(
	nro_cliente SMALLINT CHECK (nro_cliente > 9999 AND nro_cliente < 100000),
	nro_ca INT CHECK (nro_ca > 9999999 AND nro_ca < 100000000),
	PRIMARY KEY (nro_cliente, nro_ca),
	CONSTRAINT fk_cliente_ca_cliente FOREIGN KEY (nro_cliente) REFERENCES Cliente(nro_cliente) ON UPDATE CASCADE,
	CONSTRAINT fk_cliente_ca_caja FOREIGN KEY (nro_ca) REFERENCES Caja_Ahorro(nro_ca) ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE Tarjeta(
	nro_tarjeta BIGINT CHECK (nro_tarjeta > 999999999999999 AND nro_tarjeta < 10000000000000000),
	PIN CHAR(32),
	CVT CHAR(32),
	fecha_venc DATE,
	nro_cliente SMALLINT CHECK (nro_cliente > 9999 AND nro_cliente < 100000),
	nro_ca INT CHECK (nro_ca > 9999999 AND nro_ca < 100000000),
	PRIMARY KEY (nro_tarjeta),
	CONSTRAINT fk_tarjeta_cliente FOREIGN KEY (nro_cliente) REFERENCES Cliente_CA(nro_cliente) ON UPDATE CASCADE,
	CONSTRAINT fk_tarjeta_caja FOREIGN KEY (nro_ca) REFERENCES Cliente_CA(nro_ca) ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE Caja(
	cod_caja MEDIUMINT CHECK (cod_caja > 9999 AND cod_caja < 100000),
	PRIMARY KEY (cod_caja)
) ENGINE=InnoDB;

CREATE TABLE Ventanilla(
	cod_caja MEDIUMINT CHECK (cod_caja > 9999 AND cod_caja < 100000),
	nro_suc SMALLINT CHECK (nro_suc > 99 AND nro_suc < 1000),
	PRIMARY KEY (cod_caja),
	CONSTRAINT fk_ventanilla_caja FOREIGN KEY (cod_caja) REFERENCES Caja(cod_caja) ON UPDATE CASCADE,
	CONSTRAINT fk_ventanilla_sucursal FOREIGN KEY (nro_suc) REFERENCES Sucursal(nro_suc) ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE ATM(
	cod_caja MEDIUMINT CHECK (cod_caja > 9999 AND cod_caja < 100000),
	cod_postal SMALLINT CHECK (cod_postal > 999 AND cod_postal < 10000),
	direccion VARCHAR(45),
	PRIMARY KEY (cod_caja),
	CONSTRAINT fk_atm_caja FOREIGN KEY (cod_caja) REFERENCES Caja(cod_caja) ON UPDATE CASCADE,
	CONSTRAINT fk_atm_ciudad FOREIGN KEY (cod_postal) REFERENCES Ciudad(cod_postal) ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE Transaccion(
	nro_trans BIGINT CHECK (nro_trans > 999999999 AND nro_trans < 10000000000),
	fecha DATE,
	hora TIME,
	monto DOUBLE CHECK (monto > 0),
	PRIMARY KEY (nro_trans)
) ENGINE=InnoDB;

CREATE TABLE Debito(
	nro_trans BIGINT CHECK (nro_trans > 999999999 AND nro_trans < 10000000000),
	descripcion VARCHAR(255),
	nro_cliente SMALLINT CHECK (nro_cliente > 9999 AND nro_cliente < 100000),
	nro_ca INT CHECK (nro_ca > 9999999 AND nro_ca < 100000000),
	PRIMARY KEY (nro_trans),
	CONSTRAINT fk_debito_transaccion FOREIGN KEY (nro_trans) REFERENCES Transaccion(nro_trans) ON UPDATE CASCADE,
	CONSTRAINT fk_debito_cliente FOREIGN KEY (nro_cliente) REFERENCES Cliente_CA(nro_cliente) ON UPDATE CASCADE,
	CONSTRAINT fk_debito_caja FOREIGN KEY (nro_ca) REFERENCES Cliente_CA(nro_ca) ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE Transaccion_por_caja(
	nro_trans BIGINT CHECK (nro_trans > 999999999 AND nro_trans < 10000000000),
	cod_caja MEDIUMINT CHECK (cod_caja > 9999 AND cod_caja < 100000),
	PRIMARY KEY (nro_trans),
	CONSTRAINT fk_transaccion_por_caja_transaccion FOREIGN KEY (nro_trans) REFERENCES Transaccion(nro_trans) ON UPDATE CASCADE,
	CONSTRAINT fk_transaccion_por_caja_caja FOREIGN KEY (cod_caja) REFERENCES Caja(cod_caja) ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE Deposito(
	nro_trans BIGINT CHECK (nro_trans > 999999999 AND nro_trans < 10000000000),
	nro_ca INT CHECK (nro_ca > 9999999 AND nro_ca < 100000000),
	PRIMARY KEY (nro_trans),
	CONSTRAINT fk_deposito_transaccion FOREIGN KEY (nro_trans) REFERENCES Transaccion_por_caja(nro_trans) ON UPDATE CASCADE,
	CONSTRAINT fk_deposito_caja FOREIGN KEY (nro_ca) REFERENCES Caja_Ahorro(nro_ca) ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE Extraccion(
	nro_trans BIGINT CHECK (nro_trans > 999999999 AND nro_trans < 10000000000),
	nro_cliente SMALLINT CHECK (nro_cliente > 9999 AND nro_cliente < 100000),
	nro_ca INT CHECK (nro_ca > 9999999 AND nro_ca < 100000000),
	PRIMARY KEY (nro_trans),
	CONSTRAINT fk_extraccion_transaccion FOREIGN KEY (nro_trans) REFERENCES Transaccion_por_caja(nro_trans) ON UPDATE CASCADE,
	CONSTRAINT fk_extraccion_cliente FOREIGN KEY (nro_cliente) REFERENCES Cliente_CA(nro_cliente) ON UPDATE CASCADE,
	CONSTRAINT fk_extraccion_caja FOREIGN KEY (nro_ca) REFERENCES Cliente_CA(nro_ca) ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE Transferencia(
	nro_trans BIGINT CHECK (nro_trans > 999999999 AND nro_trans < 10000000000),
	nro_cliente SMALLINT CHECK (nro_cliente > 9999 AND nro_cliente < 100000),
	origen INT CHECK (origen > 9999999 AND origen < 100000000),
	destino INT CHECK (destino > 9999999 AND destino < 100000000),
	PRIMARY KEY (nro_trans),
	CONSTRAINT fk_transferencia_transaccion FOREIGN KEY (nro_trans) REFERENCES Transaccion_por_caja(nro_trans) ON UPDATE CASCADE,
	CONSTRAINT fk_transferencia_cliente FOREIGN KEY (nro_cliente) REFERENCES Cliente_CA(nro_cliente) ON UPDATE CASCADE,
	CONSTRAINT fk_transferencia_origen FOREIGN KEY (origen) REFERENCES Cliente_CA(nro_ca) ON UPDATE CASCADE,
	CONSTRAINT fk_transferencia_destino FOREIGN KEY (destino) REFERENCES Cliente_CA(nro_ca) ON UPDATE CASCADE
) ENGINE=InnoDB;

#--------------------------------------------------
# CREACIÓN DE VISTAS
/*
CREATE VIEW trans_cajas_ahorro AS
SELECT banco.Caja_Ahorro.nro_ca, banco.Caja_Ahorro.saldo, banco.Transaccion.nro_trans, banco.Transaccion.fecha, banco.Transaccion.hora,
*/
#--------------------------------------------------
# CREACIÓN DE USUARIOS

CREATE USER 'admin'@'localhost' IDENTIFIED BY 'admin';
GRANT ALL PRIVILEGES ON banco.* TO 'admin'@'localhost' WITH GRANT OPTION;

DROP USER IF EXISTS ''@'localhost';

CREATE USER 'empleado' IDENTIFIED BY 'empleado';
GRANT SELECT ON banco.Empleado TO 'empleado';
GRANT SELECT ON banco.Sucursal TO 'empleado';
GRANT SELECT ON banco.Tasa_Plazo_Fijo TO 'empleado';
GRANT SELECT ON banco.Tasa_Prestamo TO 'empleado';
GRANT SELECT, INSERT ON banco.Prestamo TO 'empleado';
GRANT SELECT, INSERT ON banco.Plazo_Fijo TO 'empleado';
GRANT SELECT, INSERT ON banco.Plazo_Cliente TO 'empleado';
GRANT SELECT, INSERT ON banco.Caja_Ahorro TO 'empleado';
GRANT SELECT, INSERT ON banco.Tarjeta TO 'empleado';
GRANT SELECT, INSERT, UPDATE ON banco.Cliente_CA TO 'empleado';
GRANT SELECT, INSERT, UPDATE ON banco.Cliente TO 'empleado';
GRANT SELECT, INSERT, UPDATE ON banco.Pago TO 'empleado'; 

CREATE USER 'atm' IDENTIFIED BY 'atm';
--GRANT SELECT ON banco.trans_cajas_ahorro TO 'atm'
GRANT SELECT, UPDATE ON banco.Tarjeta TO 'atm';
