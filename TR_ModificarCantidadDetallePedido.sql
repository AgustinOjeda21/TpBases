CREATE TRIGGER TR_ModificarCantidadDetallePedido ON DetallePedido
AFTER UPDATE
AS
BEGIN
BEGIN TRY 
BEGIN TRANSACTION
IF EXISTS(
    SELECT 1 FROM Producto AS p 
    INNER JOIN inserted AS i ON p.idProducto = i.Producto_idProducto 
    INNER JOIN deleted AS d ON p.idProducto = d.Producto_idProducto
    WHERE Stock + (d.Cantidad - i.Cantidad) < 0)
BEGIN  
THROW 50001, 'No hay suficiente stock',1
RETURN
END
UPDATE p SET P.Stock = P.Stock + (d.Cantidad - i.Cantidad)
FROM Producto AS p
INNER JOIN inserted AS i ON p.idProducto = i.Producto_idProducto
INNER JOIN deleted AS d ON p.idProducto = d.Producto_idProducto
UPDATE pe SET Total = Total + (d.Cantidad-i.Cantidad)*i.PrecioUnitario
FROM Pedido AS pe   
INNER JOIN deleted AS d ON pe.idPedido = d.Pedido_idPedido
INNER JOIN inserted AS i ON pe.idPedido = i.Pedido_idPedido
COMMIT TRANSACTION
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
THROW
END CATCH
END
