CREATE SCHEMA TestQuala;
GO


CREATE TABLE [TestQuala].Users(
	Username varchar(50) NOT NULL ,
	Password varchar(100) NOT NULL,
	Email varchar(150) NOT NULL,
	Estado bit default(0)
	PRIMARY KEY(Username)
)
GO

CREATE TABLE [TestQuala].Monedas(
	Codigo varchar(5) NOT NULL,
	Descripcion varchar(30) NOT NULL,
	Estado bit default(0),
	PRIMARY KEY(Codigo)
)
GO

CREATE TABLE [TestQuala].Sucursales(
	Codigo int primary key NOT NULL,
	Descripcion varchar(250) NOT NULL,
	Direccion varchar(250) NOT NULL,
	Identificacion varchar(50) NOT NULL,
	FechaCreacion smalldatetime,
	Moneda varchar(5) NOT NULL,
	Estado bit default(0)
	FOREIGN KEY (Moneda) REFERENCES [TestQuala].Monedas(Codigo)
)
GO
CREATE PROC [TestQuala].SP_INSERT_UPDATE_DATA_SUCURSAL
@Codigo int,
@Descripcion varchar(250),
@Direccion varchar(250),
@Identificacion varchar(50),
@Moneda varchar(5),
@Estado bit
as
begin
	IF not exists( SELECT Codigo FROM [TestQuala].Sucursales WHERE Codigo=@Codigo)
	begin
		INSERT INTO [TestQuala].Sucursales (Codigo,Descripcion,Direccion,Identificacion,FechaCreacion,Moneda,Estado)
		VALUES (@Codigo,@Descripcion,@Direccion,@Identificacion,GETDATE(),@Moneda,@Estado)
	end
	ELSE
	begin
		update [TestQuala].Sucursales set Descripcion = @Descripcion,Direccion= @Direccion, Identificacion = @Identificacion,Moneda =@Moneda
		,Estado = @Estado
		WHERE Codigo = @Codigo
	end
end
GO

CREATE PROC [TestQuala].SP_INSERT_UPDATE_DATA_MONEDAS
@Codigo varchar(5),
@Descripcion varchar(30),
@Estado bit
as
begin
	IF not exists( SELECT Codigo FROM [TestQuala].Monedas WHERE Codigo= @Codigo)
	begin
		INSERT INTO [TestQuala].Monedas (Codigo,Descripcion,Estado)
		VALUES (@Codigo,@Descripcion,@Estado)
	end
	ELSE
	begin
		update [TestQuala].Monedas set Descripcion = @Descripcion,Estado = @Estado
		WHERE Codigo = @Codigo
	end
end
GO
