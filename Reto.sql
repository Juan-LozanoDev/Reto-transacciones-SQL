-- Creamos la tabla
CREATE TABLE cuentas_bancarias (
	cuenta_id SERIAL PRIMARY KEY,
	nombre_cliente VARCHAR(100) NOT NULL,
	saldo DECIMAL(10,2) NOT NULL
);

-- Insertamos los datos en la tabla
INSERT INTO cuentas_bancarias (nombre_cliente, saldo) VALUES
('Cliente A', 1000.00),
('Cliente B', 500.00),
('Cliente C', 2000.00);

-- Iniciamos la transaccion
BEGIN;
UPDATE cuentas_bancarias SET saldo = saldo - 200.00
	WHERE nombre_cliente = 'Cliente A';
UPDATE cuentas_bancarias SET saldo = saldo + 200.00
	WHERE nombre_cliente = 'Cliente B';
SAVEPOINT pago_cliente_a;	-- Punto de Guardado
UPDATE cuentas_bancarias SET saldo = saldo - 200.00
	WHERE nombre_cliente = 'Cliente B';
UPDATE cuentas_bancarias SET saldo = saldo + 200.00
	WHERE nombre_cliente = 'Cliente C';
ROLLBACK TO pago_cliente_a;	-- Regresamos a punto Guardado
COMMIT;