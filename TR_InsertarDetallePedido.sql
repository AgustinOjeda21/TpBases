CREATE TRIGGER TR_InsertarDetallePedido ON DetallePedido
AFTER INSERT
AS
BEGIN
BEGIN TRY 
BEGIN TRANSACTION
IF EXISTS(SELECT 1 FROM Producto AS p INNER JOIN inserted AS i ON p.idProducto = i.Producto_idProducto WHERE Stock - Cantidad < 0)
BEGIN  
THROW 50001, 'No hay suficiente stock',1
RETURN
END
UPDATE p SET Stock = Stock - i.Cantidad
FROM Producto AS p
INNER JOIN inserted AS i ON p.idProducto = i.Producto_idProducto
COMMIT TRANSACTION
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
THROW
END CATCH
END
