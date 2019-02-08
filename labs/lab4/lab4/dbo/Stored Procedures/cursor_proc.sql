
CREATE PROCEDURE cursor_proc
AS
BEGIN
	DECLARE @avg float
	DECLARE MyCursor CURSOR FOR
		SELECT AVG(tmp.DeliveryDone) AS Average
		FROM
			(SELECT CourierTable.Id, COUNT(DoneDeliveryTable.Id) AS DeliveryDone FROM CourierTable
			JOIN DoneDeliveryTable ON CourierId = CourierTable.Id 
			GROUP BY CourierTable.Id) AS tmp

	OPEN MyCursor
	FETCH NEXT FROM MyCursor INTO @avg
	WHILE @@FETCH_STATUS = 0
	BEGIN
		PRINT @avg
		FETCH NEXT FROM MyCursor INTO @avg
	END

	CLOSE MyCursor
	DEALLOCATE MyCursor
END
