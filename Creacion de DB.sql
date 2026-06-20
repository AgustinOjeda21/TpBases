-- -----------------------------------------------------
-- Creacion de la DB
-- -----------------------------------------------------
CREATE DATABASE TpBases;
GO

USE TpBases;
GO


-- -----------------------------------------------------
-- Table Marca
-- -----------------------------------------------------
CREATE TABLE [Marca] (
  [idMarca]  INT           NOT NULL IDENTITY(1,1),
  [Nombre]   VARCHAR(100)  NOT NULL,
  CONSTRAINT [PK_Marca] PRIMARY KEY ([idMarca])
);


-- -----------------------------------------------------
-- Table Categoria
-- -----------------------------------------------------
CREATE TABLE [Categoria] (
  [idCategoria]  INT           NOT NULL IDENTITY(1,1),
  [Nombre]       VARCHAR(100)  NOT NULL,
  [Descripcion]  VARCHAR(500)  NULL,
  CONSTRAINT [PK_Categoria] PRIMARY KEY ([idCategoria])
);


-- -----------------------------------------------------
-- Table Producto
-- -----------------------------------------------------
CREATE TABLE [Producto] (
  [idProducto]          INT             NOT NULL IDENTITY(1,1),
  [Nombre]              VARCHAR(100)    NOT NULL,
  [Precio]              DECIMAL(10,2)   NOT NULL,
  [Stock]               INT             NOT NULL,
  [Marca_idMarca]       INT             NOT NULL,
  [Categoria_idCategoria] INT           NOT NULL,
  CONSTRAINT [PK_Producto] PRIMARY KEY ([idProducto]),
  CONSTRAINT [FK_Producto_Marca] FOREIGN KEY ([Marca_idMarca])
    REFERENCES [Marca] ([idMarca]),
  CONSTRAINT [FK_Producto_Categoria] FOREIGN KEY ([Categoria_idCategoria])
    REFERENCES [Categoria] ([idCategoria])
);


-- -----------------------------------------------------
-- Table UsuarioSistema
-- -----------------------------------------------------
CREATE TABLE [UsuarioSistema] (
  [idUsuario]          INT           NOT NULL IDENTITY(1,1),
  [NombreUsuario]      VARCHAR(100)  NOT NULL,
  [Contraseña]         VARCHAR(500)  NOT NULL,
  [Estado]             TINYINT       NOT NULL,
  [Rol]                INT           NOT NULL,
  [CorreoElectronico]  VARCHAR(100)  NOT NULL,
  CONSTRAINT [PK_UsuarioSistema] PRIMARY KEY ([idUsuario])
);


-- -----------------------------------------------------
-- Table Cliente
-- -----------------------------------------------------
CREATE TABLE [Cliente] (
  [idCliente]                       INT           NOT NULL IDENTITY(1,1),
  [Nombre]                          VARCHAR(50)   NOT NULL,
  [Apellido]                        VARCHAR(50)   NOT NULL,
  [Telefono]                        VARCHAR(20)   NOT NULL,
  [UsuarioSistema_idUsuarioSistema]  INT           NOT NULL,
  CONSTRAINT [PK_Cliente] PRIMARY KEY ([idCliente]),
  CONSTRAINT [UQ_Cliente_Usuario] UNIQUE ([UsuarioSistema_idUsuarioSistema]),
  CONSTRAINT [FK_Cliente_UsuarioSistema] FOREIGN KEY ([UsuarioSistema_idUsuarioSistema])
    REFERENCES [UsuarioSistema] ([idUsuario])
);


-- -----------------------------------------------------
-- Table Localidad
-- -----------------------------------------------------
CREATE TABLE [Localidad] (
  [idLocalidad]  INT           NOT NULL,
  [Pais]         VARCHAR(100)  NOT NULL,
  [Provincia]    VARCHAR(100)  NOT NULL,
  [Ciudad]       VARCHAR(100)  NOT NULL,
  CONSTRAINT [PK_Localidad] PRIMARY KEY ([idLocalidad])
);


