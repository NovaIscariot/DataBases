
CREATE FUNCTION recursive_junk()
RETURNS TABLE
RETURN
(
WITH TMP (Id, CurrentDelivery)
AS
(
	SELECT CurrentDelivery, 1 as Id
	FROM CourierTable AS e
	UNION
	SELECT e.CurrentDelivery,  e.Id + 1
	FROM CourierTable AS e
)
Select Id FROM CourierTable
)
