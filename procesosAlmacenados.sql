USE DBTIENDAWEB
GO



CREATE PROCEDURE SP_RegistrarUsuario
(
@Nombre varchar(100),
@Apellidos varchar(100),
@Correo varchar(100),
@Clave varchar(150),
@Activo bit,
@Mensaje varchar(500) output,
@Resultado int output

)
AS
BEGIN
SET @Resultado = 0
IF NOT EXISTS (SELECT * FROM USUARIO WHERE Correo = @Correo )
BEGIN 
INSERT INTO [dbo].[USUARIO]
           ([Nombre]
           ,[Apellidos]
           ,[Correo]
           ,[Clave]           
           ,[Activo] )         
     VALUES
           (@Nombre,
           @Apellidos,
           @Correo,
           @Clave,
           @Activo)

		   SET @Resultado = SCOPE_IDENTITY()
		   END 
		   ELSE
		   SET @Mensaje = 'El correo del usuario ya existe'
		   end

GO

CREATE PROCEDURE SP_EditarUsuario(
@IdUsuario int,
@Nombre varchar(100),
@Apellidos varchar(100),
@Correo varchar(100),
@Activo bit,
@Mensaje varchar(500) output,
@Resultado int output
)
as 
BEGIN 
SET @Resultado = 0
IF NOT EXISTS (SELECT * FROM USUARIO WHERE Correo = @Correo AND IdUsuario != @IdUsuario )
BEGIN
UPDATE TOP(1 )[dbo].[USUARIO] 
   SET [Nombre] = @Nombre,
      [Apellidos] = @Apellidos,
      [Correo] = @Correo,          
      [Activo] = @Activo
      
 WHERE IdUsuario = @IdUsuario

 SET @Resultado = 1

 END 
 ELSE
 SET @Mensaje = 'El correo del usaurio ya existe'
 END 
GO


CREATE PROCEDURE SP_RegistrarCategoria(
@Descripcion varchar(100),
@Activo bit,
@Mensaje varchar(500) output,
@Resultado int output

)
as 
begin
SET @Resultado =0
IF NOT EXISTS (SELECT * FROM CATEGORIA WHERE Descripcion = @Descripcion)
BEGIN 
INSERT INTO [dbo].[CATEGORIA]
           ([Descripcion]
           ,[Activo]
           )
     VALUES
           (@Descripcion
           ,@Activo  )

		   SET @Resultado = SCOPE_IDENTITY()
		   END
		ELSE
	 SET @Mensaje = 'La Categoria ya existe'
		END
GO

CREATE PROCEDURE SP_EditarCategoria
(
@IdCategoria int,
@Descripcion varchar(100),
@Activo bit,
@Mensaje varchar(500) output,
@Resultado bit output

)
as
begin
SET @Resultado =0
IF NOT EXISTS (SELECT * FROM CATEGORIA WHERE Descripcion = @Descripcion and IdCategoria !=@IdCategoria )
BEGIN 
UPDATE top (1) [dbo].[CATEGORIA] 
   SET [Descripcion] = @Descripcion
      ,[Activo] = @Activo
      
 WHERE IdCategoria = @IdCategoria
 set @Resultado = 1
 end
 else
 set @Mensaje = 'La categoria ya existe'
 END
GO


CREATE PROCEDURE SP_EliminarCategoria(
@IdCategoria int,
@Mensaje varchar(500) output,
@Resultado bit output

)
as
BEGIN
SET @Resultado =0
IF NOT EXISTS (SELECT * FROM PRODUCTO P
INNER JOIN CATEGORIA C ON C.IdCategoria = P.IdCategoria
WHERE P.IdCategoria = @IdCategoria

)
begin 
DELETE top (1) FROM [dbo].[CATEGORIA]
      WHERE IdCategoria = @IdCategoria
	  set @Resultado = 1
	  end
	  else
	  set @Mensaje = 'La categoria se encuentra relacionada a un producto '
	  END 
GO

CREATE PROCEDURE SP_RegistrarMarca(
@Descripcion varchar(100),
@Activo bit,
@Mensaje varchar(500) output,
@Resultado int output

)
as 
begin
SET @Resultado =0
IF NOT EXISTS (SELECT * FROM MARCA WHERE Descripcion = @Descripcion)
BEGIN 
INSERT INTO [dbo].MARCA
           ([Descripcion]
           ,[Activo]
           )
     VALUES
           (@Descripcion
           ,@Activo  )

		   SET @Resultado = SCOPE_IDENTITY()
		   END
		ELSE
	 SET @Mensaje = 'La Marca ya existe'
		END
