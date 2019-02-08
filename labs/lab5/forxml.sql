USE myDb
GO

--все режимы конструкции FOR XML
SELECT Id, RTRIM(LTRIM(Name)) as Name, CurrentDelivery FROM CourierTable
WHERE CurrentDelivery is not NULL
FOR XML RAW, ROOT('Couriers')

SELECT CourierTable.Id, Address FROM CourierTable
INNER JOIN DoneDeliveryTable ON (DoneDeliveryTable.CourierId = CourierTable.Id)
WHERE CourierId is NOT NULL
FOR XML AUTO

SELECT 1 as Tag
	, NULL as Parent
	, CourierTable.Id as [Courier!1!Id]
	, LTRIM(RTRIM(CourierTable.Name)) as [Courier!1!Name]
	, NULL as [Delivery!2!Address]
FROM CourierTable INNER JOIN DoneDeliveryTable ON
(CourierId = CourierTable.Id)
UNION
SELECT 2 as Tag
	, 1 as Parent
	, CourierTable.Id as [Courier!1!Id]
	, LTRIM(RTRIM(CourierTable.Name)) as [Courier!1!Name]
	, Address
FROM CourierTable INNER JOIN DoneDeliveryTable ON
(CourierId = CourierTable.Id)
ORDER BY [Courier!1!Id], [Delivery!2!Address]
FOR XML EXPLICIT, ROOT('Couriers')
GO

--SELECT CourierTable.Id 
--	, Name
--	, Address [Delivery!1!Address]
--FROM CourierTable
--JOIN DoneDeliveryTable ON (CourierId = CourierTable.Id)
--ORDER BY CourierTable.Id
--FOR XML PATH('Courier')