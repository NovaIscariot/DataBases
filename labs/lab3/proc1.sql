use myDB
GO

CREATE PROCEDURE GiveExp(@Id int, @inc int)
AS UPDATE CourierTable
	SET Experience = Experience + @inc
	WHERE Id = @Id

SELECT * FROM CourierTable
WHERE Id = 13

EXECUTE GiveExp 13, 1

SELECT * FROM CourierTable
WHERE Id = 13

EXECUTE GiveExp 13, -1
