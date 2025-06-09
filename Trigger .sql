-- Eliminar la tabla si ya existe
IF OBJECT_ID('dbo.usuarios', 'U') IS NOT NULL
    DROP TABLE dbo.usuarios;
GO

IF OBJECT_ID('dbo.logs', 'U') IS NOT NULL
    DROP TABLE dbo.logs;
GO

-- Crear la tabla de usuarios
CREATE TABLE dbo.usuarios
(
    id INT PRIMARY KEY,
    nombre NVARCHAR(50) NOT NULL
    -- Puedes agregar más columnas si lo deseas
);
GO

-- Crear la tabla de logs
CREATE TABLE dbo.logs
(
    id INT IDENTITY(1,1) PRIMARY KEY,
    usuario_id INT,
    viejo_valor NVARCHAR(50),
    nuevo_valor NVARCHAR(50),
    tipo NVARCHAR(50),
    fecha_creacion DATETIME DEFAULT GETDATE()
);
GO

-- Crear trigger AFTER UPDATE en la tabla usuarios
CREATE TRIGGER trg_AfterUpdate_Usuarios
ON dbo.usuarios
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO dbo.logs (usuario_id, viejo_valor, nuevo_valor, tipo)
    SELECT
        i.id,
        d.nombre,
        i.nombre,
        'UPDATE'
    FROM inserted i
    INNER JOIN deleted d ON i.id = d.id;
END;
GO

-- Crear vista para el administrador
CREATE VIEW vista_logs_admin AS
SELECT 
    l.id AS log_id,
    u.id AS usuario_id,
    u.nombre AS nombre_actual,
    l.viejo_valor,
    l.nuevo_valor,
    l.tipo,
    l.fecha_creacion
FROM dbo.logs l
LEFT JOIN dbo.usuarios u ON l.usuario_id = u.id;
GO