GO


CREATE PROCEDURE SP_EditarMarca
(
@IdMarca int,
@Descripcion varchar(100),
@Activo bit,
@Mensaje varchar(500) output,
@Resultado bit output

)
as
begin
SET @Resultado =0
IF NOT EXISTS (SELECT * FROM MARCA WHERE Descripcion = @Descripcion and IdMarca !=@IdMarca )
BEGIN 
UPDATE top (1) [dbo].MARCA 
   SET [Descripcion] = @Descripcion
      ,[Activo] = @Activo
      
 WHERE IdMarca = @IdMarca
 set @Resultado = 1
 end
 else
 set @Mensaje = 'La Marca ya existe'
 END
GO


CREATE PROCEDURE SP_EliminarMarca(
@IdMarca int,
@Mensaje varchar(500) output,
@Resultado bit output

)
as
BEGIN
SET @Resultado =0
IF NOT EXISTS (SELECT * FROM PRODUCTO P
INNER JOIN MARCA C ON C.IdMarca = P.IdCategoria
WHERE P.IdCategoria = @IdMarca

)
begin 
DELETE top (1) FROM [dbo].MARCA
      WHERE IdMarca = @IdMarca
	  set @Resultado = 1
	  end
	  else
	  set @Mensaje = 'La Marca se encuentra relacionada a un producto '
	  END 
GO

CREATE PROCEDURE SP_RegistrarProducto(
@Nombre varchar(500),
@Descripcion varchar(500),
@IdMarca int,
@IdCategoria int,
@Precio decimal(10,2),
@Stock int,
@Activo bit,
@Mensaje varchar(500) output,
@Resultado int output

)
as 
begin
SET @Resultado =0
IF NOT EXISTS (SELECT * FROM PRODUCTO WHERE Nombre = @Nombre)
BEGIN 
INSERT INTO [dbo].PRODUCTO
           (Nombre,
		   [Descripcion], IdMarca,IdCategoria,Precio,Stock,
           [Activo]
           )
     VALUES
           (@Nombre,
		   @Descripcion,@IdMarca,@IdCategoria,@Precio,@Stock
           ,@Activo  )

		   SET @Resultado = SCOPE_IDENTITY()
		   END
		ELSE
	 SET @Mensaje = 'El Producto ya existe'
		END
GO


CREATE PROCEDURE SP_EditarProducto
(
@IdProducto int,
@Nombre varchar(500),
@Descripcion varchar(500),
@IdMarca int,
@IdCategoria int,
@Precio decimal(10,2),
@Stock int,
@Activo bit,
@Mensaje varchar(500) output,
@Resultado int output

)
as
begin
SET @Resultado =0
IF NOT EXISTS (SELECT * FROM PRODUCTO WHERE Nombre = @Nombre and IdProducto !=@IdProducto )
BEGIN 
UPDATE top (1) [dbo].PRODUCTO 
   SET Nombre =@Nombre,
		   [Descripcion] =@Descripcion, IdMarca=@IdMarca,IdCategoria=@IdCategoria,Precio=@Precio,Stock=@Stock,
           [Activo]=@Activo
      
 WHERE IdProducto = @IdProducto
 set @Resultado = 1
 end
 else
 set @Mensaje = 'El Producto ya existe'
 END
GO


CREATE PROCEDURE SP_EliminarProducto(
@IdProducto int,
@Mensaje varchar(500) output,
@Resultado bit output

)
as
BEGIN
SET @Resultado =0
IF NOT EXISTS (SELECT * FROM DETALLE_VENTA DV
INNER JOIN PRODUCTO P ON P.IdProducto = DV.IdProducto
WHERE P.IdProducto = @IdProducto

)
begin 
DELETE top (1) FROM [dbo].PRODUCTO
      WHERE IdProducto = @IdProducto
	  set @Resultado = 1
	  end
	  else
	  set @Mensaje = 'El Producto se encuentra relacionada a una venta '
	  END 
GO

