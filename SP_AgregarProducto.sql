CREATE PROCEDURE SP_AgregarProducto(@Nombre VARCHAR(100),@Precio DECIMAL,@Stock INT,@Marca INT,@Categoria INT)
AS 
BEGIN
BEGIN TRY 
IF(@Stock<=0)
BEGIN
THROW 50001, 'El stock no puede ser menor o igual a 0', 1
RETURN
END
IF(@Precio<=0)
BEGIN
THROW 50001, 'El precio no puede ser menor o igual a 0', 1
RETURN
END
IF NOT EXISTS(SELECT 1 FROM Marca WHERE IdMarca = @Marca)
BEGIN
THROW 50002, 'La Marca ingresada no existe', 1;
RETURN
END
IF NOT EXISTS(SELECT 1 FROM Categoria WHERE idCategoria = @Categoria)
BEGIN
THROW 50003, 'La Categoria ingresada no existe', 1;
RETURN
END
INSERT INTO Producto (Nombre,Precio,Stock,Marca_idMarca,Categoria_idCategoria)
VALUES(@Nombre,@Precio,@Stock,@Marca,@Categoria)
END TRY
BEGIN CATCH
THROW
END CATCH
END