USE myDb
GO

CREATE PROCEDURE my_sys_proc
AS
BEGIN
	IF EXISTS (SELECT name FROM sys.procedures WHERE name = N'my_sys_proc')
		DROP PROCEDURE [my_sys_proc]
END
GO

SELECT name FROM sys.procedures

EXECUTE my_sys_proc

SELECT name FROM sys.procedures
