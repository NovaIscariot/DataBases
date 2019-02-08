USE myDb
GO
sp_configure 'show advanced options', 1
GO
RECONFIGURE
GO
sp_configure 'clr enabled', 1
GO
RECONFIGURE
GO
--EXEC sp_configure 'clr strict security', 0; 
--RECONFIGURE;

-- 1) Определяемую пользователем скалярную функцию CLR
CREATE ASSEMBLY HandWrittenUDF
FROM
'C:\Users\Keenshi\Desktop\Учеба\5\БД\labs\lab4\lab4\bin\Debug\lab4.dll'
WITH PERMISSION_SET = SAFE; 
GO

CREATE FUNCTION GetDate (@timeStart DATETIME,@timeEnd DATETIME)
RETURNS INT
AS
EXTERNAL NAME
HandWrittenUDF.[HandWrittenUDF.UserDefinedFunctions].GetDate
GO

SELECT dbo.GetDate('2017-11-02 11:45:00.000','2017-11-02 11:50:00.000' )

DROP FUNCTION GetDate;
DROP ASSEMBLY HandWrittenUDF;

-- 2) Пользовательскую агрегатную функцию CLR
CREATE ASSEMBLY lab4
FROM
'C:\Users\Keenshi\Desktop\Учеба\5\БД\labs\lab4\lab4\bin\Debug\lab4.dll'
GO

CREATE AGGREGATE SUM( @instr int )
RETURNS INT
EXTERNAL NAME
lab4.[SqlAggregate1]
GO

SELECT dbo.SUM(age) AS Sum
FROM dbo.CourierTable
GO

DROP AGGREGATE SUM;
DROP ASSEMBLY lab4;

-- 3) Определяемую пользователем табличную функцию CLR
CREATE ASSEMBLY lab4
FROM
'C:\Users\Keenshi\Desktop\Учеба\5\БД\labs\lab4\lab4\bin\Debug\lab4.dll'
GO

CREATE FUNCTION CourierOverAge (@input int)
RETURNS TABLE 
(
   id int, 
   Name Nchar(40)
)
AS
EXTERNAL NAME
lab4.[UserDefinedFunctions].SqlTableFunction1
GO

SELECT * FROM dbo.CourierOverAge(25)
GO

DROP FUNCTION CourierOverAge;
DROP ASSEMBLY lab4;

-- 4) Хранимую процедуру CLR
CREATE ASSEMBLY lab4
FROM
'C:\Users\Keenshi\Desktop\Учеба\5\БД\labs\lab4\lab4\bin\Debug\lab4.dll'
GO

CREATE PROCEDURE AverageAge
AS
External Name
lab4.[StoredProcedures].SqlStoredProcedure1
GO

EXEC AverageAge
GO

DROP Procedure AverageAge;
DROP ASSEMBLY lab4;

-- 5) Триггер CLR
CREATE ASSEMBLY lab4
FROM
'C:\Users\Keenshi\Desktop\Учеба\5\БД\labs\lab4\lab4\bin\Debug\lab4.dll'
GO

CREATE TRIGGER DeleteAbortion
ON CourierTable
INSTEAD OF DELETE
AS
EXTERNAL NAME
lab4.[Triggers].SqlTrigger1
GO

DELETE CourierTable
WHERE ID = 100
GO

DROP TRIGGER DeleteAbortion
DROP ASSEMBLY lab4

-- 6) Определяемый пользователем тип данных CLR
CREATE ASSEMBLY lab4
FROM
'C:\Users\Keenshi\Desktop\Учеба\5\БД\labs\lab4\lab4\bin\Debug\lab4.dll'
GO

CREATE TYPE dbo.Delivery  
EXTERNAL NAME lab4.[SqlUserDefinedType1];
GO

CREATE TABLE dbo.TestDelivery
( 
  id INT IDENTITY(1,1) NOT NULL, 
  d Delivery NULL,
);
GO

DROP TABLE dbo.TestDelivery
GO
DROP TYPE Delivery
GO
DROP ASSEMBLY lab4
GO

-- Тесты
INSERT INTO dbo.TestDelivery(d) VALUES('10,13'); 
INSERT INTO dbo.TestDelivery(d) VALUES('1,1'); 
INSERT INTO dbo.TestDelivery(d) VALUES('22,6'); 
GO 

-- Вывод таблицы
SELECT * FROM dbo.TestDelivery;

SELECT id, d.ToString() AS CId 
FROM dbo.TestDelivery;

-- Некорректное значение
INSERT INTO dbo.TestDelivery(d) VALUES('a,2');
GO
---- Расстояние
--DECLARE @p1 dbo.Point
--SET @p1 = CAST('7,0' AS dbo.Point)
--SELECT @p1.Distance() AS 'Distance'
--GO