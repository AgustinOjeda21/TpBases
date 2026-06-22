CREATE TRIGGER TR_EliminarDetallePedido ON DetallePedido
AFTER DELETE
AS
BEGIN
BEGIN TRY 
BEGIN TRANSACTION
UPDATE p SET Stock = Stock + d.Cantidad
FROM Producto AS p
INNER JOIN deleted AS d ON p.idProducto = d.Producto_idProducto
UPDATE pe SET Total = Total - d.Cantidad*d.PrecioUnitario
FROM Pedido AS pe   
INNER JOIN deleted AS d ON pe.idPedido = d.Pedido_idPedido
COMMIT TRANSACTION
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
RAISERROR('La operacion fallo', 16, 1)
END CATCH
END
