Create PROCEDURE [dbo].[SetupTeams]
     
      @TeamName varchar(max),
      @TeamCaptain varchar(max),
      @TeamZone varchar(max)
AS
BEGIN
	INSERT INTO [dbo].[SetupTeams] ([TeamName], [TeamCaptain],[TeamZone])
	VALUES (@TeamName,@TeamCaptain,@TeamZone);
END

Create PROCEDURE [dbo].[SetupLeague]
     
      @LeagueName varchar(max),
      @FKGameID varchar(max)
AS
BEGIN
	INSERT INTO [dbo].[SetupLeague] ([LeagueName], [FKGameID])
	VALUES (@LeagueName,@FKGameID);
END