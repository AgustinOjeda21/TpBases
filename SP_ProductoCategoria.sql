CREATE PROCEDURE SP_ProductoCategoria(@Categoria VARCHAR(50))
AS 
BEGIN
SELECT p.idProducto,p.Nombre,p.Precio,p.Stock,m.Nombre,c.Nombre FROM Producto AS p
INNER JOIN Marca AS m ON m.idMarca = p.Marca_idMarca
INNER JOIN Categoria AS c ON c.idCategoria = p.Categoria_idCategoria
WHERE @Categoria = c.Nombre
END