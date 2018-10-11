USE [Northwind]
GO

/****** Object:  StoredProcedure [dbo].[spAddToShoppingCart]    Script Date: 10/11/2018 10:52:30 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[spAddToShoppingCart] 
	@Username nvarchar(50),
	@ProductID int,
	@UnitPrice money
	
AS
BEGIN

	SET NOCOUNT ON;
	
	select * from ShoppingCart where Username =@Username and ProductID =@ProductID 
	IF (@@ROWCOUNT = 0)
		Begin
			insert into ShoppingCart(Username, ProductID, UnitPrice, Quantity, Discount)
			values (@Username,@ProductID,@UnitPrice,1,0)
		
		End
	Else
		Begin
			update ShoppingCart
			set Quantity = Quantity +1
			Where Username =@Username and ProductID =@ProductID
		ENd
	
END


GO

