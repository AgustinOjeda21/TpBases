CREATE TRIGGER TR_EliminarPedido ON Pedido
INSTEAD OF DELETE
AS
BEGIN
BEGIN TRY 
BEGIN TRANSACTION
IF NOT EXISTS(SELECT 1 FROM Estado WHERE Nombre = 'Cancelado')
BEGIN   
THROW 50001, 'El pedido no se puede cancelar ya que no existe tal estado. Por favor crearlo',1
END
DECLARE @Estado INT
SELECT @Estado = idEstadoPedido FROM Estado WHERE Nombre = 'Cancelado'
UPDATE p SET p.Estado_idEstado = @Estado
FROM Pedido AS p 
INNER JOIN deleted AS d ON p.idPedido = d.idPedido
UPDATE p SET p.Stock = p.Stock + dp.Cantidad
FROM Producto AS p
INNER JOIN DetallePedido AS dp ON p.idProducto = dp.Producto_idProducto
INNER JOIN deleted AS d ON dp.Pedido_idPedido = d.idPedido
COMMIT TRANSACTION
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
THROW
END CATCH
END
