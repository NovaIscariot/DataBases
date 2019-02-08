USE myDb
GO

CREATE FUNCTION recursive_junk()
RETURNS TABLE
RETURN
(
WITH Rec (Id, CurrentDelivery)
AS
(
	SELECT CurrentDelivery, 1 as Id
	FROM CourierTable AS e
	UNION
	SELECT e.CurrentDelivery,  e.Id + 1
	FROM CourierTable AS e
)
Select Id FROM Rec 
WHERE Id is not NULL
Group By Id
)
GO

SELECT * from dbo.recursive_junk()