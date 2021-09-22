CREATE VIEW	trans_cajas_ahorro AS
SELECT caja_ahorro.nro_ca, caja_ahorro.saldo, transaccion.nro_trans, transaccion.fecha, transaccion.hora, transaccion.monto, /*caja.cod_caja,*/ cliente.nro_cliente, cliente.tipo_doc, cliente.nro_doc, cliente.nombre, cliente.apellido
FROM caja_ahorro NATURAL JOIN transaccion NATURAL JOIN cliente;
