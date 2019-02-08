
CREATE PROCEDURE GiveExp(@Id int, @inc int)
AS UPDATE CourierTable
	SET Experience = Experience + @inc
	WHERE Id = @Id