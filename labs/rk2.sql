/* 4 вариант*/

USE master
GO

IF exists (SELECT name FROM sys.databases WHERE name = N'RK2')
	DROP DATABASE RK2
GO

CREATE DATABASE RK2
GO

USE RK2
GO

CREATE TABLE dbo.Employee
(
	EmployeeId int NOT NULL PRIMARY KEY,
	Name nchar(20) NOT NULL,
	BirthdayYear int NOT NULL,
	Experience int NOT NULL,
	Telephone nchar(10) NOT NULL,
	PointID int NOT NULL
)

CREATE TABLE dbo.Duty
(
	DutyId int NOT NULL PRIMARY KEY,
	Date date NOT NULL,
	WorkTime int NOT NULL
)

CREATE TABLE dbo.Point
(
	PointId int NOT NULL PRIMARY KEY,
	Name nchar(20) NOT NULL,
	Address nchar(30) NOT NULL
)

CREATE TABLE dbo.DutySchedule
(
	Id int NOT NULL PRIMARY KEY,
	EmployeeId int NOT NULL,
	DutyId int NOT NULL
)


INSERT INTO Employee (EmployeeId, Name, BirthdayYear, Experience, Telephone, PointID) values (1, 'Alex', 1990, 2, '8800553535', 1)
INSERT INTO Employee (EmployeeId, Name, BirthdayYear, Experience, Telephone, PointID) values (2, 'Blex', 1987, 4, '8800553455', 2)
INSERT INTO Employee (EmployeeId, Name, BirthdayYear, Experience, Telephone, PointID) values (3, 'Clex', 1997, 1, '8800598535', 3)
INSERT INTO Employee (EmployeeId, Name, BirthdayYear, Experience, Telephone, PointID) values (4, 'Dlex', 1944, 20, '8800123535', 4)
INSERT INTO Employee (EmployeeId, Name, BirthdayYear, Experience, Telephone, PointID) values (5, 'Elex', 1976, 5, '8800554535', 5)
INSERT INTO Employee (EmployeeId, Name, BirthdayYear, Experience, Telephone, PointID) values (6, 'Flex', 1954, 9, '8800598535', 6)
INSERT INTO Employee (EmployeeId, Name, BirthdayYear, Experience, Telephone, PointID) values (7, 'Glex', 1994, 0, '8800553535', 7)
INSERT INTO Employee (EmployeeId, Name, BirthdayYear, Experience, Telephone, PointID) values (8, 'Hlex', 1996, 0, '8800556535', 8)
INSERT INTO Employee (EmployeeId, Name, BirthdayYear, Experience, Telephone, PointID) values (9, 'Jlex', 1975, 7, '8800515535', 9)
INSERT INTO Employee (EmployeeId, Name, BirthdayYear, Experience, Telephone, PointID) values (10, 'Klex', 1998, 2, '8808723535', 1)
INSERT INTO Employee (EmployeeId, Name, BirthdayYear, Experience, Telephone, PointID) values (11, 'Llex', 1979, 1, '8898553535', 2)
INSERT INTO Employee (EmployeeId, Name, BirthdayYear, Experience, Telephone, PointID) values (12, 'Zlex', 1976, 8, '8800454535', 3)
INSERT INTO Employee (EmployeeId, Name, BirthdayYear, Experience, Telephone, PointID) values (13, 'Xlex', 1988, 9, '8800456535', 4)
INSERT INTO Employee (EmployeeId, Name, BirthdayYear, Experience, Telephone, PointID) values (14, 'Vlex', 1979, 5, '8800458535', 5)
INSERT INTO Employee (EmployeeId, Name, BirthdayYear, Experience, Telephone, PointID) values (15, 'Nlex', 1987, 2, '8800589535', 6)
INSERT INTO Employee (EmployeeId, Name, BirthdayYear, Experience, Telephone, PointID) values (16, 'Mlex', 1990, 0, '8801654535', 7)
INSERT INTO Employee (EmployeeId, Name, BirthdayYear, Experience, Telephone, PointID) values (17, 'AQlex', 1992, 1, '8800654535', 8)
INSERT INTO Employee (EmployeeId, Name, BirthdayYear, Experience, Telephone, PointID) values (18, 'Wlex', 1985, 11, '880055435', 9)
INSERT INTO Employee (EmployeeId, Name, BirthdayYear, Experience, Telephone, PointID) values (19, 'Elex', 1997, 2, '806653535', 10)
INSERT INTO Employee (EmployeeId, Name, BirthdayYear, Experience, Telephone, PointID) values (20, 'Rlex', 1953, 22, '7800553535', 10)

