USE [Northwind]
GO

/****** Object:  StoredProcedure [dbo].[spDeleteFromShoppingCart]    Script Date: 10/11/2018 10:53:32 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[spDeleteFromShoppingCart] 
	@Username nvarchar(50),
	@ProductID int
	
AS
BEGIN

	SET NOCOUNT ON;	
	
	Delete From ShoppingCart			
	Where Username =@Username and ProductID =@ProductID
		
	
END


GO