SELECT  P.IdProducto,P.Nombre,P.Descripcion,
M.IdMarca,M.Descripcion AS DesMarca, 
C.IdCategoria,C.Descripcion AS DesCategoria,
P.Precio,P.Stock,P.RutaImagen,P.NombreImagen,P.Activo
FROM PRODUCTO P
INNER JOIN MARCA M  ON M.IdMarca = P.IdMarca
INNER JOIN CATEGORIA C ON C.IdCategoria = P.IdCategoria

GO
CREATE PROCEDURE SP_ReporteDashboard
as
begin
SELECT 

(SELECT  COUNT (*) FROM CLIENTE) [TotalCliente],

(SELECT ISNULL (SUM(cantidad),0) from DETALLE_VENTA) [TotalVenta],
 

(SELECT COUNT(*) FROM PRODUCTO) [TotalProducto]

end
GO


CREATE PROCEDURE SP_ReporteVentas
(
@FechaInicio VARCHAR(10),
@FechaFin VARCHAR(10),
@IdTransaccion VARCHAR(50)
)
AS
BEGIN

SET DATEFORMAT dmy;

SELECT CONVERT(CHAR(10), V.FechaVenta,103)[FechaVenta], CONCAT( C.Nombre,' ', C.Apellidos)[Cliente],
P.Nombre[Producto],P.Precio,DV.Cantidad,DV.Total,V.IdTransaccion

FROM DETALLE_VENTA DV
INNER JOIN PRODUCTO P ON P.IdProducto = DV.IdProducto
INNER JOIN VENTA V ON V.IdVenta = DV.IdVenta
INNER JOIN CLIENTE C ON C.IdCliente = V.IdCliente

WHERE CONVERT(DATE, V.FechaVenta) BETWEEN @FechaInicio AND @FechaFin

AND V.IdTransaccion = IIF(@IdTransaccion = '',V.IdTransaccion,@IdTransaccion)
END
GO


CREATE PROCEDURE SP_RegistrarCliente(
@Nombre varchar(100),
@Apellidos varchar(100),
@Correo varchar(100),
@Clave varchar(100),
@Mensaje varchar(500) output,
@Resultado int output
)
AS 
BEGIN
SET @RESULTADO = 0
IF NOT EXISTS (SELECT * FROM CLIENTE WHERE Correo = @Correo)
BEGIN
INSERT INTO CLIENTE(Nombre,Apellidos,Correo,Clave,Restablecer) VALUES
(@Nombre,@Apellidos,@Correo,@Clave,0)

SET @Resultado = SCOPE_IDENTITY()
END
ELSE
SET @Mensaje = 'El correo del usuario ya existe'
END
GO

DECLARE @idCategoria int = 0

SELECT distinct m.IdMarca, m.Descripcion FROM PRODUCTO P
INNER JOIN CATEGORIA c ON c.IdCategoria = p.IdCategoria
INNER JOIN MARCA m ON m.IdMarca = p.IdMarca AND m.Activo =1
WHERE c.IdCategoria = IIF(@idCategoria = 0,c.IdCategoria, @idCategoria)

GO



CREATE PROCEDURE SP_ExisteCarrito(
@IdCliente int,
@IdProducto int,
@Resultado bit output
)
AS
BEGIN
IF EXISTS (SELECT * FROM CARRITO WHERE IdCliente = @IdCliente AND IdProducto = @IdProducto)
SET @Resultado = 1
ELSE 
SET @Resultado = 0
END
GO


CREATE PROCEDURE SP_OperacionCarrito(
@IdCliente int,
@Idproducto int,
@Sumar bit,
@Mensaje varchar(500) output,
@Resultado bit output 
)
AS
BEGIN

SET @Resultado = 1
SET @Mensaje = ''

DECLARE @existecarrito bit = iIf(exists (SELECT * FROM CARRITO WHERE idcliente = @IdCliente AND idproducto = @IdProducto),1,0)
DECLARE @stockproducto int = (SELECT stock FROM PRODUCTO where IdProducto = @Idproducto)

BEGIN TRY
BEGIN TRANSACTION OPERACION 

IF(@Sumar = 1)
BEGIN 

