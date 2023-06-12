CREATE DATABASE DBTIENDA
GO

USE DBTIENDA
GO

CREATE TABLE CATEGORIA(
IdCategoria int primary key identity,
Descripcion varchar(100),
Activo bit default 1,
FechaRegistro datetime default getdate()

)

go

CREATE TABLE MARCA(
IdMarca int primary key identity,
Descripcion varchar(100),
Activo bit default 1,
FechaRegistro datetime default getdate()
)
go

CREATE TABLE PRODUCTO(
IdProducto int primary key identity,
Nombre varchar(500),
Descripcion varchar(500),
IdMarca int references Marca(IdMarca),
IdCategoria int references Categoria(IdCategoria),
Precio decimal(10,2) default 0,
Stock int,
RutaImagen varchar(100),
NombreImagen varchar(100),
Activo bit default 1,
FechaRegistro datetime default getdate()

)
GO

CREATE TABLE CLIENTE(
IdCliente int primary key identity,
Nombre varchar(100),
Apellidos varchar(100),
Correo varchar(100),
Clave varchar(150),
Restablecer bit default 0,
FechaRegistro datetime default getdate()
)
GO


CREATE TABLE CARRITO(
IdCarrito int primary key identity,
IdCliente int references Cliente(IdCliente),
IdProducto int references Producto(IdProducto),
Cantidad int
)
GO

CREATE TABLE VENTA(
IdVenta int primary key identity,
IdCliente int references Cliente(idCliente),
TotalProducto int,
MontoTotal decimal(10,2),
Contacto varchar(50),
IdDistrito varchar(10),
Telefono varchar(50),
Direccion varchar(500),
IdTransaccion varchar(50),
FechaVenta datetime default getdate()

)
GO

CREATE TABLE DETALLE_VENTA(
IdDetalleVenta int primary key identity,
IdVenta int references Venta(IdVenta),
IdProducto int references Producto(IdProducto),
Cantidad int,
Total decimal(10,2)
)

GO

CREATE TABLE USUARIO(
IdUsuario int primary key identity,
Nombre varchar(100),
Apellidos Varchar(100),
Correo varchar(100),
Clave varchar(150),
Restablecer bit default 1,
Activo bit default 1,
FechaRegistro datetime default getdate()

)
GO

CREATE TABLE CANTON(
IdCanton varchar(2) NOT NULL,
Descripcion varchar(50) NOT NULL,
IdProvincia varchar(4) NOT NULL,
)
GO

CREATE TABLE PROVINCIA(
IdProvincia varchar(4) NOT NULL,
Descripcion varchar(50) NOT NULL,
)
GO

CREATE TABLE DISTRITO(
IdDistrito varchar(6) NOT NULL,
Descripcion varchar(50) NOT NULL,
IdProvincia varchar(4) NOT NULL,
IdCanton varchar(2) NOT NULL
)
GO



INSERT INTO USUARIO(Nombre,Apellidos,Correo,Clave) VALUES ('Geiner','Sanchez','rastigelte@vusra.com','ecd71870d1963316a97e3ac3408c9835ad8cf0f3c1bc703527c30265534f75ae')

GO

INSERT INTO CATEGORIA(Descripcion) VALUES
('Tecnologia'),
('Dormitorio'),
('Muebles'),
('Deportes')

GO

INSERT INTO MARCA(Descripcion) VALUES
('Sony'),
('Mabe'),
('LG'),
('HP'),
('Dell'),
('Samsung'),
('Nike'),
('Adidas')
GO

INSERT INTO PROVINCIA(IdProvincia,Descripcion) VALUES
('01','San Jose'),
('02','Alajuela'),
('03', 'Heredia'),
('04','Cartago'),
('05','Puntarenas'),
('06','Guanacaste'),
('07','Limon')

GO

INSERT INTO CANTON(IdCanton,Descripcion,IdProvincia) VALUES
('01','Goicoechea','01'),
('02','San Carlos','02'),
('03','Belen','03'),
('04','La Union','04'),
('05','Garabito','05'),
('06','Liberia','06'),
('07','Guacimo','07')

GO

INSERT INTO DISTRITO(IdDistrito,Descripcion,IdProvincia,IdCanton) VALUES
('01','Rancho Redondo','01','01'),
('02','Aguas Zarcarcas','02','02'),
('03','San Antonio','03','03')