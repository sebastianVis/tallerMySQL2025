-- Insertar Clientes
INSERT INTO Clientes (nombre, email) VALUES
('Juan Pérez', 'juan.perez@email.com'),
('María Gómez', 'maria.gomez@email.com'),
('Carlos Ramírez', 'carlos.ramirez@email.com');

-- Insertar Teléfonos
INSERT INTO Telefonos (cliente_id, numero, tipo) VALUES
(1, '555-1234', 'Móvil'),
(1, '555-5678', 'Trabajo'),
(2, '555-9876', 'Móvil');

-- Insertar Ubicaciones (Clientes y Proveedores)
INSERT INTO Ubicaciones (entidad_id, entidad_tipo, direccion, ciudad, estado, codigo_postal, pais) VALUES
(1, 'Cliente', 'Calle Falsa 123', 'Ciudad A', 'Estado X', '10001', 'México'),
(2, 'Cliente', 'Avenida Siempre Viva 742', 'Ciudad B', 'Estado Y', '20002', 'Argentina');

-- Insertar Puestos
INSERT INTO Puestos (nombre, salario_base) VALUES
('Gerente', 50000.00),
('Vendedor', 20000.00);

-- Insertar Empleados
INSERT INTO DatosEmpleados (nombre, puesto_id, fecha_contratacion) VALUES
('Ana Torres', 1, '2023-05-10'),
('Luis Fernández', 2, '2024-01-15');

-- Insertar Proveedores
INSERT INTO Proveedores (nombre, direccion) VALUES
('Tech Supplies', 'Calle Comercio 45'),
('Insumos Global', 'Avenida Central 99');

-- Insertar Contactos de Proveedores
INSERT INTO ContactoProveedores (proveedor_id, nombre_contacto, telefono, email) VALUES
(1, 'Pedro López', '555-0001', 'pedro.lopez@techsupplies.com'),
(2, 'Laura Méndez', '555-0002', 'laura.mendez@insumosglobal.com');

-- Insertar Tipos de Productos (Categoría Jerárquica)
INSERT INTO TiposProductos (nombre, descripcion, padre_id) VALUES
('Electrónica', 'Productos electrónicos', NULL),
('Computadoras', 'Laptops y PC', 1),
('Accesorios', 'Teclados, Mouse, etc.', 1);

-- Insertar Productos
INSERT INTO Productos (nombre, precio, proveedor_id, tipo_id) VALUES
('Laptop HP', 1200.50, 1, 2),
('Mouse Inalámbrico', 25.75, 2, 3);

-- Insertar Pedidos
INSERT INTO Pedidos (cliente_id, fecha, total) VALUES
(1, '2024-03-10', 1226.25),
(2, '2024-03-15', 25.75);

-- Insertar Detalles de Pedidos
INSERT INTO DetallesPedido (pedido_id, producto_id, cantidad, precio_unitario) VALUES
(1, 1, 1, 1200.50),
(1, 2, 1, 25.75),
(2, 2, 1, 25.75);

-- Insertar Historial de Pedidos
INSERT INTO HistorialPedidos (pedido_id, cambio) VALUES
(1, 'Pedido creado'),
(1, 'Cambio en cantidad de productos'),
(2, 'Pedido enviado');

-- Relación de Empleados con Proveedores
INSERT INTO EmpleadosProveedores (empleado_id, proveedor_id) VALUES
(1, 1),
(2, 2);
-- Insertar Clientes
INSERT INTO Clientes (nombre, email) VALUES
('Juan Pérez', 'juan.perez@email.com'),
('María Gómez', 'maria.gomez@email.com'),
('Carlos Ramírez', 'carlos.ramirez@email.com');

-- Insertar Teléfonos
INSERT INTO Telefonos (cliente_id, numero, tipo) VALUES
(1, '555-1234', 'Móvil'),
(1, '555-5678', 'Trabajo'),
(2, '555-9876', 'Móvil');

