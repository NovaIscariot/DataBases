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

INSERT INTO Worker VALUES ('���� �������','02/07/1998','Python-����������')
INSERT INTO Worker VALUES ('��������� �������','30/08/1998','jD')
INSERT INTO Worker VALUES ('������ ����','25/09/1990','JAVA-�����������')
INSERT INTO Worker VALUES ('������ ����','12/11/1987','1�-����������')
INSERT INTO Worker VALUES ('������� �����','21/03/1994','jD')
INSERT INTO Worker VALUES ('�������� ���������','17/06/1994','�������')
INSERT INTO Worker VALUES ('���������� �������','14/03/1998','jD')
INSERT INTO Worker VALUES ('������ ���������','13/05/1998','��������')
INSERT INTO Worker VALUES ('������� �������','8/11/1998','WEB-�����������')
INSERT INTO Worker VALUES ('��������� �����','08/12/1998','Data-scientist')
INSERT INTO Worker VALUES ('�������� ���������','08/12/1998','���������� �� ������������ �������')

INSERT INTO JOB VALUES ('��� "�������"','jD',30000)
INSERT INTO JOB VALUES ('��� "�������"','jD',20000)
INSERT INTO JOB VALUES ('��� "�������"','��������� ������',300000)
INSERT INTO JOB VALUES ('��� "�������"','�������',15000)
INSERT INTO JOB VALUES ('��� "�������"','1�-����������',45000)
INSERT INTO JOB VALUES ('��� "�������"','��������',40000)
INSERT INTO JOB VALUES ('��� "�������"','Python-����������',100000)
INSERT INTO JOB VALUES ('��� "�������"','WEB-�����������',100000)
INSERT INTO JOB VALUES ('��� "�������"','JAVA-�����������',110000)
INSERT INTO JOB VALUES ('BLIZZARD','���������� �� ������������ �������',150000)
INSERT INTO JOB VALUES ('BLIZZARD','Data-scientist', 200000)

--task 3
CREATE ASSEMBLY HandWrittenUDF
FROM
'C:\Users\Keenshi\Desktop\�����\5\��\labs\rk3\Database1.dll'
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
