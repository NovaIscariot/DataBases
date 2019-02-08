
CREATE FUNCTION getFreeCouriers()
RETURNS TABLE
AS RETURN
(
	SELECT * FROM CourierTable
	WHERE CurrentDelivery is NULL
)
