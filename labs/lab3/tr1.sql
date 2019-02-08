USE myDb
GO

--DROP TRIGGER tr_close_delivery

CREATE TRIGGER tr_close_delivery
ON DeliveryTable
AFTER DELETE
AS
BEGIN
	INSERT INTO DoneDeliveryTable
	VALUES (1 + (SELECT MAX(Id) From DoneDeliveryTable)
	, (SELECT CourierId FROM deleted WHERE Id = (SELECT MAX(Id) From DELETED))
	, (SELECT Address FROM deleted WHERE Id = (SELECT MAX(Id) From DELETED))
	)
END
GO
SELECT * FROM DoneDeliveryTable
INSERT INTO DeliveryTable VALUES
( 101, 1 , 'qewq')

DELETE FROM DeliveryTable
WHERE Id = 101
