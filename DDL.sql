-- Creación de la base de datos
CREATE DATABASE vtaszfs;
USE vtaszfs;

-- Tabla Clientes (sin teléfonos ni ubicación)
CREATE TABLE Clientes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100),
    email VARCHAR(100) UNIQUE
);

-- Tabla Telefonos (múltiples teléfonos por cliente)
CREATE TABLE Telefonos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    cliente_id INT,
    numero VARCHAR(20),
    tipo ENUM('Móvil', 'Fijo', 'Trabajo'),
    FOREIGN KEY (cliente_id) REFERENCES Clientes(id) ON DELETE CASCADE
);

-- Tabla Ubicaciones (Genérica para clientes y proveedores)
CREATE TABLE Ubicaciones (
    id INT PRIMARY KEY AUTO_INCREMENT,
    entidad_id INT, -- Puede ser Cliente o Proveedor
    entidad_tipo ENUM('Cliente', 'Proveedor'),
    direccion VARCHAR(255),
    ciudad VARCHAR(100),
    estado VARCHAR(50),
    codigo_postal VARCHAR(10),
    pais VARCHAR(50)
);

-- Tabla Puestos
CREATE TABLE Puestos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50),
    salario_base DECIMAL(10,2)
);

-- Tabla DatosEmpleados
CREATE TABLE DatosEmpleados (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100),
    puesto_id INT,
    fecha_contratacion DATE,
    FOREIGN KEY (puesto_id) REFERENCES Puestos(id)
);

-- Tabla Proveedores
CREATE TABLE Proveedores (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100),
    direccion VARCHAR(255)
);

-- Tabla ContactoProveedores (múltiples contactos por proveedor)
CREATE TABLE ContactoProveedores (
    id INT PRIMARY KEY AUTO_INCREMENT,
    proveedor_id INT,
    nombre_contacto VARCHAR(100),
    telefono VARCHAR(20),
    email VARCHAR(100),
    FOREIGN KEY (proveedor_id) REFERENCES Proveedores(id) ON DELETE CASCADE
);

-- Tabla TiposProductos (Jerarquía de categorías)
CREATE TABLE TiposProductos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100),
    descripcion TEXT,
    padre_id INT NULL,  -- Permite categorías anidadas
    FOREIGN KEY (padre_id) REFERENCES TiposProductos(id)
);

-- Tabla Productos
CREATE TABLE Productos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100),
    precio DECIMAL(10, 2),
    proveedor_id INT,
    tipo_id INT,
    FOREIGN KEY (proveedor_id) REFERENCES Proveedores(id) ON DELETE CASCADE,
    FOREIGN KEY (tipo_id) REFERENCES TiposProductos(id) ON DELETE CASCADE
);

-- Tabla Pedidos
CREATE TABLE Pedidos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    cliente_id INT,
    fecha DATE,
    total DECIMAL(10, 2) NOT NULL DEFAULT 0,
    FOREIGN KEY (cliente_id) REFERENCES Clientes(id) ON DELETE CASCADE
);

-- Tabla DetallesPedido (normalizada)
CREATE TABLE DetallesPedido (
    id INT PRIMARY KEY AUTO_INCREMENT,
    pedido_id INT,
    producto_id INT,
    cantidad INT,
    precio_unitario DECIMAL(10, 2),
    FOREIGN KEY (pedido_id) REFERENCES Pedidos(id) ON DELETE CASCADE,
    FOREIGN KEY (producto_id) REFERENCES Productos(id) ON DELETE CASCADE
);

-- Historial de Pedidos (cambios en pedidos)
CREATE TABLE HistorialPedidos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    pedido_id INT,
    cambio VARCHAR(255),
    fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (pedido_id) REFERENCES Pedidos(id) ON DELETE CASCADE
);

-- Relación de muchos a muchos entre Empleados y Proveedores
CREATE TABLE EmpleadosProveedores (
    id INT PRIMARY KEY AUTO_INCREMENT,
    empleado_id INT,
    proveedor_id INT,
    FOREIGN KEY (empleado_id) REFERENCES DatosEmpleados(id) ON DELETE CASCADE,
    FOREIGN KEY (proveedor_id) REFERENCES Proveedores(id) ON DELETE CASCADE
);


