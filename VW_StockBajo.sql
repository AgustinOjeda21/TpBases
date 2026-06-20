CREATE VIEW VW_StockBajo AS
SELECT p.idProducto,p.Nombre,p.Stock, ISNULL(avg.Promedio,0) AS "Promedio de ventas", dbo.CalcularNivelStock(ISNULL(avg.Promedio,0),p.Stock) AS "Nivel Stock"
FROM Producto AS p
LEFT JOIN (SELECT dp.Producto_idProducto, AVG(dp.Cantidad) AS Promedio FROM DetallePedido AS dp GROUP BY dp.Producto_idProducto) AS avg
ON p.idProducto = avg.Producto_idProducto