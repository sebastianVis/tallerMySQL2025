-- Primer Ejercicio
SELECT nombre, precio, tipo_id 
FROM Productos 
WHERE precio = (
    SELECT MAX(precio) 
    FROM Productos AS P 
    WHERE P.tipo_id = Productos.tipo_id
);


-- Segundo Ejercicio
SELECT nombre, total_pedidos 
FROM (
    SELECT Clientes.nombre, SUM(Pedidos.total) AS total_pedidos
    FROM Clientes
    INNER JOIN Pedidos ON Clientes.id = Pedidos.cliente_id
    GROUP BY Clientes.id
) AS TotalClientes
ORDER BY total_pedidos DESC
LIMIT 1;


-- Tercer Ejercicio
SELECT nombre, salario_base 
FROM DatosEmpleados
WHERE salario_base > (
    SELECT AVG(salario_base) 
    FROM DatosEmpleados
);


-- Cuarto Ejercicio
SELECT nombre 
FROM Productos 
WHERE id IN (
    SELECT producto_id 
    FROM DetallesPedido 
    GROUP BY producto_id 
    HAVING COUNT(*) > 5
);


-- Quinto Ejercicio
SELECT id, cliente_id, total 
FROM Pedidos 
WHERE total > (
    SELECT AVG(total) FROM Pedidos
);

-- Sexto Ejercicio
SELECT nombre, total_productos 
FROM (
    SELECT Proveedores.nombre, COUNT(Productos.id) AS total_productos
    FROM Proveedores
    INNER JOIN Productos ON Proveedores.id = Productos.proveedor_id
    GROUP BY Proveedores.id
) AS ProveedorProductos
ORDER BY total_productos DESC
LIMIT 3;


-- Septimo Ejercicio
SELECT nombre, precio, tipo_id 
FROM Productos 
WHERE precio > (
    SELECT AVG(precio) 
    FROM Productos AS P 
    WHERE P.tipo_id = Productos.tipo_id
);


-- Octavo Ejercicio
SELECT nombre, total_pedidos 
FROM (
    SELECT Clientes.nombre, COUNT(Pedidos.id) AS total_pedidos
    FROM Clientes
    LEFT JOIN Pedidos ON Clientes.id = Pedidos.cliente_id
    GROUP BY Clientes.id
) AS ClientePedidos
WHERE total_pedidos > (
    SELECT AVG(total_pedidos) 
    FROM (
        SELECT COUNT(Pedidos.id) AS total_pedidos
        FROM Pedidos
        GROUP BY cliente_id
    ) AS PromedioPedidos
);


-- Noveno Ejercicio
SELECT nombre, precio 
FROM Productos 
WHERE precio > (
    SELECT AVG(precio) FROM Productos
);


-- Decimo Ejercicio
SELECT nombre, salario_base, puesto_id 
FROM DatosEmpleados 
WHERE salario_base < (
    SELECT AVG(salario_base) 
    FROM DatosEmpleados AS DE 
    WHERE DE.puesto_id = DatosEmpleados.puesto_id
);