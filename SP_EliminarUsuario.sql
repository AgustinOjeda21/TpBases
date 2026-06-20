CREATE PROCEDURE SP_EliminarUsuario(@Usuario BIGINT)
AS 
BEGIN
BEGIN TRY 
IF (@Usuario IS NULL)
BEGIN
THROW 50001, 'No se ingreso un usuario', 1;
RETURN
END
IF NOT EXISTS(SELECT 1 FROM UsuarioSistema WHERE idUsuario = @Usuario)
BEGIN
THROW 50001, 'El usuario ingresado no existe', 1;
RETURN
END
BEGIN TRANSACTION
IF EXISTS(SELECT 1 FROM Cliente WHERE UsuarioSistema_idUsuarioSistema = @Usuario)
BEGIN
DECLARE @Cliente BIGINT
SELECT @Cliente = idCliente FROM Cliente WHERE UsuarioSistema_idUsuarioSistema = @Usuario
DELETE FROM DetallePedido WHERE Pedido_idPedido IN(SELECT idPedido FROM Pedido WHERE Cliente_idCliente = @Cliente)
DELETE FROM Pedido WHERE Cliente_idCliente = @Cliente
DELETE FROM Cliente WHERE UsuarioSistema_idUsuarioSistema = @Usuario
END
DELETE FROM UsuarioSistema WHERE idUsuario = @Usuario
COMMIT TRANSACTION
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
THROW
END CATCH
END
