-- Primer Ejercicio
DELIMITER //
CREATE TRIGGER trg_HistorialSalarios
AFTER UPDATE ON DatosEmpleados
FOR EACH ROW
BEGIN
    IF OLD.salario_base <> NEW.salario_base THEN
        INSERT INTO HistorialSalarios (empleado_id, salario_anterior, salario_nuevo, fecha_cambio)
        VALUES (NEW.id, OLD.salario_base, NEW.salario_base, NOW());
    END IF;
END //
DELIMITER ;


-- Segundo Ejercicio
DELIMITER //
CREATE TRIGGER trg_EvitarBorrarProductos
BEFORE DELETE ON Productos
FOR EACH ROW
BEGIN
    IF EXISTS (SELECT 1 FROM DetallesPedido WHERE producto_id = OLD.id) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'No se puede eliminar un producto con pedidos activos';
    END IF;
END //
DELIMITER ;


-- Tercer Ejercicio
DELIMITER //
CREATE TRIGGER trg_HistorialPedidos
AFTER UPDATE ON Pedidos
FOR EACH ROW
BEGIN
    INSERT INTO HistorialPedidos (pedido_id, fecha_modificacion, total_anterior, total_nuevo)
    VALUES (NEW.id, NOW(), OLD.total, NEW.total);
END //
DELIMITER ;


-- Cuarto Ejercicio
DELIMITER //
CREATE TRIGGER trg_ActualizarInventario
AFTER INSERT ON DetallesPedido
FOR EACH ROW
BEGIN
    UPDATE Productos 
    SET stock = stock - NEW.cantidad
    WHERE id = NEW.producto_id;
END //
DELIMITER ;


-- Quinto Ejercicio
DELIMITER //
CREATE TRIGGER trg_ValidarPrecio
BEFORE UPDATE ON Productos
FOR EACH ROW
BEGIN
    IF NEW.precio < 1 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'El precio del producto no puede ser menor a $1';
    END IF;
END //
DELIMITER ;


-- Sexto Ejercicio
DELIMITER //
CREATE TRIGGER trg_RegistroCreacionPedido
AFTER INSERT ON Pedidos
FOR EACH ROW
BEGIN
    INSERT INTO HistorialPedidos (pedido_id, fecha_modificacion, total_anterior, total_nuevo)
    VALUES (NEW.id, NOW(), NULL, NEW.total);
END //
DELIMITER ;


-- Septimo Ejercicio
DELIMITER //
CREATE TRIGGER trg_CalcularTotalPedido
AFTER INSERT ON DetallesPedido
FOR EACH ROW
BEGIN
    UPDATE Pedidos
    SET total = (SELECT SUM(cantidad * precio) FROM DetallesPedido WHERE pedido_id = NEW.pedido_id)
    WHERE id = NEW.pedido_id;
END //
DELIMITER ;


-- Octavo Ejercicio
DELIMITER //
CREATE TRIGGER trg_ValidarUbicacionCliente
AFTER INSERT ON Clientes
FOR EACH ROW
BEGIN
    IF NOT EXISTS (SELECT 1 FROM UbicacionCliente WHERE cliente_id = NEW.id) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'El cliente debe tener al menos una dirección registrada';
    END IF;
END //
DELIMITER ;


-- Noveno Ejercicio
DELIMITER //
CREATE TRIGGER trg_LogProveedores
AFTER UPDATE ON Proveedores
FOR EACH ROW
BEGIN
    INSERT INTO LogActividades (tabla, registro_id, accion, fecha)
    VALUES ('Proveedores', NEW.id, 'Actualización', NOW());
END //
DELIMITER ;


-- Décimo Ejercicio
DELIMITER //
CREATE TRIGGER trg_HistorialContratos
AFTER UPDATE ON DatosEmpleados
FOR EACH ROW
BEGIN
    IF OLD.puesto_id <> NEW.puesto_id OR OLD.salario_base <> NEW.salario_base THEN
        INSERT INTO HistorialContratos (empleado_id, puesto_anterior, puesto_nuevo, salario_anterior, salario_nuevo, fecha_cambio)
        VALUES (NEW.id, OLD.puesto_id, NEW.puesto_id, OLD.salario_base, NEW.salario_base, NOW());
    END IF;
END //
DELIMITER ;
