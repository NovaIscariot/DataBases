use myDb
go

CREATE FUNCTION getFreeCouriers()
RETURNS TABLE
AS RETURN
(
	SELECT * FROM CourierTable
	WHERE CurrentDelivery is NULL
)
GO

SELECT * FROM dbo.getFreeCouriers()