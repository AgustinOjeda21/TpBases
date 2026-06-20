CREATE VIEW VW_ClienteCategoria AS 
SELECT c.idCliente,CONCAT(c.Nombre,' ',c.Apellido) AS "Nombre Cliente",SUM(p.Total) AS "Total Gastado",dbo.CalcularCategoria(SUM(p.Total),Prom.Promedio) AS "Categoria Cliente" FROM Cliente AS c
INNER JOIN Pedido AS p ON c.idCliente = p.Cliente_idCliente 
CROSS JOIN (SELECT AVG(TOTAL) AS Promedio FROM Pedido) AS Prom
GROUP BY c.idCliente,c.Nombre,c.Apellido,Prom.Promedio