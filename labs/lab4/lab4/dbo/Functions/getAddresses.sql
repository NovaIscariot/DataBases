
CREATE FUNCTION getAddresses()
RETURNS @addresses TABLE
	(
		Address NCHAR(40)
	)
AS
BEGIN
	INSERT INTO @addresses
	SELECT Address
	FROM DeliveryTable
	WHERE CourierId is NULL
RETURN
END