IF(@stockproducto > 0)
BEGIN
IF(@existecarrito = 1)
UPDATE CARRITO SET Cantidad = Cantidad + 1 WHERE IdCliente = @IdCliente AND IdProducto = @Idproducto
ELSE 
INSERT INTO CARRITO (IdCliente, IdProducto,Cantidad) values (@IdCliente, @Idproducto, 1)
UPDATE PRODUCTO SET Stock = Stock - 1 WHERE IdProducto = @Idproducto
END 
ELSE
BEGIN 
 SET @Resultado = 0
 SET @Mensaje = 'El producto no cuenta con stock disponible'
 END
 END
 ELSE
 BEGIN
 UPDATE CARRITO SET Cantidad = Cantidad - 1 WHERE IdCliente = @IdCliente AND IdProducto = @Idproducto
 UPDATE PRODUCTO SET Stock = Stock + 1 WHERE IdProducto = @Idproducto
  END
 COMMIT TRANSACTION OPERACION
  END TRY 
 BEGIN CATCH 
  SET @Resultado = 0
  SET @Mensaje = ERROR_MESSAGE()
  ROLLBACK TRANSACTION OPERACION
 END CATCH
END
GO


CREATE FUNCTION FN_ObtenerCarritoCliente(
@idcliente int )
RETURNS TABLE 
AS 
RETURN (
SELECT P.IdProducto, M.Descripcion[DesMarca], P.Nombre,P.Precio,C.Cantidad,P.RutaImagen,P.NombreImagen

FROM CARRITO C
INNER JOIN PRODUCTO P ON P.IdProducto = C.IdProducto
INNER JOIN MARCA M  ON M.IdMarca = P.IdMarca
WHERE C.IdCliente = @idcliente
)
GO


CREATE PROCEDURE SP_EliminarCarrito(
@IdCliente int,
@IdProducto int,
@Resultado bit output
)
AS
BEGIN 

SET @Resultado = 1
DECLARE @cantidadproducto int = (select Cantidad FROM CARRITO WHERE IdCliente = @IdCliente AND IdProducto= @IdProducto)
BEGIN TRY

BEGIN TRANSACTION OPERACION

UPDATE PRODUCTO SET Stock = Stock + @cantidadproducto WHERE IdProducto = @IdProducto
DELETE TOP (1) FROM CARRITO WHERE IdCliente = @IdCliente AND IdProducto = @IdProducto

COMMIT TRANSACTION OPERACION

END TRY 
BEGIN CATCH 
SET @Resultado = 0
ROLLBACK TRANSACTION OPERACION
END CATCH 
END
GO


CREATE TYPE [dbo].[EDetalle_Venta] AS TABLE
(
IdProducto int NULL,
Cantidad int Null,
Total decimal(18,2) NULL
)
GO


CREATE PROCEDURE SP_RegistrarVenta(
@IdCliente int,
@TotalProducto int,
@MontoTotal decimal(18,2),
@Contacto varchar(100),
@IdDistrito varchar(6),
@Telefono varchar(10),
@Direccion varchar(100),
@IdTransaccion varchar(50),
@DetalleVenta [EDetalle_Venta] READONLY,
@Resultado bit output,
@Mensaje varchar(500) output
)

AS
BEGIN 

BEGIN TRY 
DECLARE @IdVenta int = 0
SET @Resultado = 1
SET @Mensaje = ''

BEGIN TRANSACTION Registro

INSERT INTO VENTA(IdCliente, TotalProducto,MontoTotal,Contacto,IdDistrito,Telefono,Direccion,IdTransaccion)
VALUES (@IdCliente,@TotalProduto,@MontoTotal,@Contacto,@IdDistrito,@Telefono,@Direccion,@IdTransaccion )

set @IdVenta = SCOPE_IDENTITY()

INSERT INTO DETALLE_VENTA(IdVenta,IdProducto,Cantidad,Total)
SELECT @IdVenta,IdProducto,Cantidad,Total FROM @DetalleVenta 

DELETE FROM CARRITO WHERE IdCliente = @IdCliente

COMMIT TRANSACTION Registro

END TRY

BEGIN CATCH 
SET @Resultado = 0
SET @Mensaje = ERROR_MESSAGE()
ROLLBACK TRANSACTION Registro

END CATCH 
END
GO

CREATE FUNCTION FN_ListarCompra(
@idcliente int
)
RETURNS TABLE
AS
RETURN
(
SELECT P.RutaImagen,P.NombreImagen,P.Nombre,P.Precio,DV.Cantidad,DV.Total,V.IdTransaccion FROM DETALLE_VENTA DV
INNER JOIN PRODUCTO P ON P.IDPRODUCTO = DV.IDPRODUCTO
INNER JOIN VENTA V ON V.IdVenta = DV.IdVenta
WHERE V.IdCliente = @idcliente
)
go