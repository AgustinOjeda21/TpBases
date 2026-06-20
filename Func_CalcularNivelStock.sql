CREATE FUNCTION CalcularNivelStock(@PromedioVentas DECIMAL, @Stock int)
RETURNS VARCHAR(20)
AS 
BEGIN
DECLARE @Nivel VARCHAR(20)
IF(@PromedioVentas IS NULL) OR (@Stock IS NULL)
BEGIN 
SET @Nivel = 'Error';
END
ELSE IF(@PromedioVentas=0)
BEGIN
SET @Nivel = 'Producto sin ventas';
END
ELSE IF(@Stock<@PromedioVentas)
BEGIN
SET @Nivel = 'Stock Critico';
END
ELSE IF(@Stock>=@PromedioVentas) AND (@Stock<2*@PromedioVentas)
BEGIN
SET @Nivel = 'Stock Bajo';
END
ELSE IF(@Stock>=2*@PromedioVentas) AND (@Stock<4*@PromedioVentas)
BEGIN
SET @Nivel = 'Stock Medio';
END
ELSE
BEGIN
SET @Nivel = 'Stock Alto';
END
RETURN @Nivel
END
