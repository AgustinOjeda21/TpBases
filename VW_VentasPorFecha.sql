CREATE VIEW VW_VentasPorFecha AS
SELECT YEAR(p.FechaPedido) AS AÑO,DATENAME(MONTH,p.FechaPedido) AS Mes ,COUNT(*) AS "Cantidad de ventas", SUM(p.Total) AS "Total ingresos por ventas" FROM Pedido AS p
GROUP BY YEAR(p.FechaPedido), MONTH(p.FechaPedido), DATENAME(MONTH,p.FechaPedido)