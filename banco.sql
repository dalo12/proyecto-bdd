CREATE DATABASE banco CHARACTER SET latin1 COLLATE latin1_spanish_ci;

USE banco;

#--------------------------------------------------
# CREACIÓN DE ENTIDADES

CREATE TABLE ciudad(
	cod_postal SMALLINT UNSIGNED CHECK (cod_postal > 999 AND cod_postal < 10000),
	nombre VARCHAR(45) NOT NULL,
	PRIMARY KEY (cod_postal)
) ENGINE=InnoDB;

CREATE TABLE sucursal(
	nro_suc SMALLINT UNSIGNED AUTO_INCREMENT,
	nombre VARCHAR(45) NOT NULL,
	direccion VARCHAR(45) NOT NULL,
	telefono VARCHAR(45) NOT NULL,
	horario VARCHAR(45) NOT NULL,
	cod_postal SMALLINT UNSIGNED NOT NULL,# CHECK (cod_postal > 999 AND cod_postal < 10000),
	PRIMARY KEY (nro_suc),
	CONSTRAINT fk_sucursal_ciudad 
		FOREIGN KEY (cod_postal) REFERENCES ciudad(cod_postal) 
		ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE empleado(
	legajo SMALLINT UNSIGNED AUTO_INCREMENT,
	apellido VARCHAR(45) NOT NULL,
	nombre VARCHAR(45) NOT NULL,
	tipo_doc VARCHAR(20) NOT NULL,
	nro_doc INT UNSIGNED NOT NULL CHECK (nro_doc > 9999999 AND nro_doc < 100000000),
	direccion VARCHAR(45) NOT NULL,
	telefono VARCHAR(25) NOT NULL,
	cargo VARCHAR(45) NOT NULL,
	password CHAR(32) NOT NULL,
	nro_suc SMALLINT UNSIGNED NOT NULL,
	PRIMARY KEY (legajo),
	CONSTRAINT fk_empleado_sucursal 
		FOREIGN KEY (nro_suc) REFERENCES sucursal(nro_suc) 
		ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE cliente(
	nro_cliente SMALLINT UNSIGNED AUTO_INCREMENT, 
	apellido VARCHAR(45) NOT NULL,
	nombre VARCHAR(45) NOT NULL,
	tipo_doc VARCHAR(20) NOT NULL,
	nro_doc INT UNSIGNED NOT NULL CHECK (nro_doc > 9999999 AND nro_doc < 100000000),
	direccion VARCHAR(45) NOT NULL,
	telefono VARCHAR(25) NOT NULL,
	fecha_nac DATE NOT NULL,
	PRIMARY KEY (nro_cliente) 	
) ENGINE=InnoDB;

CREATE TABLE plazo_fijo(
	nro_plazo INT UNSIGNED AUTO_INCREMENT,
	capital DECIMAL(16,2) UNSIGNED NOT NULL CHECK (capital > 0),
	fecha_inicio DATE NOT NULL,
	fecha_fin DATE NOT NULL,
	tasa_interes DECIMAL(4,2) UNSIGNED NOT NULL CHECK (tasa_interes > 0),
	interes DECIMAL(16,2) UNSIGNED NOT NULL CHECK (interes > 0),
	nro_suc SMALLINT UNSIGNED NOT NULL,
	PRIMARY KEY (nro_plazo),
	CONSTRAINT fk_plazo_fijo_sucursal 
		FOREIGN KEY (nro_suc) REFERENCES sucursal(nro_suc) 
		ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE tasa_plazo_fijo(
	periodo SMALLINT UNSIGNED CHECK (periodo > 99 AND periodo < 1000),
	monto_inf DECIMAL(16,2) UNSIGNED CHECK (monto_inf > 0),
	monto_sup DECIMAL(16,2) UNSIGNED CHECK (monto_sup > 0),
	tasa DECIMAL(4,2) UNSIGNED NOT NULL CHECK (tasa > 0),
	PRIMARY KEY (periodo, monto_inf, monto_sup)
) ENGINE=InnoDB;

CREATE TABLE plazo_cliente(
	nro_plazo INT UNSIGNED,
	nro_cliente SMALLINT UNSIGNED,
	PRIMARY KEY (nro_plazo, nro_cliente),
	CONSTRAINT fk_plazo_cliente_plazo 
		FOREIGN KEY (nro_plazo) REFERENCES plazo_fijo(nro_plazo) 
		ON UPDATE CASCADE,
	CONSTRAINT fk_plazo_cliente_cliente 
		FOREIGN KEY (nro_cliente) REFERENCES cliente(nro_cliente) 
		ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE prestamo(
	nro_prestamo INT UNSIGNED AUTO_INCREMENT,
	fecha DATE NOT NULL,
	cant_meses TINYINT UNSIGNED NOT NULL CHECK (cant_meses > 9 AND cant_meses < 100),
	monto DECIMAL(10,2) UNSIGNED NOT NULL CHECK (monto > 0),
	tasa_interes DECIMAL(4,2) UNSIGNED NOT NULL CHECK (tasa_interes > 0),
	interes DECIMAL(9,2) UNSIGNED NOT NULL CHECK (interes > 0),
	valor_cuota DECIMAL(9,2) UNSIGNED NOT NULL CHECK (valor_cuota > 0),
	legajo SMALLINT UNSIGNED NOT NULL,
	nro_cliente SMALLINT UNSIGNED NOT NULL,
	PRIMARY KEY (nro_prestamo),
	CONSTRAINT fk_prestamo_legajo FOREIGN KEY (legajo) REFERENCES empleado(legajo) ON UPDATE CASCADE,
	CONSTRAINT fk_prestamo_cliente FOREIGN KEY (nro_cliente) REFERENCES cliente(nro_cliente) ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE pago(
	nro_prestamo INT UNSIGNED,
	nro_pago TINYINT UNSIGNED CHECK (nro_pago > 9 AND nro_pago < 100),
	fecha_venc DATE NOT NULL,
	fecha_pago DATE,
	PRIMARY KEY (nro_prestamo, nro_pago),
	CONSTRAINT fk_pago_prestamo FOREIGN KEY (nro_prestamo) REFERENCES prestamo(nro_prestamo) ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE tasa_prestamo(
	periodo SMALLINT UNSIGNED CHECK (periodo > 99 AND periodo < 1000),
	monto_inf DECIMAL(10,2) UNSIGNED CHECK (monto_inf > 0),
	monto_sup DECIMAL(10,2) UNSIGNED CHECK (monto_sup > 0),
	tasa DECIMAL(4,2) UNSIGNED NOT NULL CHECK (tasa > 0),
	PRIMARY KEY (periodo, monto_inf, monto_sup)
) ENGINE=InnoDB;

CREATE TABLE caja_ahorro(
	nro_ca INT UNSIGNED AUTO_INCREMENT,
	cbu BIGINT UNSIGNED NOT NULL CHECK (cbu > 99999999999999999 AND cbu < 1000000000000000000),
	saldo DECIMAL(16,2) UNSIGNED NOT NULL,
	PRIMARY KEY (nro_ca)
) ENGINE=InnoDB;

CREATE TABLE cliente_ca(
	nro_cliente SMALLINT UNSIGNED,
	nro_ca INT UNSIGNED,
	PRIMARY KEY (nro_cliente, nro_ca),
	CONSTRAINT fk_cliente_ca_cliente 
		FOREIGN KEY (nro_cliente) REFERENCES cliente(nro_cliente) 
		ON UPDATE CASCADE,
	CONSTRAINT fk_cliente_ca_caja 
		FOREIGN KEY (nro_ca) REFERENCES caja_ahorro(nro_ca) 
		ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE tarjeta(
	nro_tarjeta BIGINT UNSIGNED AUTO_INCREMENT,
	pin CHAR(32) NOT NULL,
	cvt CHAR(32) NOT NULL,
	fecha_venc DATE NOT NULL,
	nro_cliente SMALLINT UNSIGNED NOT NULL,
	nro_ca INT UNSIGNED NOT NULL,
	PRIMARY KEY (nro_tarjeta),
	CONSTRAINT fk_tarjeta_cliente_cuenta 
		FOREIGN KEY (nro_cliente, nro_ca) REFERENCES cliente_ca(nro_cliente, nro_ca) 
		ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE caja(
	cod_caja MEDIUMINT UNSIGNED AUTO_INCREMENT,
	PRIMARY KEY (cod_caja)
) ENGINE=InnoDB;

CREATE TABLE ventanilla(
	cod_caja MEDIUMINT UNSIGNED,
	nro_suc SMALLINT UNSIGNED NOT NULL,
	PRIMARY KEY (cod_caja),
	CONSTRAINT fk_ventanilla_caja FOREIGN KEY (cod_caja) REFERENCES caja(cod_caja) ON UPDATE CASCADE,
	CONSTRAINT fk_ventanilla_sucursal FOREIGN KEY (nro_suc) REFERENCES sucursal(nro_suc) ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE atm(
	cod_caja MEDIUMINT UNSIGNED,
	cod_postal SMALLINT UNSIGNED NOT NULL,# CHECK (cod_postal > 999 AND cod_postal < 10000),
	direccion VARCHAR(45) NOT NULL,
	PRIMARY KEY (cod_caja),
	CONSTRAINT fk_atm_caja FOREIGN KEY (cod_caja) REFERENCES caja(cod_caja) ON UPDATE CASCADE,
	CONSTRAINT fk_atm_ciudad FOREIGN KEY (cod_postal) REFERENCES ciudad(cod_postal) ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE transaccion(
	nro_trans BIGINT UNSIGNED AUTO_INCREMENT,
	fecha DATE NOT NULL,
	hora TIME NOT NULL,
	monto DECIMAL(16,2) UNSIGNED NOT NULL CHECK (monto > 0),
	PRIMARY KEY (nro_trans)
) ENGINE=InnoDB;

CREATE TABLE debito(
	nro_trans BIGINT UNSIGNED,
	descripcion TEXT,
	nro_cliente SMALLINT UNSIGNED NOT NULL,
	nro_ca INT UNSIGNED NOT NULL,
	PRIMARY KEY (nro_trans),
	CONSTRAINT fk_debito_transaccion 
		FOREIGN KEY (nro_trans) REFERENCES transaccion(nro_trans) 
		ON UPDATE CASCADE,
	CONSTRAINT fk_debito_cliente_caja 
		FOREIGN KEY (nro_cliente, nro_ca) REFERENCES cliente_ca(nro_cliente, nro_ca) 
		ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE transaccion_por_caja(
	nro_trans BIGINT UNSIGNED,
	cod_caja MEDIUMINT UNSIGNED NOT NULL,
	PRIMARY KEY (nro_trans),
	CONSTRAINT fk_transaccion_por_caja_transaccion 
		FOREIGN KEY (nro_trans) REFERENCES transaccion(nro_trans) 
		ON UPDATE CASCADE,
	CONSTRAINT fk_transaccion_por_caja_caja 
		FOREIGN KEY (cod_caja) REFERENCES caja(cod_caja) 
		ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE deposito(
	nro_trans BIGINT UNSIGNED,
	nro_ca INT UNSIGNED NOT NULL,
	PRIMARY KEY (nro_trans),
	CONSTRAINT fk_deposito_transaccion 
		FOREIGN KEY (nro_trans) REFERENCES transaccion_por_caja(nro_trans) 
		ON UPDATE CASCADE,
	CONSTRAINT fk_deposito_caja 
		FOREIGN KEY (nro_ca) REFERENCES caja_ahorro(nro_ca) 
		ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE extraccion(
	nro_trans BIGINT UNSIGNED,
	nro_cliente SMALLINT UNSIGNED NOT NULL,
	nro_ca INT UNSIGNED NOT NULL,
	PRIMARY KEY (nro_trans),
	CONSTRAINT fk_extraccion_transaccion 
		FOREIGN KEY (nro_trans) REFERENCES transaccion_por_caja(nro_trans) 
		ON UPDATE CASCADE,
	CONSTRAINT fk_extraccion_cliente_caja 
		FOREIGN KEY (nro_cliente, nro_ca) REFERENCES cliente_ca(nro_cliente, nro_ca) 
		ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE transferencia(
	nro_trans BIGINT UNSIGNED,
	nro_cliente SMALLINT UNSIGNED NOT NULL,
	origen INT UNSIGNED NOT NULL,# CHECK (origen > 9999999 AND origen < 100000000),
	destino INT UNSIGNED NOT NULL,# CHECK (destino > 9999999 AND destino < 100000000),
	PRIMARY KEY (nro_trans),
	CONSTRAINT fk_transferencia_transaccion 
		FOREIGN KEY (nro_trans) REFERENCES transaccion_por_caja(nro_trans) 
		ON UPDATE CASCADE,
	CONSTRAINT fk_transferencia_cliente 
		FOREIGN KEY (nro_cliente, origen) REFERENCES cliente_ca(nro_cliente, nro_ca) 
		ON UPDATE CASCADE,
	CONSTRAINT fk_transferencia_destino 
		FOREIGN KEY (destino) REFERENCES caja_ahorro(nro_ca) 
		ON UPDATE CASCADE
) ENGINE=InnoDB;

#--------------------------------------------------
# CREACIÓN DE VISTAS

CREATE VIEW	trans_cajas_ahorro AS
(/* Consulta para débito */
SELECT caja_ahorro.nro_ca, caja_ahorro.saldo, transaccion.nro_trans, transaccion.fecha, transaccion.hora, "debito" AS "tipo", transaccion.monto, NULL AS "cod_caja", cliente.nro_cliente, cliente.tipo_doc, cliente.nro_doc, cliente.nombre, cliente.apellido, NULL AS "destino"
FROM caja_ahorro, transaccion, debito, cliente
WHERE (transaccion.nro_trans = debito.nro_trans) AND (debito.nro_ca = caja_ahorro.nro_ca) AND (debito.nro_cliente = cliente.nro_cliente)
)
UNION
(
/* Consulta para extracción */
SELECT caja_ahorro.nro_ca, caja_ahorro.saldo, transaccion.nro_trans, transaccion.fecha, transaccion.hora, "extraccion" AS "tipo", transaccion.monto, extraccion.nro_ca AS "cod_caja", cliente.nro_cliente, cliente.tipo_doc, cliente.nro_doc, cliente.nombre, cliente.apellido, NULL AS "destino"
FROM caja_ahorro, transaccion, extraccion, cliente
WHERE (transaccion.nro_trans = extraccion.nro_trans) AND (extraccion.nro_ca = caja_ahorro.nro_ca) AND (extraccion.nro_cliente = cliente.nro_cliente)
)
UNION
(
/* Consulta para transferencia */
SELECT caja_ahorro.nro_ca, caja_ahorro.saldo, transaccion.nro_trans, transaccion.fecha, transaccion.hora, "transferencia" AS "tipo", transaccion.monto, transferencia.origen AS "cod_caja", cliente.nro_cliente, cliente.tipo_doc, cliente.nro_doc, cliente.nombre, cliente.apellido, transferencia.destino
FROM caja_ahorro, transaccion, transferencia, cliente
WHERE (transaccion.nro_trans = transferencia.nro_trans) AND (transferencia.origen = caja_ahorro.nro_ca) AND (transferencia.nro_cliente = cliente.nro_cliente)
)
UNION
(
/* Consulta para depósito */
SELECT caja_ahorro.nro_ca, caja_ahorro.saldo, transaccion.nro_trans, transaccion.fecha, transaccion.hora, "deposito" AS "tipo", transaccion.monto, deposito.nro_ca AS "cod_caja", cliente.nro_cliente, cliente.tipo_doc, cliente.nro_doc, cliente.nombre, cliente.apellido, NULL AS "destino"
FROM caja_ahorro, cliente_ca, transaccion, deposito, cliente
WHERE (transaccion.nro_trans = deposito.nro_trans) AND (deposito.nro_ca = caja_ahorro.nro_ca) AND (caja_ahorro.nro_ca = cliente_ca.nro_ca) AND (cliente_ca.nro_cliente = cliente.nro_cliente)
);


#--------------------------------------------------
# CREACIÓN DE USUARIOS

CREATE USER 'admin'@'localhost' IDENTIFIED BY 'admin';
GRANT ALL PRIVILEGES ON banco.* TO 'admin'@'localhost' WITH GRANT OPTION;

DROP USER IF EXISTS ''@'localhost';

CREATE USER 'empleado' IDENTIFIED BY 'empleado';
GRANT SELECT ON banco.empleado TO 'empleado';
GRANT SELECT ON banco.sucursal TO 'empleado';
GRANT SELECT ON banco.tasa_plazo_fijo TO 'empleado';
GRANT SELECT ON banco.tasa_prestamo TO 'empleado';
GRANT SELECT, INSERT ON banco.prestamo TO 'empleado';
GRANT SELECT, INSERT ON banco.plazo_fijo TO 'empleado';
GRANT SELECT, INSERT ON banco.plazo_cliente TO 'empleado';
GRANT SELECT, INSERT ON banco.caja_ahorro TO 'empleado';
GRANT SELECT, INSERT ON banco.tarjeta TO 'empleado';
GRANT SELECT, INSERT, UPDATE ON banco.cliente_ca TO 'empleado';
GRANT SELECT, INSERT, UPDATE ON banco.cliente TO 'empleado';
GRANT SELECT, INSERT, UPDATE ON banco.pago TO 'empleado';

CREATE USER 'atm' IDENTIFIED BY 'atm';
GRANT SELECT ON banco.trans_cajas_ahorro TO 'atm';
GRANT SELECT, UPDATE ON banco.tarjeta TO 'atm';
