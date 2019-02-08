CREATE TABLE [dbo].[DeliveryTable] (
    [Id]        INT        NOT NULL,
    [CourierId] INT        NULL,
    [Address]   NCHAR (40) NOT NULL,
    CONSTRAINT [PK_DeliveryTable] PRIMARY KEY CLUSTERED ([Id] ASC),
    FOREIGN KEY ([CourierId]) REFERENCES [dbo].[CourierTable] ([Id])
);


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
