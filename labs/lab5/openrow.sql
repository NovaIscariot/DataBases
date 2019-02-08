USE myDb
GO

DECLARE @idoc int
DECLARE @doc xml
SELECT @doc = c FROM OPENROWSET(BULK 'C:\Users\Keenshi\Desktop\Учеба\5\БД\labs\lab5\XML.xml',
                                SINGLE_BLOB) AS TEMP(c)
EXEC sp_xml_preparedocument @idoc OUTPUT, @doc

SELECT *
FROM OPENXML (@idoc, '/Couriers/row')
WITH (Name nchar(40),Id int,CurrentDelivery nchar(40))
EXEC sp_xml_removedocument @idoc