INSERT INTO Duty (DutyId, Date, WorkTime) values (1, '17/11/2018', 6)
INSERT INTO Duty (DutyId, Date, WorkTime) values (2, '18/11/2018', 6)
INSERT INTO Duty (DutyId, Date, WorkTime) values (3, '19/11/2018', 8)
INSERT INTO Duty (DutyId, Date, WorkTime) values (4, '20/11/2018', 8)
INSERT INTO Duty (DutyId, Date, WorkTime) values (5, '21/11/2018', 8)
INSERT INTO Duty (DutyId, Date, WorkTime) values (6, '22/11/2018', 8)
INSERT INTO Duty (DutyId, Date, WorkTime) values (7, '23/11/2018', 8)
INSERT INTO Duty (DutyId, Date, WorkTime) values (8, '24/11/2018', 6)
INSERT INTO Duty (DutyId, Date, WorkTime) values (9, '25/11/2018', 6)
INSERT INTO Duty (DutyId, Date, WorkTime) values (10, '26/11/2018', 8)

INSERT INTO Point (PointId, Name, Address) values (1, 'a', 'aaa')
INSERT INTO Point (PointId, Name, Address) values (2, 'b', 'aab')
INSERT INTO Point (PointId, Name, Address) values (3, 'c', 'aac')
INSERT INTO Point (PointId, Name, Address) values (4, 'd', 'aad')
INSERT INTO Point (PointId, Name, Address) values (5, 'e', 'aae')
INSERT INTO Point (PointId, Name, Address) values (6, 'f', 'aaf')
INSERT INTO Point (PointId, Name, Address) values (7, 'g', 'aag')
INSERT INTO Point (PointId, Name, Address) values (8, 'h', 'aah')
INSERT INTO Point (PointId, Name, Address) values (9, 'j', 'aaj')
INSERT INTO Point (PointId, Name, Address) values (10, 'k', 'aak')

