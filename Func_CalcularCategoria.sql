CREATE FUNCTION CalcularCategoria(@TotalGastado DECIMAL, @Promedio DECIMAL)
RETURNS VARCHAR(20)
AS 
BEGIN
DECLARE @Etiqueta VARCHAR(20)
IF(@TotalGastado IS NULL)
BEGIN 
SET @Etiqueta = 'Error';
END
ELSE IF(@TotalGastado<(0.5*@Promedio))
BEGIN
SET @Etiqueta = 'Cliente Bronze';
END
ELSE IF(@TotalGastado>=(0.5*@Promedio)) AND (@TotalGastado<(1.5*@Promedio))
BEGIN
SET @Etiqueta = 'Cliente Silver';
END
ELSE IF(@TotalGastado>=(1.5*@Promedio))
BEGIN
SET @Etiqueta = 'Cliente Gold';
END
RETURN @Etiqueta
END
