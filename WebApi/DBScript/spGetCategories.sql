USE [Northwind]
GO

/****** Object:  StoredProcedure [dbo].[spGetCategories]    Script Date: 10/11/2018 10:53:48 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spGetCategories] 

AS
BEGIN

	SET NOCOUNT ON;
	Select * from Categories order by CategoryName ASC
END

GO

