USE [Northwind]
GO

/****** Object:  StoredProcedure [dbo].[spGetShoppingCart]    Script Date: 10/11/2018 10:54:55 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[spGetShoppingCart] 
	@Username nvarchar(50)
	
AS
BEGIN

	SET NOCOUNT ON;
	
	Select *, UnitPrice*Quantity as SubTotal from ShoppingCart
	where Username = @Username
END


GO