-- -----------------------------------------------------
-- Table Direccion
-- -----------------------------------------------------
CREATE TABLE [Direccion] (
  [idDireccion]        INT           NOT NULL IDENTITY(1,1),
  [Calle]              VARCHAR(100)  NOT NULL,
  [Numero]             VARCHAR(10)   NOT NULL,
  [CodigoPostal]       VARCHAR(10)   NOT NULL,
  [Cliente_idCliente]  INT           NOT NULL,
  [Localidad_idLocalidad] INT        NOT NULL,
  CONSTRAINT [PK_Direccion] PRIMARY KEY ([idDireccion]),
  CONSTRAINT [UQ_Direccion_Cliente] UNIQUE ([Cliente_idCliente]),
  CONSTRAINT [FK_Direccion_Cliente] FOREIGN KEY ([Cliente_idCliente])
    REFERENCES [Cliente] ([idCliente]),
  CONSTRAINT [FK_Direccion_Localidad] FOREIGN KEY ([Localidad_idLocalidad])
    REFERENCES [Localidad] ([idLocalidad])
);


-- -----------------------------------------------------
-- Table Estado
-- -----------------------------------------------------
CREATE TABLE [Estado] (
  [idEstadoPedido]  INT           NOT NULL IDENTITY(1,1),
  [Nombre]          VARCHAR(100)  NOT NULL,
  CONSTRAINT [PK_Estado] PRIMARY KEY ([idEstadoPedido])
);


-- -----------------------------------------------------
-- Table MetodoPago
-- -----------------------------------------------------
CREATE TABLE [MetodoPago] (
  [idFormaPago]  INT           NOT NULL IDENTITY(1,1),
  [Nombre]       VARCHAR(100)  NOT NULL,
  CONSTRAINT [PK_MetodoPago] PRIMARY KEY ([idFormaPago])
);


-- -----------------------------------------------------
-- Table MetodoEnvio
-- -----------------------------------------------------
CREATE TABLE [MetodoEnvio] (
  [idFormaEntrega]  INT      NOT NULL IDENTITY(1,1),
  [Nombre]          VARCHAR(100)  NOT NULL,
  [CostoEnvio]      DECIMAL(10,2) NOT NULL,
  CONSTRAINT [PK_MetodoEnvio] PRIMARY KEY ([idFormaEntrega])
);


-- -----------------------------------------------------
-- Table Pedido
-- -----------------------------------------------------
CREATE TABLE [Pedido] (
  [idPedido]                  INT             NOT NULL IDENTITY(1,1),
  [Cliente_idCliente]         INT             NOT NULL,
  [Estado_idEstado]           INT             NOT NULL,
  [FechaPedido]               DATETIME        NOT NULL,
  [Total]                     DECIMAL(10,2)   NOT NULL,
  [MetodoPago_idFormaPago]    INT             NOT NULL,
  [MetodoEnvio_idFormaEntrega] INT            NOT NULL,
  CONSTRAINT [PK_Pedido] PRIMARY KEY ([idPedido]),
  CONSTRAINT [FK_Pedido_Cliente] FOREIGN KEY ([Cliente_idCliente])
    REFERENCES [Cliente] ([idCliente]),
  CONSTRAINT [FK_Pedido_Estado] FOREIGN KEY ([Estado_idEstado])
    REFERENCES [Estado] ([idEstadoPedido]),
  CONSTRAINT [FK_Pedido_MetodoPago] FOREIGN KEY ([MetodoPago_idFormaPago])
    REFERENCES [MetodoPago] ([idFormaPago]),
  CONSTRAINT [FK_Pedido_MetodoEnvio] FOREIGN KEY ([MetodoEnvio_idFormaEntrega])
    REFERENCES [MetodoEnvio] ([idFormaEntrega])
);


-- -----------------------------------------------------
-- Table DetallePedido
-- -----------------------------------------------------
CREATE TABLE [DetallePedido] (
  [idDetalle]          INT             NOT NULL,
  [Pedido_idPedido]    INT             NOT NULL,
  [Producto_idProducto] INT            NOT NULL,
  [Cantidad]           INT             NOT NULL,
  [PrecioUnitario]     DECIMAL(10,2)   NOT NULL,
  CONSTRAINT [PK_DetallePedido] PRIMARY KEY ([idDetalle]),
  CONSTRAINT [FK_DetallePedido_Pedido] FOREIGN KEY ([Pedido_idPedido])
    REFERENCES [Pedido] ([idPedido]),
  CONSTRAINT [FK_DetallePedido_Producto] FOREIGN KEY ([Producto_idProducto])
    REFERENCES [Producto] ([idProducto])
);
