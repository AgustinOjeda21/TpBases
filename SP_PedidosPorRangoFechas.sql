CREATE PROCEDURE SP_PedidosPorRangoFechas(@FechaInicio DATETIME, @FechaFin DATETIME)
AS 
BEGIN
SELECT p.idPedido,me.Nombre AS "Metodo Envio",mp.Nombre  AS "Metodo Pago",e.Nombre  AS "Estado Pedido",p.Total,p.FechaPedido,c.idCliente,CONCAT(c.Nombre,' ',c.Apellido) AS "Nombre Cliente" FROM Pedido AS p
INNER JOIN Estado AS e ON p.Estado_idEstado = e.idEstadoPedido
INNER JOIN MetodoEnvio AS me ON p.MetodoEnvio_idFormaEntrega = me.idFormaEntrega
INNER JOIN MetodoPago AS mp ON p.MetodoPago_idFormaPago = mp.idFormaPago
INNER JOIN Cliente AS c ON p.Cliente_idCliente = c.idCliente
WHERE p.FechaPedido>=@FechaInicio AND p.FechaPedido<=@FechaFin
END
