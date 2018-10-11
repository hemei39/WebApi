USE [Northwind]
GO

/****** Object:  StoredProcedure [dbo].[spGetProductsByCategoryID]    Script Date: 10/11/2018 10:54:32 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





CREATE PROCEDURE [dbo].[spGetProductsByCategoryID] 
	@CategoryID int
	
AS
BEGIN

	SET NOCOUNT ON;
	
	Select * from Products
	where CategoryID = @CategoryID and Discontinued = 0
END



GO

