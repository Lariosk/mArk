-- Create a new table called 'TableName' in schema 'SchemaName'
-- Drop the table if it already exists
IF OBJECT_ID('SchemaName.TableName', 'U') IS NOT NULL
DROP TABLE SchemaName.TableName
GO
-- Create the table in the specified schema
CREATE TABLE usuarios
(
    id INT NOT NULL PRIMARY KEY, -- primary key column
    nombre [NVARCHAR](50) NOT NULL,
    
    -- specify more columns here
);

CREATE TABLE logs
(

    nuevo_valor [NVARCHAR](50) NOT NULL,
    viejo_valor[NVARCHAR](50),
    tipo VARCHAR(50),
    fecha_creación DATETIME DEFAULT CURRENT_TIMESTAMP

    -- specify more columns here
);
DELIMITER //
CREATE TRIGGER after_update_usuarios
AFTER UPDATE ON usuarios
FOR EACH ROW
BEGIN
    INSERT INTO logs(nuevo_valor, viejo_valor, tipo) VALUES(NEW.nombre, OLD.nombre, "update" )
END;
DELIMITER ;
GO