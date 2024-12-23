-- Insertar Categorías
INSERT INTO Categoria (nombre, descripcion) VALUES
('Carne de Res', 'Todo tipo de carne de res, cortes premium'),
('Carne de Cerdo', 'Carne de cerdo fresca y de calidad'),
('Pollo', 'Pollo fresco de granja');

-- Insertar Productos
INSERT INTO Producto (nombre, precio, stock, id_categoria) VALUES
('Bife de Chorizo', 150.00, 50, 1),
('Costillas de Cerdo', 120.00, 30, 2),
('Pechuga de Pollo', 100.00, 100, 3);

-- Insertar Clientes
INSERT INTO Cliente (nombre, telefono, email, direccion) VALUES
('Juan Pérez', '123456789', 'juan@example.com', 'Calle Falsa 123'),
('Ana Gómez', '987654321', 'ana@example.com', 'Av. Libertador 456');

-- Insertar Empleados
INSERT INTO Empleado (nombre, telefono, email, direccion, puesto, salario) VALUES
('Carlos Rodríguez', '555555555', 'carlos@empresa.com', 'Calle 1', 'Carnicero', 45000),
('Laura Martínez', '444444444', 'laura@empresa.com', 'Calle 2', 'Vendedora', 35000);

-- Insertar Proveedores
INSERT INTO Proveedor (nombre, telefono, email, direccion) VALUES
('Carnes La Pampa', '222222222', 'proveedor@carneslapampa.com', 'Ruta 5, Km 50'),
('Pollo San Pedro', '333333333', 'proveedor@pollosanpedro.com', 'Ruta 6, Km 20');
