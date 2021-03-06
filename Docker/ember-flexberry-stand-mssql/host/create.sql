CREATE DATABASE appdb COLLATE Cyrillic_General_CI_AS
GO
EXEC sp_configure 'CONTAINED DATABASE AUTHENTICATION', 1
GO
RECONFIGURE
GO
USE [master]
GO
ALTER DATABASE [appdb] SET CONTAINMENT = PARTIAL
GO
USE [appdb]
GO
CREATE LOGIN flexberryuser WITH PASSWORD = 'demoFD123'
GO
CREATE USER flexberryuser WITH PASSWORD = 'demoFD123'
GO
ALTER AUTHORIZATION ON DATABASE::appdb TO flexberryuser
GO
ALTER ROLE db_owner ADD MEMBER flexberryuser
GO
DECLARE @SQL varchar(MAX)
SELECT @SQL = BulkColumn
FROM OPENROWSET
    (   BULK '/MSSql.create.sql'
    ,   SINGLE_BLOB ) AS MYTABLE

--PRINT @sql
EXEC (@sql)
GO
CHECKPOINT
GO
