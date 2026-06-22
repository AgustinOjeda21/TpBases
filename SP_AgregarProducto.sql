CREATE PROCEDURE SP_AgregarProducto(@Nombre VARCHAR(100),@Precio DECIMAL,@Stock INT,@Marca INT,@Categoria INT)
AS 
BEGIN
BEGIN TRY 
IF(@Stock<=0)
BEGIN
RAISERROR('El stock no puede ser menor o igual a 0', 16, 1)
RETURN
END
IF(@Precio<=0)
BEGIN
RAISERROR('El precio no puede ser menor o igual a 0', 16, 1)
RETURN
END
IF NOT EXISTS(SELECT 1 FROM Marca WHERE IdMarca = @Marca)
BEGIN
RAISERROR('La marca ingresada no existe', 16, 1)
RETURN
END
IF NOT EXISTS(SELECT 1 FROM Categoria WHERE idCategoria = @Categoria)
BEGIN
RAISERROR('La categoria ingresada no existe', 16, 1)
RETURN
END
INSERT INTO Producto (Nombre,Precio,Stock,Marca_idMarca,Categoria_idCategoria)
VALUES(@Nombre,@Precio,@Stock,@Marca,@Categoria)
END TRY
BEGIN CATCH
DECLARE @Mensaje VARCHAR(500) = ERROR_MESSAGE()
DECLARE @Severidad INT = ERROR_SEVERITY()
DECLARE @Estado INT = ERROR_STATE()
RAISERROR(@Mensaje, @Severidad, @Estado)
END CATCH
END
