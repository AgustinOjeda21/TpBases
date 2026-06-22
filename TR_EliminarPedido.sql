CREATE TRIGGER TR_EliminarPedido ON Pedido
INSTEAD OF DELETE
AS
BEGIN
BEGIN TRY 
BEGIN TRANSACTION
IF NOT EXISTS(SELECT 1 FROM Estado WHERE Nombre = 'Cancelado')
BEGIN   
RAISERROR('El pedido no se puede cancelar ya que no existe tal estado. Por favor crearlo', 16, 1)
END
DECLARE @Estado INT
DECLARE @Entregado INT
SELECT @Entregado = idEstadoPedido FROM Estado WHERE Nombre = 'Entregado'
SELECT @Estado = idEstadoPedido FROM Estado WHERE Nombre = 'Cancelado'
IF EXISTS(SELECT 1 FROM deleted WHERE Estado_idEstado = @Entregado)
BEGIN
RAISERROR('Uno o mas pedidos no se pueden cancelar por que los mismos ya fueron entregados', 16, 1)
END
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
DECLARE @Mensaje VARCHAR(500) = ERROR_MESSAGE()
DECLARE @Severidad INT = ERROR_SEVERITY()
DECLARE @EstadoError INT = ERROR_STATE()
RAISERROR(@Mensaje, @Severidad, @EstadoError)
END CATCH
END

