USE myDb
GO

CREATE PROCEDURE another_recursive_junk
AS
BEGIN
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
END
GO

EXECUTE another_recursive_junk