CREATE VIEW VW_DetallePedidosConProductos AS
SELECT pe.idPedido AS "ID Pedido", pe.FechaPedido AS "Fecha del pedido", p.Nombre AS "Nombre Producto", dp.Cantidad, dp.PrecioUnitario, (p.Precio*dp.Cantidad) AS "Subtotal" FROM DetallePedido AS dp
INNER JOIN Producto AS p ON dp.Producto_idProducto = p.idProducto
INNER JOIN Pedido pe ON pe.idPedido = dp.Pedido_idPedido