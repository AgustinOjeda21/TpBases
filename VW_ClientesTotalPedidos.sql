CREATE VIEW VW_ClientesTotalPedidos AS
SELECT c.idCliente,CONCAT(c.Nombre,' ',c.Apellido) AS "Nombre del cliente",SUM(dp.Cantidad*dp.PrecioUnitario) AS "Total gastado" FROM Cliente AS c
INNER JOIN Pedido AS p ON p.Cliente_idCliente = c.idCliente
INNER JOIN DetallePedido dp ON dp.Pedido_idPedido = p.idPedido
GROUP BY c.idCliente, c.Nombre, c.Apellido