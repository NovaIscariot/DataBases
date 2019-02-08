USE myDb
GO

-- 1. Инструкция SELECT, использующая предикат сравнения.
SELECT * FROM CourierTable
WHERE Age = 20

-- 2. Инструкция SELECT, использующая предикат   BETWEEN. 
SELECT * FROM CourierTable
WHERE Age BETWEEN 18 and 27

-- 3. Инструкция SELECT, использующая предикат   LIKE.
SELECT * FROM DeliveryTable
WHERE Address LIKE '%Lesnaya%'

-- 4. Инструкция SELECT, использующая предикат   IN   с вложенным подзапросом. 
SELECT Id, Name FROM CourierTable
WHERE Id in 
(
	SELECT CourierTable.Id FROM CourierTable
	JOIN DoneDeliveryTable ON CourierTable.Id = CourierId
	WHERE Address LIKE '%Lesnaya%'
)

-- 5. Инструкция SELECT, использующая предикат   EXISTS   с вложенным подзапросом.
SELECT Id, Name FROM CourierTable
WHERE EXISTS
(
	SELECT Address FROM DoneDeliveryTable
	INNER JOIN CourierTable ON (DoneDeliveryTable.CourierId = CourierTable.Id)
	WHERE Address LIKE '%Novaya%'
)

-- 6. Инструкция SELECT, использующая предикат сравнения с квантором.  
SELECT * FROM CourierTable
WHERE Age > 27

-- 7. Инструкция SELECT, использующая агрегатные функции в выражениях столбцов. 
SELECT CourierTable.Id, Name, COUNT(DoneDeliveryTable.Id) AS DeliveryDone FROM CourierTable
JOIN DoneDeliveryTable ON CourierId = CourierTable.Id
GROUP BY CourierTable.Id, Name


-- 8. Инструкция SELECT, использующая скалярные подзапросы в выражениях столбцов. 
SELECT CourierTable.Id, Name 
	,(
		SELECT COUNT(DoneDeliveryTable.Id) from DoneDeliveryTable
		WHERE DoneDeliveryTable.CourierId = CourierTable.Id
	) AS DeliveryDone 
FROM CourierTable

-- 9. Инструкция SELECT, использующая простое выражение CASE. 
SELECT id, Name, CASE
		WHEN CurrentDelivery is NULL THEN 'Free'
		ELSE 'Busy'
	END As Status
FROM CourierTable

-- 10. Инструкция SELECT, использующая поисковое выражение CASE.
SELECT id, Name, CASE
		WHEN Experience < 1 THEN 'Novice'
		WHEN Experience < 3 THEN 'Regular'
		ELSE 'Pro'
	END As Status
FROM CourierTable

-- 11. Создание новой временной локальной таблицы из результирующего набора данных инструкции SELECT.
SELECT Address
INTO #ToDo
FROM DeliveryTable
WHERE CourierId is NULL

-- 12. Инструкция SELECT, использующая вложенные коррелированные подзапросы 
--     в качестве производных таблиц в предложении   FROM. 
SELECT CourierTable.Id, Name, Address FROM CourierTable
JOIN (SELECT CourierId, Address from  DoneDeliveryTable) AS Addresses 
ON CourierTable.Id = Addresses.CourierId
ORDER BY CourierTable.Id

-- 13. Инструкция SELECT, использующая вложенные подзапросы с уровнем вложенности 3. 
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

-- 14. Инструкция SELECT, консолидирующая данные с помощью предложения   GROUP     BY  
--		, но без предложения   HAVING.
SELECT CourierTable.Id, Name, COUNT(DoneDeliveryTable.Id) AS DeliveryDone FROM CourierTable
JOIN DoneDeliveryTable ON CourierId = CourierTable.Id
GROUP BY CourierTable.Id, Name

-- 15. Инструкция SELECT, консолидирующая данные с помощью предложения   GROUP     BY   
--		и  предложения   HAVING. 
SELECT CourierTable.Id, Name, COUNT(DoneDeliveryTable.Id) AS DeliveryDone FROM CourierTable
JOIN DoneDeliveryTable ON CourierId = CourierTable.Id
GROUP BY CourierTable.Id, Name
HAVING MIN(CurrentDelivery) = (
	SELECT MIN(CurrentDelivery) FROM CourierTable
)

-- 16. Однострочная инструкция INSERT, выполняющая вставку в таблицу одной строки значений. 
INSERT DeliveryTable(Id, CourierId, Address)
VALUES (101, NULL , 'Novaya 13')

-- 17. Многострочная инструкция INSERT, выполняющая вставку в таблицу 
--     результирующего набора данных вложенного подзапроса.
INSERT DoneDeliveryTable (Id, CourierId, Address)
SELECT Id + (SELECT MAX(Id) FROM DoneDeliveryTable), CourierId, Address
FROM DeliveryTable WHERE Id<5 

-- 18. Простая     инструкция   UPDATE.
UPDATE DoneDeliveryTable
SET CourierId = 15
WHERE Id = 501

-- 19. Инструкция UPDATE со скалярным подзапросом в предложении   SET. 
UPDATE CourierTable
SET Experience = 
(SELECT MAX(Experience) FROM CourierTable WHERE Id < 10)
WHERE Id = 11

-- 20. Простая инструкция   DELETE. 
DELETE FROM DeliveryTable
WHERE ID = 101

-- 21. Инструкция DELETE с вложенным коррелированным подзапросом в предложении   WHERE. //REWORK!!!
DELETE FROM DoneDeliveryTable
WHERE Address in
(SELECT DoneDeliveryTable.Address FROM CourierTable WHERE DoneDeliveryTable.Id = CourierTable.CurrentDelivery)
AND Id>500

-- 22. Инструкция SELECT, использующая простое обобщенное табличное выражение 
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
SELECT AVG(DeliveryDone) as 'Среднее число доставок на курьера'
FROM CTE
	
-- 23. Инструкция SELECT, использующая рекурсивное обобщенное табличное выражение. 
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

--24. Оконные функции. Использование конструкций MIN/MAX/AVG OVER() 
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
