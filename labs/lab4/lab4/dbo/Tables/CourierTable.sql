CREATE TABLE [dbo].[CourierTable] (
    [Id]              INT        NOT NULL,
    [Name]            NCHAR (40) NOT NULL,
    [CurrentDelivery] INT        NULL,
    [Age]             INT        NOT NULL,
    [Experience]      INT        NOT NULL,
    CONSTRAINT [PK_CourierTable] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [chkAge] CHECK ([Age]>(0)),
    CONSTRAINT [chkExp] CHECK ([Experience]>(-1)),
    FOREIGN KEY ([CurrentDelivery]) REFERENCES [dbo].[DeliveryTable] ([Id])
);

