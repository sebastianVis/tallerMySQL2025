-- 1. Función para calcular descuento por categoría de producto
CREATE FUNCTION CalcularDescuento(tipo_id INT, precio DECIMAL(10,2))
RETURNS DECIMAL(10,2) DETERMINISTIC
BEGIN
    IF tipo_id = 'Electrónica' THEN
        RETURN precio * 0.90;
    ELSE
        RETURN precio;
    END IF;
END;

-- Consulta para mostrar el nombre del producto, precio original y con descuento
SELECT nombre, precio, CalcularDescuento(tipo_id, precio) AS precio_con_descuento FROM Productos;

-- 2. Función para calcular edad de un cliente
CREATE FUNCTION CalcularEdad(fecha_nacimiento DATE)
RETURNS INT DETERMINISTIC
BEGIN
    RETURN TIMESTAMPDIFF(YEAR, fecha_nacimiento, CURDATE());
END;

-- Consulta para obtener clientes mayores de 18 años
SELECT nombre, fecha_nacimiento, CalcularEdad(fecha_nacimiento) AS edad FROM Clientes WHERE CalcularEdad(fecha_nacimiento) >= 18;

-- 3. Función para calcular el precio final con impuesto
CREATE FUNCTION CalcularImpuesto(precio DECIMAL(10,2))
RETURNS DECIMAL(10,2) DETERMINISTIC
BEGIN
    RETURN precio * 1.15;
END;

-- Consulta para obtener productos con precio final
SELECT nombre, precio, CalcularImpuesto(precio) AS precio_final FROM Productos;

-- 4. Función para calcular total de pedidos de un cliente
CREATE FUNCTION TotalPedidosCliente(cliente_id INT)
RETURNS DECIMAL(10,2) DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(10,2);
    SELECT SUM(monto) INTO total FROM Pedidos WHERE cliente_id = cliente_id;
    RETURN IFNULL(total, 0);
END;

-- Consulta para obtener clientes con pedidos mayores a $1000
SELECT nombre, TotalPedidosCliente(id) AS total_pedidos FROM Clientes WHERE TotalPedidosCliente(id) > 1000;

-- 5. Función para calcular salario anual
CREATE FUNCTION SalarioAnual(salario_mensual DECIMAL(10,2))
RETURNS DECIMAL(10,2) DETERMINISTIC
BEGIN
    RETURN salario_mensual * 12;
END;

-- Consulta para empleados con salario anual mayor a $50,000
SELECT nombre, SalarioAnual(salario) AS salario_anual FROM Empleados WHERE SalarioAnual(salario) > 50000;

-- 6. Función para calcular bonificación
CREATE FUNCTION Bonificacion(salario DECIMAL(10,2))
RETURNS DECIMAL(10,2) DETERMINISTIC
BEGIN
    RETURN salario * 0.10;
END;

-- Consulta para mostrar salario ajustado
SELECT nombre, salario, salario + Bonificacion(salario) AS salario_ajustado FROM Empleados;

-- 7. Función para calcular días desde el último pedido
CREATE FUNCTION DiasDesdeUltimoPedido(cliente_id INT)
RETURNS INT DETERMINISTIC
BEGIN
    DECLARE dias INT;
    SELECT DATEDIFF(CURDATE(), MAX(fecha)) INTO dias FROM Pedidos WHERE cliente_id = cliente_id;
    RETURN IFNULL(dias, 9999);
END;

-- Consulta para clientes con pedidos en los últimos 30 días
SELECT nombre FROM Clientes WHERE DiasDesdeUltimoPedido(id) <= 30;

-- 8. Función para calcular total en inventario
CREATE FUNCTION TotalInventarioProducto(cantidad INT, precio DECIMAL(10,2))
RETURNS DECIMAL(10,2) DETERMINISTIC
BEGIN
    RETURN cantidad * precio;
END;

-- Consulta para productos con inventario superior a $500
SELECT nombre, TotalInventarioProducto(cantidad, precio) AS total_inventario FROM Productos WHERE TotalInventarioProducto(cantidad, precio) > 500;

-- 9. Tabla para historial de precios
CREATE TABLE HistorialPrecios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    producto_id INT,
    precio_anterior DECIMAL(10,2),
    precio_nuevo DECIMAL(10,2),
    fecha_cambio TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Trigger para registrar cambios de precio
CREATE TRIGGER RegistroCambioPrecio
BEFORE UPDATE ON Productos
FOR EACH ROW
BEGIN
    IF OLD.precio <> NEW.precio THEN
        INSERT INTO HistorialPrecios (producto_id, precio_anterior, precio_nuevo)
        VALUES (OLD.id, OLD.precio, NEW.precio);
    END IF;
END;

-- 10. Procedimiento para reporte de ventas mensuales
CREATE PROCEDURE ReporteVentasMensuales(IN mes INT, IN anio INT)
BEGIN
    SELECT e.nombre, SUM(p.monto) AS total_ventas
    FROM Empleados e
    JOIN Ventas p ON e.id = p.empleado_id
    WHERE MONTH(p.fecha) = mes AND YEAR(p.fecha) = anio
    GROUP BY e.id;
END;

-- 11. Subconsulta para obtener el producto más vendido por proveedor
SELECT p.proveedor_id, p.nombre, MAX(ventas_totales)
FROM (
    SELECT pr.proveedor_id, pr.nombre, SUM(dp.cantidad) AS ventas_totales
    FROM DetallesPedido dp
    JOIN Productos pr ON dp.producto_id = pr.id
    GROUP BY pr.id
) AS ventas_por_producto
GROUP BY proveedor_id;

-- 12. Función para calcular estado de stock
CREATE FUNCTION EstadoStock(cantidad INT)
RETURNS VARCHAR(10) DETERMINISTIC
BEGIN
    RETURN CASE
        WHEN cantidad > 100 THEN 'Alto'
        WHEN cantidad BETWEEN 50 AND 100 THEN 'Medio'
        ELSE 'Bajo'
    END;
END;

-- Consulta para listar productos con su estado de stock
SELECT nombre, cantidad, EstadoStock(cantidad) AS estado_stock FROM Productos;

-- 13. Trigger para control de inventario en pedidos
CREATE TRIGGER ActualizarInventario
BEFORE INSERT ON DetallesPedido
FOR EACH ROW
BEGIN
    DECLARE stock_actual INT;
    SELECT cantidad INTO stock_actual FROM Productos WHERE id = NEW.producto_id;
    IF stock_actual < NEW.cantidad THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Stock insuficiente';
    ELSE
        UPDATE Productos SET cantidad = cantidad - NEW.cantidad WHERE id = NEW.producto_id;
    END IF;
END;

-- 14. Procedimiento para generar informe de clientes inactivos
CREATE PROCEDURE ClientesInactivos()
BEGIN
    SELECT nombre FROM Clientes WHERE id NOT IN (
        SELECT DISTINCT cliente_id FROM Pedidos WHERE fecha >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH)
    );
END;
