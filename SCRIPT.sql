
-- Creación de la base de datos
CREATE DATABASE IF NOT EXISTS CarniceriaBarbaro;
USE CarniceriaBarbaro;


-- TABLAS


-- Tabla: Categoria
CREATE TABLE IF NOT EXISTS Categoria (
    id_categoria INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL UNIQUE,
    descripcion TEXT DEFAULT NULL
);

-- Tabla: Producto
CREATE TABLE IF NOT EXISTS Producto (
    id_producto INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL UNIQUE,
    precio DECIMAL(10, 2) NOT NULL CHECK (precio > 0),
    stock INT DEFAULT 0 CHECK (stock >= 0),
    id_categoria INT NOT NULL,
    FOREIGN KEY (id_categoria) REFERENCES Categoria(id_categoria) ON DELETE CASCADE
);

-- Tabla: Proveedor
CREATE TABLE IF NOT EXISTS Proveedor (
    id_proveedor INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL UNIQUE,
    telefono VARCHAR(15) NOT NULL,
    direccion VARCHAR(100) DEFAULT NULL
);

-- Tabla: ProductoProveedor
CREATE TABLE IF NOT EXISTS ProductoProveedor (
    id_producto INT NOT NULL,
    id_proveedor INT NOT NULL,
    PRIMARY KEY (id_producto, id_proveedor),
    FOREIGN KEY (id_producto) REFERENCES Producto(id_producto) ON DELETE CASCADE,
    FOREIGN KEY (id_proveedor) REFERENCES Proveedor(id_proveedor) ON DELETE CASCADE
);

-- Tabla: Cliente
CREATE TABLE IF NOT EXISTS Cliente (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    telefono VARCHAR(15) DEFAULT NULL,
    direccion VARCHAR(100) DEFAULT NULL
);


-- VISTAS


-- Vista: Productos disponibles por categoría
CREATE OR REPLACE VIEW ProductosPorCategoria AS
SELECT 
    c.nombre AS categoria,
    p.nombre AS producto,
    p.precio,
    p.stock
FROM Producto p
JOIN Categoria c ON p.id_categoria = c.id_categoria;

-- Vista: Relación de productos con proveedores
CREATE OR REPLACE VIEW ProductosConProveedores AS
SELECT 
    p.nombre AS producto,
    prov.nombre AS proveedor,
    prov.telefono
FROM Producto p
JOIN ProductoProveedor pp ON p.id_producto = pp.id_producto
JOIN Proveedor prov ON pp.id_proveedor = prov.id_proveedor;


-- FUNCIONES


-- Función: Calcular descuento
DELIMITER $$
CREATE FUNCTION CalcularDescuento(precio DECIMAL(10, 2), porcentaje DECIMAL(5, 2))
RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    RETURN precio - (precio * porcentaje / 100);
END $$
DELIMITER ;



-- PROCEDIMIENTOS


-- Procedimiento: Insertar un nuevo cliente
DELIMITER $$
CREATE PROCEDURE InsertarCliente(
    IN nombre_cliente VARCHAR(50),
    IN telefono_cliente VARCHAR(15),
    IN direccion_cliente VARCHAR(100)
)
BEGIN
    INSERT INTO Cliente (nombre, telefono, direccion)
    VALUES (nombre_cliente, telefono_cliente, direccion_cliente);
END $$
DELIMITER ;

-- Procedimiento: Registrar una venta (básico)
DELIMITER $$
CREATE PROCEDURE RegistrarVenta(
    IN id_producto INT,
    IN cantidad INT
)
BEGIN
    DECLARE stock_actual INT;
    
    -- Obtener el stock actual del producto
    SELECT stock INTO stock_actual FROM Producto WHERE id_producto = id_producto;

    -- Verificar si hay suficiente stock
    IF stock_actual >= cantidad THEN
        -- Actualizar el stock
        UPDATE Producto SET stock = stock - cantidad WHERE id_producto = id_producto;
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Stock insuficiente para realizar la venta.';
    END IF;
END $$
DELIMITER ;


-- DATOS DE INSERCIÓN


-- Insertar categorías
INSERT INTO Categoria (nombre, descripcion) VALUES 
('Carnes Rojas', 'Cortes de carne vacuna y de cerdo'),
('Carnes Blancas', 'Carne de pollo, pescado y similares'),
('Embutidos', 'Productos como salchichas, chorizos, etc.');

-- Insertar productos
INSERT INTO Producto (nombre, precio, stock, id_categoria) VALUES
('Bife de Chorizo', 1500.00, 20, 1),
('Pollo Entero', 800.00, 15, 2),
('Salchicha Viena', 500.00, 30, 3);

-- Insertar proveedores
INSERT INTO Proveedor (nombre, telefono, direccion) VALUES
('Proveedor A', '123456789', 'Calle sarratea 123'),
('Proveedor B', '987654321', 'Avenida santa maria 742');

-- Relacionar productos con proveedores
INSERT INTO ProductoProveedor (id_producto, id_proveedor) VALUES
(1, 1),
(2, 2),
(3, 1),
(3, 2);

-- Insertar clientes
INSERT INTO Cliente (nombre, telefono, direccion) VALUES
('Cliente 1', '111222333', 'Dirección 1'),
('Cliente 2', '444555666', 'Dirección 2');




