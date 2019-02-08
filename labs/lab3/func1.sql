use myDb
go

CREATE FUNCTION getDeliveryCount(@id int)
RETURNS INT AS
BEGIN
	RETURN 
	(SELECT COUNT(DoneDeliveryTable.Id) AS DeliveryDone FROM CourierTable
	JOIN DoneDeliveryTable ON CourierId = CourierTable.Id
	WHERE CourierTable.Id = @id
	GROUP BY CourierTable.Id)
END
GO

SELECT dbo.getDeliveryCount(CourierTable.Id) AS Count FROM CourierTable
WHERE Id = 24