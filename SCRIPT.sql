CREATE DATABASE CarniceriaBarbaro;
USE CarniceriaBarbaro;
CREATE TABLE Categoria (
    id_categoria INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL
);

CREATE TABLE Producto (
    id_producto INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    precio DECIMAL(10, 2) NOT NULL,
    stock INT DEFAULT 0,
    id_categoria INT,
    FOREIGN KEY (id_categoria) REFERENCES Categoria(id_categoria)
);

CREATE TABLE Proveedor (
    id_proveedor INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    telefono VARCHAR(15),
    direccion VARCHAR(100)
);

CREATE TABLE ProductoProveedor (
    id_producto INT,
    id_proveedor INT,
    PRIMARY KEY (id_producto, id_proveedor),
    FOREIGN KEY (id_producto) REFERENCES Producto(id_producto),
    FOREIGN KEY (id_proveedor) REFERENCES Proveedor(id_proveedor)
);

CREATE TABLE Cliente (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    telefono VARCHAR(15),
    direccion VARCHAR(100)
);

CREATE TABLE Venta (
    id_venta INT PRIMARY KEY AUTO_INCREMENT,
    id_cliente INT,
    fecha DATE NOT NULL,
    total DECIMAL(10, 2),
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente)
);

CREATE TABLE DetalleVenta (
    id_detalle INT PRIMARY KEY AUTO_INCREMENT,
    id_venta INT,
    id_producto INT,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (id_venta) REFERENCES Venta(id_venta),
    FOREIGN KEY (id_producto) REFERENCES Producto(id_producto)
);

CREATE TABLE Empleado (
    id_empleado INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    telefono VARCHAR(15),
    direccion VARCHAR(100),
    fecha_contratacion DATE NOT NULL
);

CREATE TABLE Rol (
    id_rol INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL
);

CREATE TABLE EmpleadoRol (
    id_empleado INT,
    id_rol INT,
    fecha_asignacion DATE NOT NULL,
    PRIMARY KEY (id_empleado, id_rol),
    FOREIGN KEY (id_empleado) REFERENCES Empleado(id_empleado),
    FOREIGN KEY (id_rol) REFERENCES Rol(id_rol)
);

CREATE TABLE Sueldo (
    id_sueldo INT PRIMARY KEY AUTO_INCREMENT,
    id_empleado INT,
    sueldo DECIMAL(10, 2) NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE,
    FOREIGN KEY (id_empleado) REFERENCES Empleado(id_empleado)
);

CREATE TABLE Inventario (
    id_inventario INT PRIMARY KEY AUTO_INCREMENT,
    id_producto INT,
    cantidad INT NOT NULL,
    fecha DATE NOT NULL,
    tipo_movimiento ENUM('entrada', 'salida') NOT NULL,
    FOREIGN KEY (id_producto) REFERENCES Producto(id_producto)
);

CREATE TABLE Compra (
    id_compra INT PRIMARY KEY AUTO_INCREMENT,
    id_proveedor INT,
    fecha DATE NOT NULL,
    total DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (id_proveedor) REFERENCES Proveedor(id_proveedor)
);

CREATE TABLE DetalleCompra (
    id_detalle_compra INT PRIMARY KEY AUTO_INCREMENT,
    id_compra INT,
    id_producto INT,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (id_compra) REFERENCES Compra(id_compra),
    FOREIGN KEY (id_producto) REFERENCES Producto(id_producto)
);

CREATE TABLE HistorialPrecioProducto (
    id_historial INT PRIMARY KEY AUTO_INCREMENT,
    id_producto INT,
    precio_anterior DECIMAL(10, 2),
    precio_nuevo DECIMAL(10, 2),
    fecha_cambio DATE NOT NULL,
    FOREIGN KEY (id_producto) REFERENCES Producto(id_producto)
);

CREATE TABLE Turno (
    id_turno INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    hora_inicio TIME NOT NULL,
    hora_fin TIME NOT NULL
);

CREATE TABLE Asistencia (
    id_asistencia INT PRIMARY KEY AUTO_INCREMENT,
    id_empleado INT,
    id_turno INT,
    fecha DATE NOT NULL,
    hora_entrada TIME,
    hora_salida TIME,
    FOREIGN KEY (id_empleado) REFERENCES Empleado(id_empleado),
    FOREIGN KEY (id_turno) REFERENCES Turno(id_turno)
);

CREATE TABLE Promocion (
    id_promocion INT PRIMARY KEY AUTO_INCREMENT,
    descripcion VARCHAR(100) NOT NULL,
    descuento DECIMAL(5, 2) NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL
);

CREATE TABLE ProductoPromocion (
    id_producto INT,
    id_promocion INT,
    PRIMARY KEY (id_producto, id_promocion),
    FOREIGN KEY (id_producto) REFERENCES Producto(id_producto),
    FOREIGN KEY (id_promocion) REFERENCES Promocion(id_promocion)
);

