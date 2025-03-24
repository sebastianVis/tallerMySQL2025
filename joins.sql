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
    Productos.nombre AS producto, 
    Proveedores.nombre AS proveedor
FROM Productos
INNER JOIN Proveedores ON Productos.proveedor_id = Proveedores.id;


-- Tercer Ejercicio
SELECT 
    Pedidos.id AS pedido_id, 
    Clientes.nombre AS cliente, 
    Pedidos.fecha, 
    Pedidos.total, 
    Ubicaciones.direccion, 
    Ubicaciones.ciudad, 
    Ubicaciones.estado, 
    Ubicaciones.pais
FROM Pedidos
LEFT JOIN Clientes ON Pedidos.cliente_id = Clientes.id
LEFT JOIN Ubicaciones ON Ubicaciones.entidad_id = Clientes.id 
                      AND Ubicaciones.entidad_tipo = 'Cliente';


-- Cuarto Ejercicio
SELECT 
    DatosEmpleados.nombre AS empleado, 
    Pedidos.id AS pedido_id, 
    Pedidos.fecha
FROM DatosEmpleados
LEFT JOIN Pedidos ON DatosEmpleados.id = Pedidos.cliente_id;

-- Quinto Ejercicio
SELECT 
    TiposProductos.nombre AS tipo_producto, 
    Productos.nombre AS producto
FROM Productos
INNER JOIN TiposProductos ON Productos.tipo_id = TiposProductos.id;


-- Sexto Ejercicio
SELECT 
    Clientes.nombre AS cliente, 
    COUNT(Pedidos.id) AS numero_pedidos
FROM Clientes
LEFT JOIN Pedidos ON Clientes.id = Pedidos.cliente_id
GROUP BY Clientes.id;


-- Septimo Ejercicio
SELECT 
    Pedidos.id AS pedido_id, 
    DatosEmpleados.nombre AS empleado, 
    Pedidos.fecha, 
    Pedidos.total
FROM Pedidos
INNER JOIN EmpleadosProveedores ON Pedidos.cliente_id = EmpleadosProveedores.empleado_id
INNER JOIN DatosEmpleados ON EmpleadosProveedores.empleado_id = DatosEmpleados.id;


-- Octavo Ejercicio
SELECT 
    Productos.nombre AS producto
FROM Productos
RIGHT JOIN DetallesPedido ON Productos.id = DetallesPedido.producto_id
WHERE DetallesPedido.id IS NULL;


-- Noveno Ejercicio
SELECT 
    Clientes.nombre AS cliente, 
    COUNT(Pedidos.id) AS total_pedidos, 
    Ubicaciones.direccion, 
    Ubicaciones.ciudad, 
    Ubicaciones.estado, 
    Ubicaciones.pais
FROM Clientes
LEFT JOIN Pedidos ON Clientes.id = Pedidos.cliente_id
LEFT JOIN Ubicaciones ON Ubicaciones.entidad_id = Clientes.id 
                      AND Ubicaciones.entidad_tipo = 'Cliente'
GROUP BY Clientes.id;


-- Décimo Ejercicio
SELECT 
    Proveedores.nombre AS proveedor, 
    Productos.nombre AS producto, 
    TiposProductos.nombre AS tipo_producto, 
    Productos.precio
FROM Productos
INNER JOIN Proveedores ON Productos.proveedor_id = Proveedores.id
INNER JOIN TiposProductos ON Productos.tipo_id = TiposProductos.id;
