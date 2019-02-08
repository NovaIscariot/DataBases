USE [myDb]
GO

BULK INSERT [dbo].[DeliveryTable]
FROM 'C:\delivery.txt'
WITH
(
	rowterminator = '\n',
	fieldterminator = ','
)  
GO


