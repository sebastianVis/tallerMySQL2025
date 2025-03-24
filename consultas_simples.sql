-- Primer Ejercicio

SELECT nombre, precio
FROM productos
WHERE precio > 50;

-- Segundo Ejercicio

SELECT 
    Clientes.id, 
    Clientes.nombre, 
    Clientes.email, 
    Ubicaciones.ciudad
FROM Clientes
INNER JOIN Ubicaciones ON Ubicaciones.entidad_id = Clientes.id 
                       AND Ubicaciones.entidad_tipo = 'Cliente'
WHERE Ubicaciones.ciudad = 'Ciudad A';


-- Tercer Ejercicio

SELECT 
    id, 
    nombre, 
    fecha_contratacion 
FROM DatosEmpleados
WHERE fecha_contratacion >= DATE_SUB(CURDATE(), INTERVAL 2 YEAR);


-- Cuarto Ejercicio
SELECT 
    Proveedores.id, 
    Proveedores.nombre, 
    COUNT(Productos.id) AS total_productos
FROM Proveedores
INNER JOIN Productos ON Proveedores.id = Productos.proveedor_id
GROUP BY Proveedores.id
HAVING COUNT(Productos.id) > 5;


-- Quinto Ejercicio
SELECT 
    Clientes.id, 
    Clientes.nombre, 
    Clientes.email 
FROM Clientes
LEFT JOIN Ubicaciones ON Ubicaciones.entidad_id = Clientes.id 
                      AND Ubicaciones.entidad_tipo = 'Cliente'
WHERE Ubicaciones.id IS NULL;


-- Sexto Ejercicio
SELECT 
    Clientes.id, 
    Clientes.nombre, 
    SUM(Pedidos.total) AS total_ventas
FROM Clientes
LEFT JOIN Pedidos ON Clientes.id = Pedidos.cliente_id
GROUP BY Clientes.id;


-- Septimo Ejercicio
SELECT 
    AVG(Puestos.salario_base) AS salario_promedio
FROM Puestos;


-- Octavo Ejercicio
SELECT 
    id, 
    nombre, 
    descripcion 
FROM TiposProductos;

-- Noveno Ejercicio
SELECT 
    id, 
    nombre, 
    precio 
FROM Productos
ORDER BY precio DESC
LIMIT 3;


-- Décimo Ejercicio
SELECT 
    Clientes.id, 
    Clientes.nombre, 
    COUNT(Pedidos.id) AS total_pedidos
FROM Clientes
LEFT JOIN Pedidos ON Clientes.id = Pedidos.cliente_id
GROUP BY Clientes.id
ORDER BY total_pedidos DESC
LIMIT 1;