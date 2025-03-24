-- Primer Ejercicio
DELIMITER //
CREATE PROCEDURE ActualizarPrecioProveedor(IN proveedorID INT, IN porcentaje DECIMAL(5,2))
BEGIN
    UPDATE Productos
    SET precio = precio * (1 + porcentaje / 100)
    WHERE proveedor_id = proveedorID;
END //
DELIMITER ;


-- Segundo Ejercicio
DELIMITER //
CREATE PROCEDURE ObtenerDireccionCliente(IN clienteID INT)
BEGIN
    SELECT direccion, ciudad, estado, codigo_postal, pais
    FROM Ubicaciones
    WHERE entidad_id = clienteID AND entidad_tipo = 'Cliente';
END //
DELIMITER ;


-- Tercer Ejercicio
DELIMITER //
CREATE PROCEDURE RegistrarPedido(
    IN clienteID INT, IN fechaPedido DATE, IN total DECIMAL(10,2),
    IN productoID INT, IN cantidad INT, IN precio DECIMAL(10,2)
)
BEGIN
    DECLARE pedidoID INT;
    
    INSERT INTO Pedidos (cliente_id, fecha, total) VALUES (clienteID, fechaPedido, total);
    SET pedidoID = LAST_INSERT_ID();
    
    INSERT INTO DetallesPedido (pedido_id, producto_id, cantidad, precio) 
    VALUES (pedidoID, productoID, cantidad, precio);
    
    SELECT 'Pedido registrado correctamente' AS Mensaje;
END //
DELIMITER ;


-- Cuarto Ejercicio
DELIMITER //
CREATE PROCEDURE TotalVentasCliente(IN clienteID INT)
BEGIN
    SELECT SUM(total) AS TotalVentas
    FROM Pedidos
    WHERE cliente_id = clienteID;
END //
DELIMITER ;


-- Quinto Ejercicio
DELIMITER //
CREATE PROCEDURE ObtenerEmpleadosPorPuesto(IN puestoID INT)
BEGIN
    SELECT nombre, salario_base, fecha_contratacion
    FROM DatosEmpleados
    WHERE puesto_id = puestoID;
END //
DELIMITER ;


-- Sexto Ejercicio
DELIMITER //
CREATE PROCEDURE ActualizarSalarioPuesto(IN puestoID INT, IN porcentaje DECIMAL(5,2))
BEGIN
    UPDATE DatosEmpleados
    SET salario_base = salario_base * (1 + porcentaje / 100)
    WHERE puesto_id = puestoID;
END //
DELIMITER ;


-- Séptimo Ejercicio
DELIMITER //
CREATE PROCEDURE PedidosEntreFechas(IN fechaInicio DATE, IN fechaFin DATE)
BEGIN
    SELECT * FROM Pedidos
    WHERE fecha BETWEEN fechaInicio AND fechaFin;
END //
DELIMITER ;


-- Octavo Ejercicio
DELIMITER //
CREATE PROCEDURE AplicarDescuentoCategoria(IN tipoID INT, IN porcentaje DECIMAL(5,2))
BEGIN
    UPDATE Productos
    SET precio = precio * (1 - porcentaje / 100)
    WHERE tipo_id = tipoID;
END //
DELIMITER ;

-- Noveno Ejercicio
DELIMITER //
CREATE PROCEDURE ProveedoresPorTipoProducto(IN tipoID INT)
BEGIN
    SELECT DISTINCT Proveedores.nombre
    FROM Proveedores
    INNER JOIN Productos ON Proveedores.id = Productos.proveedor_id
    WHERE Productos.tipo_id = tipoID;
END //
DELIMITER ;

-- Decimo Ejercicio
DELIMITER //
CREATE PROCEDURE PedidoMayorValor()
BEGIN
    SELECT * FROM Pedidos
    ORDER BY total DESC
    LIMIT 1;
END //
DELIMITER ;
