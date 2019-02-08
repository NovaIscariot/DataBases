CREATE TABLE [dbo].[DoneDeliveryTable] (
    [Id]        INT        NOT NULL,
    [CourierId] INT        NOT NULL,
    [Address]   NCHAR (40) NOT NULL,
    CONSTRAINT [PK_DoneDeliveryTable] PRIMARY KEY CLUSTERED ([Id] ASC),
    FOREIGN KEY ([CourierId]) REFERENCES [dbo].[CourierTable] ([Id])
);


GO

CREATE TRIGGER safety
ON DoneDeliveryTable
INSTEAD OF INSERT
AS
	PRINT 'You can not insert in this table'
