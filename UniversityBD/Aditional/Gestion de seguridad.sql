
--Crear Schema
CREATE SCHEMA schema_secretaria;
GO
CREATE SCHEMA schema_administrador;
GO


--Crear Login
CREATE LOGIN login_secretaria
	WITH PASSWORD = 'remon',
	DEFAULT_DATABASE=UniversityBD;
GO 
CREATE LOGIN login_administrador
	WITH PASSWORD = 'remon',
	DEFAULT_DATABASE=UniversityBD;
GO


--Habilitar
ALTER LOGIN login_secretaria ENABLE;
ALTER LOGIN login_administrador ENABLE;


--Crear Usuario
CREATE USER user_secretaria
	FOR LOGIN login_secretaria
	WITH DEFAULT_SCHEMA = schema_secretaria;

CREATE USER user_adminsitrador
	FOR LOGIN login_administrador
	WITH DEFAULT_SCHEMA = schema_administrador;


--Autorización de esquema
ALTER AUTHORIZATION ON SCHEMA::[schema_secretaria] TO [user_secretaria];
ALTER AUTHORIZATION ON SCHEMA::[schema_administrador] TO [user_adminsitrador];


--Crear roles
CREATE ROLE role_secretaria;
CREATE ROLE role_administrador;


--Asigna roles
AlTER ROLE role_secretaria ADD MEMBER [user_secretaria];
AlTER ROLE role_administrador ADD MEMBER [user_adminsitrador];



--Permisos secretaria
GRANT SELECT ON DATABASE::UniversityBD TO role_secretaria;
GRANT INSERT ON DATABASE::UniversityBD TO role_secretaria;
GO
DENY DELETE ON DATABASE:: UniversityBD TO role_secretaria
DENY UPDATE ON DATABASE:: UniversityBD TO role_secretaria
DENY EXECUTE ON DATABASE:: UniversityBD TO role_secretaria


--Permisos administrador
GRANT REFERENCES ON DATABASE::UniversityBD TO role_administrador;
GRANT EXECUTE ON DATABASE::UniversityBD TO role_administrador;
GRANT SELECT ON DATABASE::UniversityBD TO role_administrador;
GRANT INSERT ON DATABASE::UniversityBD TO role_administrador;
GRANT DELETE ON DATABASE::UniversityBD TO role_administrador;
GRANT UPDATE ON DATABASE::UniversityBD TO role_administrador;
GRANT BACKUP DATABASE ON DATABASE::UniversityBD TO role_administrador;


















--Backup
USE UniversityBD;
GO

DECLARE @fecha VARCHAR(MAX)
DECLARE @archivo VARCHAR(MAX)

set @fecha=CONVERT(varchar(max), GETDATE(),105)
set @archivo='C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Backup\backupUniverityBD-'+@fecha+'.bak'

BACKUP DATABASE UniversityBD TO DISK=@archivo

WITH FORMAT,
name = 'UniversityBD'



-- Información de usuario de la bd
use UniversityBD;
SELECT * FROM sys.database_principals;


-- Lista de conecciones y usuarios
USE UniversityBD;
SELECT s.name as "Conexión", p.name as "Usuario"
FROM sys.database_principals p
INNER JOIN sys.server_principals s
ON s.sid = p.sid;

--Eliminar
--DROP USER Secretaria;


