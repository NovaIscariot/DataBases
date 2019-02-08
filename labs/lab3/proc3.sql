USE myDb
GO

IF EXISTS (SELECT name FROM sys.procedures WHERE name = N'cursor_proc')
	DROP PROCEDURE [cursor_proc]
GO

CREATE PROCEDURE cursor_proc
AS
BEGIN
	DECLARE @sum int
	DECLARE @count int
	DECLARE @avg float
	DECLARE MyCursor CURSOR FOR
		SELECT DeliveryDone, Id
		FROM
			(SELECT CourierTable.Id as Id, COUNT(DoneDeliveryTable.Id) AS DeliveryDone FROM CourierTable
			JOIN DoneDeliveryTable ON CourierId = CourierTable.Id 
			GROUP BY CourierTable.Id) AS tmp

	OPEN MyCursor
	FETCH NEXT FROM MyCursor INTO @sum, @count
	WHILE @@FETCH_STATUS = 0

	BEGIN
		
		FETCH NEXT FROM MyCursor INTO  @sum, @count
	END

	PRINT @sum / @count

	CLOSE MyCursor
	DEALLOCATE MyCursor
END
GO

EXECUTE dbo.cursor_proc