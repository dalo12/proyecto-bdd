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
