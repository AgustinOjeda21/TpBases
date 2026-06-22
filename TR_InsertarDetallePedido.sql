CREATE TRIGGER TR_InsertarDetallePedido ON DetallePedido
AFTER INSERT
AS
BEGIN
BEGIN TRANSACTION
BEGIN TRY 
IF EXISTS(SELECT 1 FROM Producto AS p INNER JOIN inserted AS i ON p.idProducto = i.Producto_idProducto WHERE Stock - Cantidad < 0)
BEGIN  
RAISERROR('No hay suficiente stock', 16, 1)
END
UPDATE p SET Stock = Stock - i.Cantidad
FROM Producto AS p
INNER JOIN inserted AS i ON p.idProducto = i.Producto_idProducto
UPDATE pe SET Total = Total + i.Cantidad*i.PrecioUnitario
FROM Pedido AS pe   
INNER JOIN inserted AS i ON pe.idPedido = i.Pedido_idPedido
COMMIT TRANSACTION
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
DECLARE @Mensaje VARCHAR(500) = ERROR_MESSAGE()
DECLARE @Severidad INT = ERROR_SEVERITY()
DECLARE @Estado INT = ERROR_STATE()
RAISERROR(@Mensaje, @Severidad, @Estado)
END CATCH
END