-- Insertar Ubicaciones (Clientes y Proveedores)
INSERT INTO Ubicaciones (entidad_id, entidad_tipo, direccion, ciudad, estado, codigo_postal, pais) VALUES
(1, 'Cliente', 'Calle Falsa 123', 'Ciudad A', 'Estado X', '10001', 'México'),
(2, 'Cliente', 'Avenida Siempre Viva 742', 'Ciudad B', 'Estado Y', '20002', 'Argentina');

-- Insertar Puestos
INSERT INTO Puestos (nombre, salario_base) VALUES
('Gerente', 50000.00),
('Vendedor', 20000.00);

-- Insertar Empleados
INSERT INTO DatosEmpleados (nombre, puesto_id, fecha_contratacion) VALUES
('Ana Torres', 1, '2023-05-10'),
('Luis Fernández', 2, '2024-01-15');

-- Insertar Proveedores
INSERT INTO Proveedores (nombre, direccion) VALUES
('Tech Supplies', 'Calle Comercio 45'),
('Insumos Global', 'Avenida Central 99');

-- Insertar Contactos de Proveedores
INSERT INTO ContactoProveedores (proveedor_id, nombre_contacto, telefono, email) VALUES
(1, 'Pedro López', '555-0001', 'pedro.lopez@techsupplies.com'),
(2, 'Laura Méndez', '555-0002', 'laura.mendez@insumosglobal.com');

-- Insertar Tipos de Productos (Categoría Jerárquica)
INSERT INTO TiposProductos (nombre, descripcion, padre_id) VALUES
('Electrónica', 'Productos electrónicos', NULL),
('Computadoras', 'Laptops y PC', 1),
('Accesorios', 'Teclados, Mouse, etc.', 1);

-- Insertar Productos
INSERT INTO Productos (nombre, precio, proveedor_id, tipo_id) VALUES
('Laptop HP', 1200.50, 1, 2),
('Mouse Inalámbrico', 25.75, 2, 3);

-- Insertar Pedidos
INSERT INTO Pedidos (cliente_id, fecha, total) VALUES
(1, '2024-03-10', 1226.25),
(2, '2024-03-15', 25.75);

-- Insertar Detalles de Pedidos
INSERT INTO DetallesPedido (pedido_id, producto_id, cantidad, precio_unitario) VALUES
(1, 1, 1, 1200.50),
(1, 2, 1, 25.75),
(2, 2, 1, 25.75);

-- Insertar Historial de Pedidos
INSERT INTO HistorialPedidos (pedido_id, cambio) VALUES
(1, 'Pedido creado'),
(1, 'Cambio en cantidad de productos'),
(2, 'Pedido enviado');

-- Relación de Empleados con Proveedores
INSERT INTO EmpleadosProveedores (empleado_id, proveedor_id) VALUES
(1, 1),
(2, 2);

-- Crear índices para mejorar la eficiencia de las consultas
CREATE INDEX idx_clientes_nombre ON Clientes (nombre);
CREATE INDEX idx_pedidos_fecha ON Pedidos (fecha);
CREATE INDEX idx_productos_nombre ON Productos (nombre);
CREATE INDEX idx_proveedores_nombre ON Proveedores (nombre);

-- Crear vistas para simplificar las consultas
CREATE VIEW vista_clientes AS
SELECT c.nombre, c.email, u.direccion, u.ciudad, u.estado, u.codigo_postal, u.pais
FROM Clientes c
JOIN Ubicaciones u ON c.id = u.entidad_id
WHERE u.entidad_tipo = 'Cliente';

CREATE VIEW vista_pedidos AS
SELECT p.id, p.fecha, p.total, c.nombre AS cliente, pr.nombre AS proveedor
FROM Pedidos p
JOIN Clientes c ON p.cliente_id = c.id
JOIN Proveedores pr ON p.proveedor_id = pr.id;

CREATE VIEW vista_productos AS
SELECT pr.id, pr.nombre, pr.precio, tp.nombre AS tipo
FROM Productos pr
JOIN TiposProductos tp ON pr.tipo_id = tp.id;