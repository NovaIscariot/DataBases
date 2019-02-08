USE myDb
GO

-- 1. ���������� SELECT, ������������ �������� ���������.
SELECT * FROM CourierTable
WHERE Age = 20

-- 2. ���������� SELECT, ������������ ��������   BETWEEN. 
SELECT * FROM CourierTable
WHERE Age BETWEEN 18 and 27

-- 3. ���������� SELECT, ������������ ��������   LIKE.
SELECT * FROM DeliveryTable
WHERE Address LIKE '%Lesnaya%'

-- 4. ���������� SELECT, ������������ ��������   IN   � ��������� �����������. 
SELECT Id, Name FROM CourierTable
WHERE Id in 
(
	SELECT CourierTable.Id FROM CourierTable
	JOIN DoneDeliveryTable ON CourierTable.Id = CourierId
	WHERE Address LIKE '%Lesnaya%'
)

-- 5. ���������� SELECT, ������������ ��������   EXISTS   � ��������� �����������.
SELECT Id, Name FROM CourierTable
WHERE EXISTS
(
	SELECT Address FROM DoneDeliveryTable
	INNER JOIN CourierTable ON (DoneDeliveryTable.CourierId = CourierTable.Id)
	WHERE Address LIKE '%Novaya%'
)

-- 6. ���������� SELECT, ������������ �������� ��������� � ���������.  
SELECT * FROM CourierTable
WHERE Age > 27

-- 7. ���������� SELECT, ������������ ���������� ������� � ���������� ��������. 
SELECT CourierTable.Id, Name, COUNT(DoneDeliveryTable.Id) AS DeliveryDone FROM CourierTable
JOIN DoneDeliveryTable ON CourierId = CourierTable.Id
GROUP BY CourierTable.Id, Name


-- 8. ���������� SELECT, ������������ ��������� ���������� � ���������� ��������. 
SELECT CourierTable.Id, Name 
	,(
		SELECT COUNT(DoneDeliveryTable.Id) from DoneDeliveryTable
		WHERE DoneDeliveryTable.CourierId = CourierTable.Id
	) AS DeliveryDone 
FROM CourierTable

-- 9. ���������� SELECT, ������������ ������� ��������� CASE. 
SELECT id, Name, CASE
		WHEN CurrentDelivery is NULL THEN 'Free'
		ELSE 'Busy'
	END As Status
FROM CourierTable

-- 10. ���������� SELECT, ������������ ��������� ��������� CASE.
SELECT id, Name, CASE
		WHEN Experience < 1 THEN 'Novice'
		WHEN Experience < 3 THEN 'Regular'
		ELSE 'Pro'
	END As Status
FROM CourierTable

-- 11. �������� ����� ��������� ��������� ������� �� ��������������� ������ ������ ���������� SELECT.
SELECT Address
INTO #ToDo
FROM DeliveryTable
WHERE CourierId is NULL

-- 12. ���������� SELECT, ������������ ��������� ��������������� ���������� 
--     � �������� ����������� ������ � �����������   FROM. 
SELECT CourierTable.Id, Name, Address FROM CourierTable
JOIN (SELECT CourierId, Address from  DoneDeliveryTable) AS Addresses 
ON CourierTable.Id = Addresses.CourierId
ORDER BY CourierTable.Id

-- 13. ���������� SELECT, ������������ ��������� ���������� � ������� ����������� 3. 
SELECT fin.Id, fin.Name FROM 
(
	Select * FROM
	(
		SELECT * FROM CourierTable
		WHERE Id in 
		(
			SELECT CourierId FROM DoneDeliveryTable
			WHERE Address LIKE '%Novaya%'
		)
	) AS tmp
	WHERE Experience > 0
) AS fin

