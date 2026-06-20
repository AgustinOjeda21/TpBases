CREATE VIEW VW_ClientesConDireccion AS
SELECT c.idCliente, CONCAT(c.Nombre,' ',c.Apellido) AS "Nombre del cliente",us.CorreoElectronico AS "Mail",c.Telefono,CONCAT(d.Calle,' ',d.Numero) AS "Direccion", l.Ciudad,d.CodigoPostal,l.Provincia,l.Pais FROM Cliente AS c
INNER JOIN Direccion AS d ON c.idCliente = d.Cliente_idCliente
INNER JOIN Localidad l ON d.Localidad_idLocalidad = l.idLocalidad
INNER JOIN UsuarioSistema AS us ON us.idUsuario = c.UsuarioSistema_idUsuarioSistema
