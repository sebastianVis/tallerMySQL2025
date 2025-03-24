-- Primer Ejercicio
DELIMITER //
CREATE FUNCTION DiasTranscurridos(fecha DATE) RETURNS INT DETERMINISTIC
BEGIN
    RETURN DATEDIFF(CURDATE(), fecha);
END //
DELIMITER ;


-- Segundo Ejercicio
DELIMITER //
CREATE FUNCTION CalcularTotalImpuesto(monto DECIMAL(10,2), impuesto DECIMAL(5,2)) 
RETURNS DECIMAL(10,2) DETERMINISTIC
BEGIN
    RETURN monto * (1 + impuesto / 100);
END //
DELIMITER ;


-- Tercer Ejercicio
DELIMITER //
CREATE FUNCTION TotalPedidosCliente(clienteID INT) RETURNS INT DETERMINISTIC
BEGIN
    DECLARE totalPedidos INT;
    SELECT COUNT(*) INTO totalPedidos FROM Pedidos WHERE cliente_id = clienteID;
    RETURN totalPedidos;
END //
DELIMITER ;


-- Cuarto Ejercicio
DELIMITER //
CREATE FUNCTION AplicarDescuento(precio DECIMAL(10,2), descuento DECIMAL(5,2)) 
RETURNS DECIMAL(10,2) DETERMINISTIC
BEGIN
    RETURN precio * (1 - descuento / 100);
END //
DELIMITER ;


-- Quinto Ejercicio
DELIMITER //
CREATE FUNCTION ClienteTieneDireccion(clienteID INT) RETURNS BOOLEAN DETERMINISTIC
BEGIN
    DECLARE tieneDireccion BOOLEAN;
    SET tieneDireccion = (SELECT COUNT(*) FROM UbicacionCliente WHERE cliente_id = clienteID) > 0;
    RETURN tieneDireccion;
END //
DELIMITER ;


-- Sexto Ejercicio
DELIMITER //
CREATE FUNCTION SalarioAnual(empleadoID INT) RETURNS DECIMAL(10,2) DETERMINISTIC
BEGIN
    DECLARE salario DECIMAL(10,2);
    SELECT salario_base * 12 INTO salario FROM DatosEmpleados WHERE id = empleadoID;
    RETURN salario;
END //
DELIMITER ;


-- Septimo Ejercicio
DELIMITER //
CREATE FUNCTION TotalVentasPorTipo(tipoID INT) RETURNS DECIMAL(10,2) DETERMINISTIC
BEGIN
    DECLARE totalVentas DECIMAL(10,2);
    SELECT SUM(DP.cantidad * DP.precio) INTO totalVentas
    FROM DetallesPedido DP
    INNER JOIN Productos P ON DP.producto_id = P.id
    WHERE P.tipo_id = tipoID;
    RETURN COALESCE(totalVentas, 0);
END //
DELIMITER ;


-- Octavo Ejercicio
DELIMITER //
CREATE FUNCTION NombreCliente(clienteID INT) RETURNS VARCHAR(100) DETERMINISTIC
BEGIN
    DECLARE nombre VARCHAR(100);
    SELECT nombre INTO nombre FROM Clientes WHERE id = clienteID;
    RETURN nombre;
END //
DELIMITER ;


-- Noveno Ejercicio
DELIMITER //
CREATE FUNCTION TotalPedido(pedidoID INT) RETURNS DECIMAL(10,2) DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(10,2);
    SELECT SUM(cantidad * precio) INTO total FROM DetallesPedido WHERE pedido_id = pedidoID;
    RETURN COALESCE(total, 0);
END //
DELIMITER ;


-- Decimo Ejercicio
DELIMITER //
CREATE FUNCTION ProductoEnInventario(productoID INT) RETURNS BOOLEAN DETERMINISTIC
BEGIN
    DECLARE enStock BOOLEAN;
    SET enStock = (SELECT COUNT(*) FROM Productos WHERE id = productoID AND stock > 0) > 0;
    RETURN enStock;
END //
DELIMITER ;
