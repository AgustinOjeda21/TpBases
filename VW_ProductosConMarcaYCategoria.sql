CREATE VIEW VW_ProductosConMarcaYCategoria AS
SELECT p.idProducto,p.Nombre,p.Precio,p.Stock,m.Nombre AS Marca, c.Nombre AS Categoria FROM Producto AS p
INNER JOIN Marca AS m ON p.Marca_idMarca = m.idMarca
INNER JOIN Categoria AS c ON p.Categoria_idCategoria = c.idCategoria