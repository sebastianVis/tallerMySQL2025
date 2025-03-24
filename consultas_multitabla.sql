-- Primer Ejercicio
SELECT 
    Pedidos.id AS pedido_id, 
    Clientes.nombre AS cliente, 
    Pedidos.fecha, 
    Pedidos.total
FROM Pedidos
INNER JOIN Clientes ON Pedidos.cliente_id = Clientes.id;


-- Segundo Ejercicio
SELECT 
    Pedidos.id AS pedido_id, 
    Clientes.nombre AS cliente, 
    Ubicaciones.direccion, 
    Ubicaciones.ciudad, 
    Ubicaciones.estado, 
    Ubicaciones.pais
FROM Pedidos
INNER JOIN Clientes ON Pedidos.cliente_id = Clientes.id
LEFT JOIN Ubicaciones ON Ubicaciones.entidad_id = Clientes.id 
                      AND Ubicaciones.entidad_tipo = 'Cliente';


-- Tercer Ejercicio
SELECT 
    Productos.nombre AS producto, 
    Proveedores.nombre AS proveedor, 
    TiposProductos.nombre AS tipo_producto
FROM Productos
INNER JOIN Proveedores ON Productos.proveedor_id = Proveedores.id
INNER JOIN TiposProductos ON Productos.tipo_id = TiposProductos.id;


-- Cuarto Ejercicio
SELECT 
    DatosEmpleados.nombre AS empleado, 
    Pedidos.id AS pedido_id, 
    Clientes.nombre AS cliente, 
    Ubicaciones.ciudad
FROM Pedidos
INNER JOIN Clientes ON Pedidos.cliente_id = Clientes.id
INNER JOIN Ubicaciones ON Ubicaciones.entidad_id = Clientes.id 
                       AND Ubicaciones.entidad_tipo = 'Cliente'
INNER JOIN EmpleadosPedidos ON Pedidos.id = EmpleadosPedidos.pedido_id
INNER JOIN DatosEmpleados ON EmpleadosPedidos.empleado_id = DatosEmpleados.id
WHERE Ubicaciones.ciudad = 'Ciudad A'; -- Cambia 'Ciudad A' por la ciudad específica


-- Quinto Ejercicio
SELECT 
    Productos.nombre AS producto, 
    SUM(DetallesPedido.cantidad) AS total_vendido
FROM DetallesPedido
INNER JOIN Productos ON DetallesPedido.producto_id = Productos.id
GROUP BY Productos.id
ORDER BY total_vendido DESC
LIMIT 5;


-- Sexto Ejercicio
SELECT 
    Clientes.nombre AS cliente, 
    Ubicaciones.ciudad, 
    COUNT(Pedidos.id) AS total_pedidos
FROM Clientes
LEFT JOIN Pedidos ON Clientes.id = Pedidos.cliente_id
LEFT JOIN Ubicaciones ON Ubicaciones.entidad_id = Clientes.id 
                      AND Ubicaciones.entidad_tipo = 'Cliente'
GROUP BY Clientes.id, Ubicaciones.ciudad;


-- Septimo Ejercicio
SELECT 
    Clientes.nombre AS cliente, 
    Proveedores.nombre AS proveedor, 
    Ubicaciones.ciudad
FROM Clientes
INNER JOIN Ubicaciones AS UbicacionClientes ON UbicacionClientes.entidad_id = Clientes.id 
                                            AND UbicacionClientes.entidad_tipo = 'Cliente'
INNER JOIN Proveedores ON UbicacionClientes.ciudad = (
    SELECT UbicacionProveedores.ciudad 
    FROM Ubicaciones AS UbicacionProveedores 
    WHERE UbicacionProveedores.entidad_id = Proveedores.id 
          AND UbicacionProveedores.entidad_tipo = 'Proveedor'
);


-- Octavo Ejercicio
SELECT 
    TiposProductos.nombre AS tipo_producto, 
    SUM(DetallesPedido.cantidad * DetallesPedido.precio) AS total_ventas
FROM DetallesPedido
INNER JOIN Productos ON DetallesPedido.producto_id = Productos.id
INNER JOIN TiposProductos ON Productos.tipo_id = TiposProductos.id
GROUP BY TiposProductos.id;


-- Noveno Ejercicio
SELECT 
    DISTINCT DatosEmpleados.nombre AS empleado
FROM DatosEmpleados
INNER JOIN EmpleadosPedidos ON DatosEmpleados.id = EmpleadosPedidos.empleado_id
INNER JOIN Pedidos ON EmpleadosPedidos.pedido_id = Pedidos.id
INNER JOIN DetallesPedido ON Pedidos.id = DetallesPedido.pedido_id
INNER JOIN Productos ON DetallesPedido.producto_id = Productos.id
INNER JOIN Proveedores ON Productos.proveedor_id = Proveedores.id
WHERE Proveedores.nombre = 'Proveedor X'; -- Cambia 'Proveedor X' por el proveedor específico


-- Decimo Ejercicio
SELECT 
    Proveedores.nombre AS proveedor, 
    SUM(DetallesPedido.cantidad * DetallesPedido.precio) AS ingreso_total
FROM DetallesPedido
INNER JOIN Productos ON DetallesPedido.producto_id = Productos.id
INNER JOIN Proveedores ON Productos.proveedor_id = Proveedores.id
GROUP BY Proveedores.id;
