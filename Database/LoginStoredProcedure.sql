Create PROCEDURE [dbo].[spLogin]
     
      @ScreenName varchar(max),
      @Password varchar(max)
AS
BEGIN
      SELECT
      *
      FROM setupUser
      WHERE UserName = @ScreenName and Password = @Password
END