-- 14. ���������� SELECT, ��������������� ������ � ������� �����������   GROUP     BY  
--		, �� ��� �����������   HAVING.
SELECT CourierTable.Id, Name, COUNT(DoneDeliveryTable.Id) AS DeliveryDone FROM CourierTable
JOIN DoneDeliveryTable ON CourierId = CourierTable.Id
GROUP BY CourierTable.Id, Name

-- 15. ���������� SELECT, ��������������� ������ � ������� �����������   GROUP     BY   
--		�  �����������   HAVING. 
SELECT CourierTable.Id, Name, COUNT(DoneDeliveryTable.Id) AS DeliveryDone FROM CourierTable
JOIN DoneDeliveryTable ON CourierId = CourierTable.Id
GROUP BY CourierTable.Id, Name
HAVING MIN(CurrentDelivery) = (
	SELECT MIN(CurrentDelivery) FROM CourierTable
)

-- 16. ������������ ���������� INSERT, ����������� ������� � ������� ����� ������ ��������. 
INSERT DeliveryTable(Id, CourierId, Address)
VALUES (101, NULL , 'Novaya 13')

-- 17. ������������� ���������� INSERT, ����������� ������� � ������� 
--     ��������������� ������ ������ ���������� ����������.
INSERT DoneDeliveryTable (Id, CourierId, Address)
SELECT Id + (SELECT MAX(Id) FROM DoneDeliveryTable), CourierId, Address
FROM DeliveryTable WHERE Id<5 

-- 18. �������     ����������   UPDATE.
UPDATE DoneDeliveryTable
SET CourierId = 15
WHERE Id = 501

-- 19. ���������� UPDATE �� ��������� ����������� � �����������   SET. 
UPDATE CourierTable
SET Experience = 
(SELECT MAX(Experience) FROM CourierTable WHERE Id < 10)
WHERE Id = 11

-- 20. ������� ����������   DELETE. 
DELETE FROM DeliveryTable
WHERE ID = 101

-- 21. ���������� DELETE � ��������� ��������������� ����������� � �����������   WHERE. //REWORK!!!
DELETE FROM DoneDeliveryTable
WHERE Address in
(SELECT DoneDeliveryTable.Address FROM CourierTable WHERE DoneDeliveryTable.Id = CourierTable.CurrentDelivery)
AND Id>500

-- 22. ���������� SELECT, ������������ ������� ���������� ��������� ��������� 
WITH CTE(Id, DeliveryDone)
AS
(
	SELECT CourierTable.Id
	,(
		SELECT COUNT(DoneDeliveryTable.Id) from DoneDeliveryTable
		WHERE DoneDeliveryTable.CourierId = CourierTable.Id
	) AS DeliveryDone 
FROM CourierTable
)
SELECT AVG(DeliveryDone) as '������� ����� �������� �� �������'
FROM CTE
	
-- 23. ���������� SELECT, ������������ ����������� ���������� ��������� ���������. 
WITH Rec (Id, CurrentDelivery)
AS
(
	SELECT CurrentDelivery, 1 as Id
	FROM CourierTable AS e
	UNION
	SELECT e.CurrentDelivery,  e.Id + 1
	FROM CourierTable AS e
)
Select * FROM Rec 
WHERE Id is not NULL

--24. ������� �������. ������������� ����������� MIN/MAX/AVG OVER() 
SELECT AVG(tmp.DeliveryDone) OVER() AS Average
FROM
	(SELECT Age, COUNT(DoneDeliveryTable.Id) AS DeliveryDone FROM CourierTable
	JOIN DoneDeliveryTable ON CourierId = CourierTable.Id 
	GROUP BY Age) AS tmp

--25.
WITH Rec (Id, CurrentDelivery)
AS
(
	SELECT CurrentDelivery, 1 as Id
	FROM CourierTable AS e
	UNION
	SELECT e.CurrentDelivery,  e.Id + 1
	FROM CourierTable AS e
)

SELECT ROW_NUMBER() OVER(PARTITION BY ID ORDER BY ID), Id, CurrentDelivery 
FROM Rec
