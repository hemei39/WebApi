USE [Northwind]
GO

/****** Object:  StoredProcedure [dbo].[spUpdateShoppingCart]    Script Date: 10/11/2018 10:55:09 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[spUpdateShoppingCart] 
	@Username nvarchar(50),
	@ProductID int,
	@Quantity int
	
AS
BEGIN

	SET NOCOUNT ON;
	
	
	update ShoppingCart
	set Quantity = @Quantity
	Where Username =@Username and ProductID =@ProductID
	
	
END


GO

