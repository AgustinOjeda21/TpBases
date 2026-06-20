CREATE VIEW VW_PedidosPorEstado AS
SELECT e.Nombre,COUNT(p.Estado_idEstado) AS "Cantidad de pedidos" FROM Estado AS e
LEFT JOIN Pedido p ON e.idEstadoPedido = p.Estado_idEstado
GROUP BY e.Nombre