INSERT INTO DutySchedule (Id, EmployeeId, DutyId) values (1, 1, 1)
INSERT INTO DutySchedule (Id, EmployeeId, DutyId) values (2, 2, 1)
INSERT INTO DutySchedule (Id, EmployeeId, DutyId) values (3, 3, 1)
INSERT INTO DutySchedule (Id, EmployeeId, DutyId) values (4, 4, 1)
INSERT INTO DutySchedule (Id, EmployeeId, DutyId) values (5, 5, 1)
INSERT INTO DutySchedule (Id, EmployeeId, DutyId) values (6, 6, 1)
INSERT INTO DutySchedule (Id, EmployeeId, DutyId) values (7, 7, 1)
INSERT INTO DutySchedule (Id, EmployeeId, DutyId) values (8, 8, 1)
INSERT INTO DutySchedule (Id, EmployeeId, DutyId) values (9, 9, 1)
INSERT INTO DutySchedule (Id, EmployeeId, DutyId) values (10, 19, 1)
INSERT INTO DutySchedule (Id, EmployeeId, DutyId) values (11, 10, 2)
INSERT INTO DutySchedule (Id, EmployeeId, DutyId) values (12, 11, 2)
INSERT INTO DutySchedule (Id, EmployeeId, DutyId) values (13, 12, 2)
INSERT INTO DutySchedule (Id, EmployeeId, DutyId) values (14, 13, 2)
INSERT INTO DutySchedule (Id, EmployeeId, DutyId) values (15, 14, 2)
INSERT INTO DutySchedule (Id, EmployeeId, DutyId) values (16, 15, 2)
INSERT INTO DutySchedule (Id, EmployeeId, DutyId) values (17, 16, 2)
INSERT INTO DutySchedule (Id, EmployeeId, DutyId) values (18, 17, 2)
INSERT INTO DutySchedule (Id, EmployeeId, DutyId) values (19, 18, 2)
INSERT INTO DutySchedule (Id, EmployeeId, DutyId) values (20, 20, 2)
INSERT INTO DutySchedule (Id, EmployeeId, DutyId) values (31, 1, 3)
INSERT INTO DutySchedule (Id, EmployeeId, DutyId) values (32, 2, 3)
INSERT INTO DutySchedule (Id, EmployeeId, DutyId) values (33, 3, 3)
INSERT INTO DutySchedule (Id, EmployeeId, DutyId) values (34, 4, 3)
INSERT INTO DutySchedule (Id, EmployeeId, DutyId) values (35, 5, 3)
INSERT INTO DutySchedule (Id, EmployeeId, DutyId) values (36, 6, 3)
INSERT INTO DutySchedule (Id, EmployeeId, DutyId) values (37, 7, 3)
INSERT INTO DutySchedule (Id, EmployeeId, DutyId) values (38, 8, 3)
INSERT INTO DutySchedule (Id, EmployeeId, DutyId) values (39, 9, 3)
INSERT INTO DutySchedule (Id, EmployeeId, DutyId) values (40, 19, 3)
INSERT INTO DutySchedule (Id, EmployeeId, DutyId) values (41, 10, 4)
INSERT INTO DutySchedule (Id, EmployeeId, DutyId) values (42, 11, 4)
INSERT INTO DutySchedule (Id, EmployeeId, DutyId) values (43, 12, 4)
INSERT INTO DutySchedule (Id, EmployeeId, DutyId) values (44, 13, 4)
INSERT INTO DutySchedule (Id, EmployeeId, DutyId) values (45, 14, 4)
INSERT INTO DutySchedule (Id, EmployeeId, DutyId) values (46, 15, 4)
INSERT INTO DutySchedule (Id, EmployeeId, DutyId) values (47, 16, 4)
INSERT INTO DutySchedule (Id, EmployeeId, DutyId) values (48, 17, 4)
INSERT INTO DutySchedule (Id, EmployeeId, DutyId) values (49, 18, 4)
INSERT INTO DutySchedule (Id, EmployeeId, DutyId) values (50, 20, 4)
INSERT INTO DutySchedule (Id, EmployeeId, DutyId) values (51, 1, 5)
INSERT INTO DutySchedule (Id, EmployeeId, DutyId) values (52, 2, 5)
INSERT INTO DutySchedule (Id, EmployeeId, DutyId) values (53, 3, 5)
INSERT INTO DutySchedule (Id, EmployeeId, DutyId) values (54, 4, 5)
INSERT INTO DutySchedule (Id, EmployeeId, DutyId) values (55, 5, 5)
INSERT INTO DutySchedule (Id, EmployeeId, DutyId) values (56, 6, 5)
INSERT INTO DutySchedule (Id, EmployeeId, DutyId) values (57, 7, 5)
INSERT INTO DutySchedule (Id, EmployeeId, DutyId) values (58, 8, 5)
INSERT INTO DutySchedule (Id, EmployeeId, DutyId) values (59, 9, 5)
INSERT INTO DutySchedule (Id, EmployeeId, DutyId) values (60, 19, 5)
INSERT INTO DutySchedule (Id, EmployeeId, DutyId) values (61, 10, 6)
INSERT INTO DutySchedule (Id, EmployeeId, DutyId) values (62, 11, 6)
INSERT INTO DutySchedule (Id, EmployeeId, DutyId) values (63, 12, 6)
INSERT INTO DutySchedule (Id, EmployeeId, DutyId) values (64, 13, 6)
INSERT INTO DutySchedule (Id, EmployeeId, DutyId) values (65, 14, 6)
INSERT INTO DutySchedule (Id, EmployeeId, DutyId) values (66, 15, 6)
INSERT INTO DutySchedule (Id, EmployeeId, DutyId) values (67, 16, 6)
INSERT INTO DutySchedule (Id, EmployeeId, DutyId) values (68, 17, 6)
INSERT INTO DutySchedule (Id, EmployeeId, DutyId) values (69, 18, 6)
INSERT INTO DutySchedule (Id, EmployeeId, DutyId) values (70, 20, 6)
INSERT INTO DutySchedule (Id, EmployeeId, DutyId) values (71, 1, 7)
INSERT INTO DutySchedule (Id, EmployeeId, DutyId) values (72, 2, 7)
INSERT INTO DutySchedule (Id, EmployeeId, DutyId) values (73, 3, 7)
INSERT INTO DutySchedule (Id, EmployeeId, DutyId) values (74, 4, 7)
INSERT INTO DutySchedule (Id, EmployeeId, DutyId) values (75, 5, 7)
INSERT INTO DutySchedule (Id, EmployeeId, DutyId) values (76, 6, 7)
INSERT INTO DutySchedule (Id, EmployeeId, DutyId) values (77, 7, 7)
INSERT INTO DutySchedule (Id, EmployeeId, DutyId) values (78, 8, 7)
INSERT INTO DutySchedule (Id, EmployeeId, DutyId) values (79, 9, 7)
INSERT INTO DutySchedule (Id, EmployeeId, DutyId) values (80, 19, 7)
INSERT INTO DutySchedule (Id, EmployeeId, DutyId) values (81, 10, 8)
INSERT INTO DutySchedule (Id, EmployeeId, DutyId) values (82, 11, 8)
INSERT INTO DutySchedule (Id, EmployeeId, DutyId) values (83, 12, 8)
INSERT INTO DutySchedule (Id, EmployeeId, DutyId) values (84, 13, 8)
INSERT INTO DutySchedule (Id, EmployeeId, DutyId) values (85, 14, 8)
INSERT INTO DutySchedule (Id, EmployeeId, DutyId) values (86, 15, 8)
INSERT INTO DutySchedule (Id, EmployeeId, DutyId) values (87, 16, 8)
INSERT INTO DutySchedule (Id, EmployeeId, DutyId) values (88, 17, 8)
INSERT INTO DutySchedule (Id, EmployeeId, DutyId) values (89, 18, 8)
INSERT INTO DutySchedule (Id, EmployeeId, DutyId) values (90, 20, 8)
INSERT INTO DutySchedule (Id, EmployeeId, DutyId) values (91, 1, 9)
INSERT INTO DutySchedule (Id, EmployeeId, DutyId) values (92, 2, 9)
INSERT INTO DutySchedule (Id, EmployeeId, DutyId) values (93, 3, 9)
INSERT INTO DutySchedule (Id, EmployeeId, DutyId) values (94, 4, 9)
INSERT INTO DutySchedule (Id, EmployeeId, DutyId) values (95, 5, 9)
INSERT INTO DutySchedule (Id, EmployeeId, DutyId) values (96, 6, 9)
INSERT INTO DutySchedule (Id, EmployeeId, DutyId) values (97, 7, 9)
INSERT INTO DutySchedule (Id, EmployeeId, DutyId) values (98, 8, 9)
INSERT INTO DutySchedule (Id, EmployeeId, DutyId) values (99, 9, 9)
INSERT INTO DutySchedule (Id, EmployeeId, DutyId) values (100, 19, 9)
INSERT INTO DutySchedule (Id, EmployeeId, DutyId) values (101, 10, 10)
INSERT INTO DutySchedule (Id, EmployeeId, DutyId) values (102, 11, 10)
INSERT INTO DutySchedule (Id, EmployeeId, DutyId) values (103, 12, 10)
INSERT INTO DutySchedule (Id, EmployeeId, DutyId) values (104, 13, 10)
INSERT INTO DutySchedule (Id, EmployeeId, DutyId) values (105, 14, 10)
INSERT INTO DutySchedule (Id, EmployeeId, DutyId) values (106, 15, 10)
INSERT INTO DutySchedule (Id, EmployeeId, DutyId) values (107, 16, 10)
INSERT INTO DutySchedule (Id, EmployeeId, DutyId) values (108, 17, 10)
INSERT INTO DutySchedule (Id, EmployeeId, DutyId) values (109, 18, 10)
INSERT INTO DutySchedule (Id, EmployeeId, DutyId) values (110, 20, 10)

-- Задание 2.1
SELECT Name, Status = 
	CASE
		When Experience <5 THEN 'Regular'
		ELSE 'Irregular'
	END
from Employee

--Задание 2.2
UPDATE Employee
SET Name = 'Flexx'
WHERE Name = 'Flex'


-- Задание 2.3
SELECT Name, Count(DutySchedule.DutyId) as NumberOnDuty FROM Employee 
join DutySchedule on (Employee.EmployeeId = DutySchedule.EmployeeId)
GROUP BY Name
HAVING Count(DutySchedule.DutyId) > 2