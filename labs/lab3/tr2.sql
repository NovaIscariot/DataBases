use myDb
GO

DROP TRIGGER safety
GO

CREATE TRIGGER safety
ON DoneDeliveryTable
INSTEAD OF DELETE
AS
	PRINT 'You can not Delete in this table'
GO

INSERT INTO DoneDeliveryTable
VALUES (501, 1, 'junk')

select * from DoneDeliveryTable

DELETE FROM DoneDeliveryTable
WHERE ID = 501