CREATE VIEW VW_PedidosCompletos AS
SELECT  c.idCliente, CONCAT(c.Nombre,' ',c.Apellido) AS "Nombre Cliente",us.CorreoElectronico, p.idPedido, p.FechaPedido AS "Fecha del Pedido", me.Nombre AS "Metodo de Envio", mp.Nombre AS "Metodo de Pago", e.Nombre AS "Estado del Pedido",p.Total AS "Subtotal sin envio", (p.Total+me.CostoEnvio) AS "Costo total con envio" FROM Cliente AS c
INNER JOIN Pedido AS p ON c.idCliente = p.Cliente_idCliente
INNER JOIN MetodoEnvio AS me ON p.MetodoEnvio_idFormaEntrega = me.idFormaEntrega
INNER JOIN MetodoPago AS mp ON p.MetodoPago_idFormaPago = mp.idFormaPago
INNER JOIN Estado AS e ON p.Estado_idEstado = e.idEstadoPedido
INNER JOIN UsuarioSistema AS us ON c.UsuarioSistema_idUsuarioSistema = us.idUsuario