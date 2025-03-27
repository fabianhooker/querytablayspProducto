CREATE TABLE Productos (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Nombre NVARCHAR(255) NOT NULL,
    Precio DECIMAL(18,2) NOT NULL,
    Stock INT NOT NULL,
    FechaRegistro DATETIME DEFAULT GETDATE()
);

-- Procedimientos almacenados
CREATE PROCEDURE sp_InsertarProducto
    @Nombre NVARCHAR(255),
    @Precio DECIMAL(18,2),
    @Stock INT,
    @Id INT OUTPUT,
    @Resultado BIT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;


    IF EXISTS (SELECT 1 FROM Productos WHERE Nombre = @Nombre)
    BEGIN
        SET @Resultado = 0; 
        RETURN;
    END

    -- Insertar el producto
    INSERT INTO Productos (Nombre, Precio, Stock)
    VALUES (@Nombre, @Precio, @Stock);

    SET @Id = SCOPE_IDENTITY(); 
    SET @Resultado = 1; 
END;

CREATE PROCEDURE sp_ActualizarProducto
    @Id INT,
    @Nombre NVARCHAR(255),
    @Precio DECIMAL(18,2),
    @Stock INT,
    @Resultado BIT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;


    IF NOT EXISTS (SELECT 1 FROM Productos WHERE Id = @Id)
    BEGIN
        SET @Resultado = 0; 
        RETURN;
    END

    -- Actualizar el producto
    UPDATE Productos
    SET Nombre = @Nombre, Precio = @Precio, Stock = @Stock
    WHERE Id = @Id;

    SET @Resultado = 1; 
END;

 CREATE PROCEDURE sp_ObtenerProductos
AS
BEGIN
    SELECT * FROM Productos;
END;

CREATE PROCEDURE sp_ObtenerProductoPorId
    @Id INT
AS
BEGIN
      SET NOCOUNT ON;

  
    SELECT * FROM Productos WHERE Id = @Id;
END;

CREATE PROCEDURE sp_EliminarProducto
    @Id INT,
    @Resultado BIT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;


    IF NOT EXISTS (SELECT 1 FROM Productos WHERE Id = @Id)
    BEGIN
        SET @Resultado = 0; -- Producto no encontrado
        RETURN;
    END


    DELETE FROM Productos WHERE Id = @Id;
    SET @Resultado = 1; 
END;