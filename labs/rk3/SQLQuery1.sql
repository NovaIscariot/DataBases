CREATE DATABASE RK3
GO
USE RK3
GO
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Worker')
CREATE TABLE Worker
(
	Id int IDENTITY(1,1) PRIMARY KEY
	, Name nchar(60)
	, Birthday date
	, Spec nchar(40)
)
GO

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Job')
CREATE TABLE Job
(
	Id int IDENTITY(1,1) PRIMARY KEY
	, Company nchar(40)
	, Spec nchar(40)
	, Calary int
)
GO

INSERT INTO Worker VALUES ('Енин Евгений','02/07/1998','Python-специалист')
INSERT INTO Worker VALUES ('Капсомнун Дмитрий','30/08/1998','jD')
INSERT INTO Worker VALUES ('Иванов Иван','25/09/1990','JAVA-программист')
INSERT INTO Worker VALUES ('Петров Петр','12/11/1987','1С-специалист')
INSERT INTO Worker VALUES ('Романов Роман','21/03/1994','jD')
INSERT INTO Worker VALUES ('Кузнецов Александр','17/06/1994','Уборщик')
INSERT INTO Worker VALUES ('Мазайшвили Евгений','14/03/1998','jD')
INSERT INTO Worker VALUES ('Михеев Владислав','13/05/1998','Менеджер')
INSERT INTO Worker VALUES ('Качалов Алексей','8/11/1998','WEB-разработчик')
INSERT INTO Worker VALUES ('Кочкарова Лейла','08/12/1998','Data-scientist')
INSERT INTO Worker VALUES ('Вивчарук Ростислав','08/12/1998','Специалист по компьютерной графике')

INSERT INTO JOB VALUES ('ООО "Ромашка"','jD',30000)
INSERT INTO JOB VALUES ('ОАО "Василек"','jD',20000)
INSERT INTO JOB VALUES ('ОАО "Василек"','Начальник отдела',300000)
INSERT INTO JOB VALUES ('ООО "Ромашка"','Уборщик',15000)
INSERT INTO JOB VALUES ('ООО "Ромашка"','1С-специалист',45000)
INSERT INTO JOB VALUES ('ООО "Ромашка"','Менеджер',40000)
INSERT INTO JOB VALUES ('ОАО "Василек"','Python-специалист',100000)
INSERT INTO JOB VALUES ('ОАО "Василек"','WEB-разработчик',100000)
INSERT INTO JOB VALUES ('ОАО "Василек"','JAVA-программист',110000)
INSERT INTO JOB VALUES ('BLIZZARD','Специалист по компьютерной графике',150000)
INSERT INTO JOB VALUES ('BLIZZARD','Data-scientist', 200000)

--task 3
CREATE ASSEMBLY HandWrittenUDF
FROM
'C:\Users\Keenshi\Desktop\Учеба\5\БД\labs\rk3\Database1.dll'
WITH PERMISSION_SET = SAFE; 
GO

CREATE FUNCTION MinCalary()
RETURNS TABLE 
(
   Spec Nchar(40)
   , MinCalary int
)
AS
EXTERNAL NAME
HandWrittenUDF.[UserDefinedFunctions].SqlTableFunction1
GO

SELECT * FROM dbo.MinCalary()
GO

DROP FUNCTION MinCalary;
DROP ASSEMBLY HandWrittenUDF;
