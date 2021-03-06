USE [master]
GO
/****** Object:  Database [contactASPDB]    Script Date: 10/01/2014 15:12:24 ******/
CREATE DATABASE [contactASPDB] ON  PRIMARY 
( NAME = N'contactASPDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\DATA\contactASPDB.mdf' , SIZE = 7168KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'contactASPDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\DATA\contactASPDB_1.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [contactASPDB] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [contactASPDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [contactASPDB] SET ANSI_NULL_DEFAULT OFF
GO
ALTER DATABASE [contactASPDB] SET ANSI_NULLS OFF
GO
ALTER DATABASE [contactASPDB] SET ANSI_PADDING OFF
GO
ALTER DATABASE [contactASPDB] SET ANSI_WARNINGS OFF
GO
ALTER DATABASE [contactASPDB] SET ARITHABORT OFF
GO
ALTER DATABASE [contactASPDB] SET AUTO_CLOSE OFF
GO
ALTER DATABASE [contactASPDB] SET AUTO_CREATE_STATISTICS ON
GO
ALTER DATABASE [contactASPDB] SET AUTO_SHRINK OFF
GO
ALTER DATABASE [contactASPDB] SET AUTO_UPDATE_STATISTICS ON
GO
ALTER DATABASE [contactASPDB] SET CURSOR_CLOSE_ON_COMMIT OFF
GO
ALTER DATABASE [contactASPDB] SET CURSOR_DEFAULT  GLOBAL
GO
ALTER DATABASE [contactASPDB] SET CONCAT_NULL_YIELDS_NULL OFF
GO
ALTER DATABASE [contactASPDB] SET NUMERIC_ROUNDABORT OFF
GO
ALTER DATABASE [contactASPDB] SET QUOTED_IDENTIFIER OFF
GO
ALTER DATABASE [contactASPDB] SET RECURSIVE_TRIGGERS OFF
GO
ALTER DATABASE [contactASPDB] SET  DISABLE_BROKER
GO
ALTER DATABASE [contactASPDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF
GO
ALTER DATABASE [contactASPDB] SET DATE_CORRELATION_OPTIMIZATION OFF
GO
ALTER DATABASE [contactASPDB] SET TRUSTWORTHY OFF
GO
ALTER DATABASE [contactASPDB] SET ALLOW_SNAPSHOT_ISOLATION OFF
GO
ALTER DATABASE [contactASPDB] SET PARAMETERIZATION SIMPLE
GO
ALTER DATABASE [contactASPDB] SET READ_COMMITTED_SNAPSHOT OFF
GO
ALTER DATABASE [contactASPDB] SET HONOR_BROKER_PRIORITY OFF
GO
ALTER DATABASE [contactASPDB] SET  READ_WRITE
GO
ALTER DATABASE [contactASPDB] SET RECOVERY SIMPLE
GO
ALTER DATABASE [contactASPDB] SET  MULTI_USER
GO
ALTER DATABASE [contactASPDB] SET PAGE_VERIFY CHECKSUM
GO
ALTER DATABASE [contactASPDB] SET DB_CHAINING OFF
GO
USE [contactASPDB]
GO
/****** Object:  Table [dbo].[HelpText]    Script Date: 10/01/2014 15:12:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[HelpText](
	[SectionID] [int] IDENTITY(1,1) NOT NULL,
	[SectionHeader] [varchar](255) NOT NULL,
	[SectionText] [varchar](max) NULL,
 CONSTRAINT [PK_HelpText] PRIMARY KEY CLUSTERED 
(
	[SectionID] ASC,
	[SectionHeader] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[FilterSearchSp]    Script Date: 10/01/2014 15:12:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Renato De Jesus>
-- Create date: <5/12/2013>
-- Description:	<Return Filterd result set>
-- =============================================
CREATE PROCEDURE [dbo].[FilterSearchSp]
	-- Add the parameters for the stored procedure here
	@Filter varchar(max),
	@ID INT = NULL
AS
BEGIN
DECLARE @SQL VARCHAR(MAX)

	SET @SQL = 'SELECT 
       [ScreenName]		as UserName
      ,[PersonName]		as [First Name]
      ,[PersonSurname]	as Surname
      ,[PersonTitle]	as Title
      ,[PersonRole]		as Role
      ,[Cell]			as [Cell No.]
      ,[Phone]			as [Tell No.]
      ,[eMail]			as [E-mail]
      ,CI.Industry 
      ,CC.Company
      ,CD.Department
      ,CS.Site   
  FROM [contactASPDB].[dbo].[contactPerson] CP
  INNER JOIN contactDepartment CD 
  ON CD.IDDepartment = CP.FKDepartment
  INNER JOIN contactSite CS ON CS.IDSite = CD.FKSite
  INNER JOIN contactCompany CC ON CS.FKCompany = cc.IDCompany
  INNER JOIN contactIndustry CI 
  ON CI.IDIndustry = CC.FKIndustry'
  
	IF @Filter = 'Site'
	BEGIN
		SET @SQL = @SQL + ' WHERE CS.IDSite = ' + CONVERT(VARCHAR(10),@ID)
	END
		IF @Filter = 'Department'
	BEGIN
		SET @SQL = @SQL + ' WHERE CP.FKDepartment = '+ CONVERT(VARCHAR(10),@ID)
	END
			IF @Filter = 'Industry'
	BEGIN
		SET @SQL = @SQL + '  WHERE CP.FKIndustry = '+ CONVERT(VARCHAR(10),@ID)
	END
	IF @Filter = 'Company'
	BEGIN
		SET @SQL = @SQL + '  WHERE CC.IDCompany = '+ CONVERT(VARCHAR(10),@ID)
	END
	print(@sql)
	EXEC(@SQL)
END
GO
/****** Object:  Table [dbo].[Products]    Script Date: 10/01/2014 15:12:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Products](
	[ProductID] [int] IDENTITY(1,1) NOT NULL,
	[FKCompany] [int] NULL,
	[FKDepartment] [int] NULL,
	[Product] [varchar](100) NULL,
	[Barcode] [uniqueidentifier] NULL,
	[Price] [decimal](18, 2) NULL,
	[Ave_Rating] [decimal](18, 1) NULL,
 CONSTRAINT [PK_Products] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ProductRatings]    Script Date: 10/01/2014 15:12:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ProductRatings](
	[IDRating] [int] IDENTITY(1,1) NOT NULL,
	[FKProduct] [int] NULL,
	[Rating] [int] NULL,
	[FKDepartment] [int] NULL,
	[Comments] [varchar](max) NULL,
 CONSTRAINT [PK_ProductRatings] PRIMARY KEY CLUSTERED 
(
	[IDRating] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[EventPerson_History]    Script Date: 10/01/2014 15:12:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[EventPerson_History](
	[IDEventHistory] [int] IDENTITY(1,1) NOT NULL,
	[FKEvent] [int] NOT NULL,
	[Status_Date] [datetime] NULL,
	[Status] [varchar](255) NULL,
	[Followup_Date] [datetime] NULL,
	[Done] [bit] NULL,
	[FKPerson_Review] [int] NULL,
	[Review] [datetime] NULL,
	[ReviewComment] [varchar](max) NULL,
 CONSTRAINT [PK_EventPerson_History] PRIMARY KEY CLUSTERED 
(
	[IDEventHistory] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[FilterEventsSp]    Script Date: 10/01/2014 15:12:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[FilterEventsSp]
	-- Add the parameters for the stored procedure here
	@Filter varchar(max),
	@ID INT = NULL,
	@SpDone bit = NULL
AS
BEGIN
DECLARE @SQL VARCHAR(MAX),
		@Flag INT = 0;

	SET @SQL = 'SELECT 
       IDEvent
       ,Heading
       ,Status
       ,Complete
       ,Client
       ,CI.Industry
       ,CC.Company
       ,CD.Department
       ,CS.Site
       ,Comment
       ,PR.Product
       ,Offer_Value as [Offer Value] 
       ,TrackerNo as [Tracker No]
       ,PP.PersonName + '' '' + PP.PersonSurname AS Person
  FROM [contactASPDB].[dbo].[Events] CP
  INNER JOIN ContactIndustry CI
	ON CI.IDIndustry = CP.FKIndustry
  INNER JOIN contactDepartment CD 
	ON CD.IDDepartment = CP.FKDepartment
  INNER JOIN contactSite CS
	ON CS.IDSite = CD.FKSite
  INNER JOIN contactCompany CC
	ON CS.FKCompany = cc.IDCompany
  INNER JOIN Products PR ON CP.FKProduct = PR.ProductID
  LEFT JOIN EventPerson EP ON EP.FKEvent = CP.IDEvent
  LEFT JOIN contactPerson PP ON PP.IDPerson = EP.FKPerson'
	
  IF @ID IS NOT NULL
   BEGIN
	IF @Filter = 'Site'
	 BEGIN
		SET @SQL = @SQL + ' WHERE CS.IDSite = ' + CONVERT(VARCHAR(10),@ID)
		SET @Flag = 1
	 END
	IF @Filter = 'Department'
	 BEGIN
		SET @SQL = @SQL + ' WHERE CP.FKDepartment = '+ CONVERT(VARCHAR(10),@ID)
		SET @Flag = 1
	 END
	IF @Filter = 'Company'
	 BEGIN
		SET @SQL = @SQL + '  WHERE CC.IDCompany = '+ CONVERT(VARCHAR(10),@ID)
		SET @Flag = 1
	 END
	END
	
	IF @SpDone IS NOT NULL
	 BEGIN
		IF @Flag = 1
		 BEGIN
			SET @SQL = @SQL + ' AND CP.Complete = ' + CONVERT(VARCHAR(10), @SpDone)
		 END
		ELSE
		 BEGIN
			SET @SQL = @SQL + ' WHERE CP.Complete = ' + CONVERT(VARCHAR(10), @SpDone)
		 END
	 END
	print(@sql)
	EXEC(@SQL)
END
GO
/****** Object:  StoredProcedure [dbo].[FilterEHistory]    Script Date: 10/01/2014 15:12:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Olivier,Stefan>
-- Create date: <2013-12-17>
-- Description:	<Filters the Events according to Company, site, Department or Person>
-- =============================================
CREATE PROCEDURE [dbo].[FilterEHistory] 
	-- Add the parameters for the stored procedure here
	@FkValue varchar(127),
	@ColumnName varchar(max) = 'FKPerson'
AS
BEGIN
	Declare @SQL varchar(max)  = 
		'SELECT * FROM EventPerson_History PH 
		INNER JOIN [Events] E 
		ON PH.FKEvent = E.IDEvent
		LEFT JOIN (Select ScreenName
		, PersonName
		, PersonSurname
		, PersonRole
		, FKEvent
		, IDPerson FROM EventPerson EP
		INNER JOIN ContactPerson CP
		ON EP.FKPerson = IDPerson) as #Temp
		ON #Temp.FKEvent = PH.FKEvent
		WHERE ' + @ColumnName + ' = ' + @FkValue
			
	EXEC(@SQL)
END
GO
/****** Object:  Table [dbo].[NewsFeed]    Script Date: 10/01/2014 15:12:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[NewsFeed](
	[IDMessage] [int] IDENTITY(1,1) NOT NULL,
	[Heading] [varchar](50) NULL,
	[Message] [varchar](max) NULL,
	[DateCreated] [datetime] NULL,
	[FKPerson] [int] NULL,
	[FKDepartment] [int] NULL,
	[Image] [varchar](max) NULL,
 CONSTRAINT [PK_NewsFeed] PRIMARY KEY CLUSTERED 
(
	[IDMessage] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[SearchPersonSp]    Script Date: 10/01/2014 15:12:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<De Jesus, Renato>
-- Create date: <5/12/2013>
-- Description:	<SP to return the basic search results for contacts>
-- =============================================
CREATE PROCEDURE [dbo].[SearchPersonSp] 
	-- Add the parameters for the stored procedure here
	@Search varchar(max),
	@Filter varchar(max),
	@ID INT
AS
BEGIN
DECLARE @SQL VARCHAR(MAX),
		@Flag BIT = 0

	SET @SQL = '  SELECT 
       [ScreenName]		as UserName
      ,[PersonName]		as [First Name]
      ,[PersonSurname]	as Surname
      ,[PersonTitle]	as Title
      ,[PersonRole]		as Role
      ,[Cell]			as [Cell No.]
      ,[Phone]			as [Tell No.]
      ,[eMail]			as [E-mail]
      ,CI.Industry
      ,CC.Company
      ,CD.Department
      ,CS.Site
     
  FROM [contactASPDB].[dbo].[contactPerson] CP
  INNER JOIN contactDepartment CD 
  ON CD.IDDepartment = CP.FKDepartment
  INNER JOIN contactIndustry CI 
  ON CI.IDIndustry = CP.FKIndustry
  INNER JOIN contactSite CS ON CS.IDSite = CD.FKSite
  INNER JOIN contactCompany CC ON CS.FKCompany = cc.IDCompany'
  
	
	IF @Filter = 'Site'
	BEGIN
		SET @SQL = @SQL + ' WHERE CS.IDSite = ' + CONVERT(VARCHAR(10),@ID)
							SET @Flag = 1
	END
		IF @Filter = 'Department'
	BEGIN
		SET @SQL = @SQL + ' WHERE CP.FKDepartment = '+ CONVERT(VARCHAR(10),@ID)
		SET @Flag = 1
	END
			IF @Filter = 'Industry'
	BEGIN
		SET @SQL = @SQL + '  WHERE CP.FKIndustry = '+ CONVERT(VARCHAR(10),@ID)
		SET @Flag = 1
	END
			IF @Filter = 'Company'
	BEGIN
		SET @SQL = @SQL + '  WHERE CC.IDCompany = '+ CONVERT(VARCHAR(10),@ID)
		SET @Flag = 1
	END
		IF @Flag = 1
		BEGIN
			
	
	SET @SQL = @SQL +' AND (CP.ScreenName LIKE ''%'+ @Search +'%''
				   OR CP.PersonName LIKE ''%' + @Search + '%''
                   OR CP.PersonSurname LIKE ''%' + @Search + '%'')'
				 
		END
		ELSE
		BEGIN
		SET @SQL = @SQL +' WHERE CP.ScreenName LIKE ''%'+ @Search +'%''
				   OR CP.PersonName LIKE ''%' + @Search + '%''
                   OR CP.PersonSurname LIKE ''%' + @Search + '%'''
                 END
			
	EXEC(@SQL)
	
	END
GO
/****** Object:  StoredProcedure [dbo].[SearchEventSp]    Script Date: 10/01/2014 15:12:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<De Jesus, Renato>
-- Create date: <5/12/2013>
-- Description:	<SP to return the basic search results for contacts>
-- =============================================
CREATE PROCEDURE [dbo].[SearchEventSp] 
	-- Add the parameters for the stored procedure here
	@Search varchar(max),
	@Filter varchar(max),
	@ID INT = NULL,
	@SpDone bit = NULL
AS
BEGIN
DECLARE @SQL VARCHAR(MAX),
		@Flag BIT = 0

	SET @SQL = '  SELECT 
       IDEvent
       ,Heading
       ,Status
       ,Complete
       ,Client
       ,CI.Industry
       ,CC.Company
       ,CD.Department
       ,CS.Site
       ,Comment
       ,Offer_Value as [Offer Value] 
       ,TrackerNo as [Tracker No]     
  FROM [contactASPDB].[dbo].[EventPerson] EP
  INNER JOIN contactPerson CP 
    ON EP.FKPerson = CP.IDPerson
  INNER JOIN contactDepartment CD 
	ON CD.IDDepartment = CP.FKDepartment
  INNER JOIN contactSite CS
	ON CS.IDSite = CD.FKSite
  INNER JOIN contactCompany CC
	ON CS.FKCompany = cc.IDCompany
   INNER JOIN ContactIndustry CI
	ON CI.IDIndustry = CC.FKIndustry
	INNER JOIN [Events] Ev
	ON Ev.[IDEvent] = EP.FKEvent'
  
  IF @ID IS NOT NULL
   BEGIN
	IF @Filter = 'Site'
	BEGIN
		SET @SQL = @SQL + ' WHERE CS.IDSite = ' + CONVERT(VARCHAR(10),@ID)
							SET @Flag = 1
	END
		IF @Filter = 'Department'
	BEGIN
		SET @SQL = @SQL + ' WHERE CP.FKDepartment = '+ CONVERT(VARCHAR(10),@ID)
		SET @Flag = 1
	END
			IF @Filter = 'Company'
	BEGIN
		SET @SQL = @SQL + '  WHERE CC.IDCompany = '+ CONVERT(VARCHAR(10),@ID)
		SET @Flag = 1
	END
   END
	
	IF @Flag = 1
	 BEGIN
		SET @SQL = @SQL +' AND (Ev.Heading LIKE ''%'+ @Search +'%''
						   OR Ev.TrackerNo = ' + @Search + ')'
	 END
	ELSE
	 BEGIN
		SET @SQL = @SQL +' WHERE (Ev.Heading LIKE ''%'+ @Search + '%''
						   OR Ev.TrackerNo = ' + @Search + ')'
     END
     
     IF @SpDone IS NOT NULL
	 BEGIN
		SET @SQL = @SQL + ' AND Ev.Complete = ' + CONVERT(VARCHAR(10), @SpDone)
	 END
			
	EXEC(@SQL)
	
	END
GO
/****** Object:  Table [dbo].[Results]    Script Date: 10/01/2014 15:12:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Results](
	[ResultID] [int] NOT NULL,
	[HomeTeamID] [int] NULL,
	[AwayTeamID] [int] NULL,
	[FKLeagueID] [int] NULL,
	[FirstScore] [varchar](4) NOT NULL,
	[SecondScore] [varchar](4) NOT NULL,
	[FKGameID] [int] NULL,
	[Confirmed] [varchar](50) NULL,
	[ResultPath] [varchar](100) NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SetupUser]    Script Date: 10/01/2014 15:12:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SetupUser](
	[IDUser] [int] NOT NULL,
	[UserName] [varchar](50) NOT NULL,
	[FirstName] [varchar](50) NULL,
	[Surname] [varchar](100) NULL,
	[Email] [varchar](200) NULL,
	[Cell] [varchar](10) NULL,
	[FKUserType] [int] NULL,
	[UserPassword] [varchar](1024) NULL,
	[UserStatus] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[IDUser] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SetupTeams]    Script Date: 10/01/2014 15:12:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SetupTeams](
	[TeamID] [int] IDENTITY(1,1) NOT NULL,
	[TeamName] [varchar](50) NULL,
	[TeamCaptain] [int] NULL,
	[TeamZone] [varchar](50) NULL,
 CONSTRAINT [PK_SetupTeams] PRIMARY KEY CLUSTERED 
(
	[TeamID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SetupMapUserTeams]    Script Date: 10/01/2014 15:12:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SetupMapUserTeams](
	[IDTeamUsersMap] [int] NOT NULL,
	[FKUserID] [int] NULL,
	[FKTeamID] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SetupMapGames]    Script Date: 10/01/2014 15:12:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SetupMapGames](
	[IDMapGames] [int] NOT NULL,
	[FKLeagueID] [int] NOT NULL,
	[FKGameID] [int] NOT NULL,
	[NextMatchDate] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SetupGame]    Script Date: 10/01/2014 15:12:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[SetupGame](
	[GameID] [int] IDENTITY(1,1) NOT NULL,
	[GameName] [varchar](50) NULL,
	[PointsPerGAme] [varchar](50) NULL,
	[GameDescription] [varchar](max) NULL,
 CONSTRAINT [PK_SetupGame] PRIMARY KEY CLUSTERED 
(
	[GameID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SecurityClearance]    Script Date: 10/01/2014 15:12:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SecurityClearance](
	[IDSecurity] [int] IDENTITY(1,1) NOT NULL,
	[Description] [varchar](50) NULL,
	[Enabled] [bit] NULL,
 CONSTRAINT [PK_SecurityClearance] PRIMARY KEY CLUSTERED 
(
	[IDSecurity] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ContactTitle]    Script Date: 10/01/2014 15:12:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ContactTitle](
	[TitleID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](50) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[contactSite]    Script Date: 10/01/2014 15:12:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[contactSite](
	[IDSite] [int] IDENTITY(1,1) NOT NULL,
	[FKCompany] [int] NOT NULL,
	[Site] [varchar](255) NULL,
 CONSTRAINT [PK_contactSite] PRIMARY KEY CLUSTERED 
(
	[IDSite] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[contactPerson_History]    Script Date: 10/01/2014 15:12:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[contactPerson_History](
	[IDPersonHistory] [int] IDENTITY(1,1) NOT NULL,
	[FKPerson] [int] NULL,
	[Done] [bit] NULL,
	[Note_Date] [datetime] NULL,
	[Note_Heading] [varchar](255) NULL,
	[Note_Detail] [varchar](max) NULL,
	[Followup_Date] [datetime] NULL,
	[Attachment] [varchar](max) NULL,
	[ReVisit] [datetime] NULL,
	[ReVisit_Reason] [varchar](max) NULL,
 CONSTRAINT [PK_contactPerson_History] PRIMARY KEY CLUSTERED 
(
	[IDPersonHistory] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[contactPerson]    Script Date: 10/01/2014 15:12:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[contactPerson](
	[IDPerson] [int] IDENTITY(1,1) NOT NULL,
	[ScreenName] [varchar](50) NULL,
	[PersonName] [varchar](100) NOT NULL,
	[PersonSurname] [varchar](200) NOT NULL,
	[PersonTitle] [int] NOT NULL,
	[PersonRole] [varchar](50) NULL,
	[Cell] [varchar](100) NULL,
	[Phone] [varchar](100) NULL,
	[Phone_Ext] [varchar](5) NULL,
	[eMail] [varchar](1000) NOT NULL,
	[FKKeyword] [int] NULL,
	[FKDepartment] [int] NOT NULL,
	[GIS_Location] [varchar](255) NULL,
	[FKIndustry] [varchar](255) NULL,
	[MarketProducts] [varchar](255) NULL,
	[FKAddress] [int] NOT NULL,
	[Comments] [varchar](max) NULL,
	[DateTimeStamp] [datetime] NULL,
	[Password] [varchar](100) NOT NULL,
	[FKSecurity] [int] NULL,
 CONSTRAINT [PK_ac_User] PRIMARY KEY CLUSTERED 
(
	[IDPerson] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[contactKeyword]    Script Date: 10/01/2014 15:12:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[contactKeyword](
	[IDKeyword] [int] IDENTITY(1,1) NOT NULL,
	[Keyword] [varchar](255) NULL,
 CONSTRAINT [PK_contactKeyword] PRIMARY KEY CLUSTERED 
(
	[IDKeyword] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ContactIndustry]    Script Date: 10/01/2014 15:12:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ContactIndustry](
	[IDIndustry] [int] IDENTITY(1,1) NOT NULL,
	[Industry] [varchar](max) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[contactDepartment]    Script Date: 10/01/2014 15:12:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[contactDepartment](
	[IDDepartment] [int] IDENTITY(1,1) NOT NULL,
	[FKSite] [int] NOT NULL,
	[Department] [varchar](255) NULL,
 CONSTRAINT [PK_contactDepartment] PRIMARY KEY CLUSTERED 
(
	[IDDepartment] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[contactCompany]    Script Date: 10/01/2014 15:12:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[contactCompany](
	[IDCompany] [int] IDENTITY(1,1) NOT NULL,
	[Company] [varchar](255) NULL,
	[FKIndustry] [int] NULL,
 CONSTRAINT [PK_contactCompany] PRIMARY KEY CLUSTERED 
(
	[IDCompany] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TEMP]    Script Date: 10/01/2014 15:12:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TEMP](
	[IDEventPerson] [int] IDENTITY(1,1) NOT NULL,
	[FKEvent] [int] NOT NULL,
	[FKPerson] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TeamZone]    Script Date: 10/01/2014 15:12:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TeamZone](
	[TeamZoneID] [int] NOT NULL,
	[TeamZone] [varchar](50) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblAddresses]    Script Date: 10/01/2014 15:12:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblAddresses](
	[AddressID] [int] IDENTITY(1,1) NOT NULL,
	[No] [int] NULL,
	[St] [varchar](50) NULL,
	[City] [varchar](50) NULL,
	[Zip] [varchar](50) NULL,
	[Country] [varchar](50) NULL,
	[lat] [float] NULL,
	[lng] [float] NULL,
 CONSTRAINT [PK_tblAddresses] PRIMARY KEY CLUSTERED 
(
	[AddressID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [AddrID] ON [dbo].[tblAddresses] 
(
	[AddressID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LeagueTeams]    Script Date: 10/01/2014 15:12:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LeagueTeams](
	[LTId] [int] NOT NULL,
	[TeamID] [int] NOT NULL,
	[LeagueID] [int] NOT NULL,
	[GameID] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[zDataSetAdapter_History]    Script Date: 10/01/2014 15:12:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[zDataSetAdapter_History](
	[DatabaseName] [varchar](100) NULL,
	[Id] [bigint] NOT NULL,
	[Action] [varchar](15) NULL,
	[DataTable] [varchar](50) NULL,
	[Heading] [varchar](300) NULL,
	[Detail] [varchar](3000) NULL,
	[Timer] [int] NULL,
	[TotalColumns] [int] NULL,
	[TotalRows] [int] NULL,
	[UserName] [varchar](100) NULL,
	[Type] [int] NULL,
	[DateTimeStamp] [datetime] NOT NULL,
	[SystemUser] [varchar](100) NULL,
	[PKField] [varchar](150) NULL,
	[PKValue] [varchar](1000) NULL,
 CONSTRAINT [PK_zDataSetAdapter_History] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[zDataSetAdapter]    Script Date: 10/01/2014 15:12:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[zDataSetAdapter](
	[Id] [bigint] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[Action] [varchar](15) NULL,
	[DataTable] [varchar](50) NULL,
	[Heading] [varchar](300) NULL,
	[Detail] [varchar](3000) NULL,
	[Timer] [int] NULL,
	[TotalColumns] [int] NULL,
	[TotalRows] [int] NULL,
	[UserName] [varchar](100) NULL,
	[Type] [int] NULL,
	[DateTimeStamp] [datetime] NOT NULL,
	[SystemUser] [varchar](100) NULL,
	[PKField] [varchar](150) NULL,
	[PKValue] [varchar](1000) NULL,
 CONSTRAINT [PK_zDataSetAdapter] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[UserType]    Script Date: 10/01/2014 15:12:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UserType](
	[UserTypeID] [int] NOT NULL,
	[UserType] [varchar](50) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[UpdateContactPersonSp]    Script Date: 10/01/2014 15:12:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UpdateContactPersonSp]
	-- Add the parameters for the stored procedure here
	@spTile int,
	@spScreenName varchar(max),
	@spUsername varchar(100),
	@spSurname varchar(200),
	@spEmail varchar(50),
	@spCell varchar(100),
	@spPhoneExt varchar(5),
	@spPhone varchar(100),
	@Password varchar(max),
	@CPass bit
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	IF @CPass = 1
	BEGIN
		UPDATE [dbo].[contactPerson] SET PersonTitle = @spTile,
										 PersonName = @spUsername,
										 PersonSurname = @spSurname,
										 eMail = @spEmail,
										 Cell = @spCell,
										 Phone_Ext = @spPhoneExt,
										 Phone = @spPhone,
										 Password = @Password
										 WHERE ScreenName = @spScreenName
	END
	ELSE
	BEGIN
		UPDATE [dbo].[contactPerson] SET PersonTitle = @spTile,
										 PersonName = @spUsername,
										 PersonSurname = @spSurname,
										 eMail = @spEmail,
										 Cell = @spCell,
										 Phone_Ext = @spPhoneExt,
										 Phone = @spPhone
										 WHERE ScreenName = @spScreenName
									 
	END
END
GO
/****** Object:  StoredProcedure [dbo].[UpdateContactPersonAdminSp]    Script Date: 10/01/2014 15:12:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[UpdateContactPersonAdminSp]
	-- Add the parameters for the stored procedure here
	@spTile int,
	@spScreenName varchar(max),
	@spUsername varchar(100),
	@spSurname varchar(200),
	@spEmail varchar(50),
	@spCell varchar(100),
	@spPhoneExt varchar(5),
	@spPhone varchar(100),
	@spRole varchar(50),
	@spDepartment int,
	@Password varchar(max),
	@CPass bit
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	IF @CPass = 1
	BEGIN
		UPDATE [dbo].[contactPerson] SET PersonTitle = @spTile,
										 PersonName = @spUsername,
										 PersonSurname = @spSurname,
										 eMail = @spEmail,
										 Cell = @spCell,
										 Phone_Ext = @spPhoneExt,
										 Phone = @spPhone,
										 PersonRole = @spRole,
										 FKDepartment = @spDepartment,
										 Password = @Password
										 WHERE ScreenName = @spScreenName
	END
	ELSE
	BEGIN
		UPDATE [dbo].[contactPerson] SET PersonTitle = @spTile,
										 PersonName = @spUsername,
										 PersonSurname = @spSurname,
										 eMail = @spEmail,
										 Cell = @spCell,
										 Phone_Ext = @spPhoneExt,
										 Phone = @spPhone,
										 PersonRole = @spRole,
										 FKDepartment = @spDepartment
										 WHERE ScreenName = @spScreenName
									 
	END
END
GO
/****** Object:  StoredProcedure [dbo].[UpdateAddrRerID_SP]    Script Date: 10/01/2014 15:12:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Stefan Olivier>
-- Create date: <04-12-2013>
-- Description:	<Add an user's address to the address table and return the largest address>
-- =============================================
CREATE PROCEDURE [dbo].[UpdateAddrRerID_SP]
	-- Add the parameters for the stored procedure here
	@ScreenNameSP varchar(max),
	@AddrNoSP int,
	@AddrStrSP varchar(max),
	@AddrCitySP varchar(max),
	@AddrZipSP varchar(max),
	@AddrCountrySP varchar(max)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    DECLARE @AddrToUSe varchar(max) = 
    (SELECT AddressID FROM contactPerson INNER JOIN tblAddresses
								 ON tblAddresses.AddressID = contactPerson.FKAddress
								 WHERE contactPerson.ScreenName = @ScreenNameSP)
    
    UPDATE [dbo].[tblAddresses] SET [No] = @AddrNoSP,
									St = @AddrStrSP,
									City = @AddrCitySP,
									Zip = @AddrZipSP,
									Country = @AddrCountrySP
								WHERE AddressID = @AddrToUSe						
    
END
GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateAddr]    Script Date: 10/01/2014 15:12:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Renato De Jesus>
-- Create date: <04-12-2013>
-- Description:	<Add an user's address to the address table and return the largest address>
-- =============================================
cREATE PROCEDURE [dbo].[sp_UpdateAddr]
	-- Add the parameters for the stored procedure here
	@AddressID int,
	@AddrNoSP int,
	@AddrStrSP varchar(max),
	@AddrCitySP varchar(max),
	@AddrZipSP varchar(max),
	@AddrCountrySP varchar(max)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE tblAddresses set No = @AddrNoSP,St =  @AddrStrSP,City = @AddrCitySP,Zip = @AddrZipSP,Country = @AddrCountrySP
	WHERE AddressID = @AddressID
END
GO
/****** Object:  Table [dbo].[AuditLog]    Script Date: 10/01/2014 15:12:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[AuditLog](
	[AuditID] [int] IDENTITY(1,1) NOT NULL,
	[FKUserID] [int] NOT NULL,
	[Action] [varchar](50) NOT NULL,
	[DateTime] [datetime] NULL,
 CONSTRAINT [PK_AuditLog] PRIMARY KEY CLUSTERED 
(
	[AuditID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[AddSite]    Script Date: 10/01/2014 15:12:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[AddSite]
@IND INT,
@Site VARCHAR(255)
AS
BEGIN
INSERT INTO contactSite(FKCompany,[Site])
VALUES(@IND,@Site)		
END
GO
/****** Object:  StoredProcedure [dbo].[AddProductSp]    Script Date: 10/01/2014 15:12:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[AddProductSp]
	-- Add the parameters for the stored procedure here
	@SpProduct varchar(max),
	@SpPrice decimal(18,2),
	@SpCompany int,
	@SpRating varchar(max) = NULL,
	@SpComments varchar(max) = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO Products (Product, Price, FKCompany) VALUES (@SpProduct, @SpPrice, @SpCompany)
END
GO
/****** Object:  StoredProcedure [dbo].[AddIndusrty]    Script Date: 10/01/2014 15:12:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[AddIndusrty]
	@Indusrty Varchar(255)
AS
BEGIN
	INSERT INTO ContactIndustry(Industry)
	VALUES(@Indusrty)
END
GO
/****** Object:  StoredProcedure [dbo].[AddDepartment]    Script Date: 10/01/2014 15:12:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[AddDepartment]
@IDS INT,
@Dept VARCHAR(255)
AS
BEGIN
INSERT INTO contactDepartment(FKSite,Department)
VALUES(@IDS,@Dept)		
END
GO
/****** Object:  StoredProcedure [dbo].[AddContactPersonSp]    Script Date: 10/01/2014 15:12:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Hendriks,Jano;Olivier Stefan>
-- Create date: <03-12-2013>
-- Description:	<Add a Person to the contactPerson table>
-- =============================================
CREATE PROCEDURE [dbo].[AddContactPersonSp]
	-- Add the parameters for the stored procedure here
	@spScreenName varchar(50),
	@spPersonName varchar(100),
	@spPersonSurname varchar(200),
	@speMail varchar(50),
	@spFKDepartment int = NULL,
	@spFKIndustry int = NULL,
	@spAddress int = NULL,
	@spPassword varchar(100),
	
	@spTitle varchar(50) = 'Mr',
	@spPRole varchar(50) = NULL,
	@spCell varchar(100) = NULL,
	@spPhone varchar(100) = NULL,
	@spPhone_Ext varchar(5) = NULL,
	@spFKKeyword int = NULL,
	
	@spIndustrySec varchar(255) = NULL,
	@spMarketProducts varchar(255) = NULL,
	
	@spGIS_Loc varchar(255) = NULL
	
	
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	--SET NOCOUNT ON;
    -- In program check should be done to determine whether the current user already exists or if there is a clash.
    -- Insert statements for procedure here
	INSERT INTO [contactASPDB].[dbo].[contactPerson] 
	(
		ScreenName,
		PersonName, 
		PersonSurname, 
		PersonTitle, 
		PersonRole, 
		Cell, 
		Phone, 
		Phone_Ext, 
		eMail, 
		FKKeyword, 
		FKDepartment,
		FKIndustry, 
		GIS_Location,  
		MarketProducts, 
		FKAddress,
		DateTimeStamp,
		[Password]
		) 
	VALUES 
	(
		@spScreenName,
		@spPersonName,
		@spPersonSurname,
		@spTitle,
		@spPRole,
		@spCell,
		@spPhone,
		@spPhone_Ext,
		@speMail,
		@spFKKeyword,
		@spFKDepartment,
		@spFKIndustry,
		@spGIS_Loc,
		@spMarketProducts,
		@spAddress,
		GETDATE(),
		@spPassword
	) 
END
GO
/****** Object:  StoredProcedure [dbo].[AddCompany]    Script Date: 10/01/2014 15:12:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[AddCompany]
@IND INT,
@COMP VARCHAR(255)
AS
BEGIN
INSERT INTO contactCompany(Company,FKIndustry)
VALUES(@COMP,@IND)		
END
GO
/****** Object:  StoredProcedure [dbo].[AddAddrRerID_SP]    Script Date: 10/01/2014 15:12:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Stefan Olivier>
-- Create date: <04-12-2013>
-- Description:	<Add an user's address to the address table and return the largest address>
-- =============================================
CREATE PROCEDURE [dbo].[AddAddrRerID_SP]
	-- Add the parameters for the stored procedure here
	@AddrNoSP int,
	@AddrStrSP varchar(max),
	@AddrCitySP varchar(max),
	@AddrZipSP varchar(max),
	@AddrCountrySP varchar(max)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    INSERT INTO tblAddresses ([No], St, City, Zip, Country) VALUES(@AddrNoSP, @AddrStrSP, @AddrCitySP, @AddrZipSP, @AddrCountrySP)
	SELECT TOP 1 AddressID, [No], St, City, Zip, Country FROM tblAddresses ORDER BY AddressID DESC
END
GO
/****** Object:  StoredProcedure [dbo].[SearchScreenNameSp]    Script Date: 10/01/2014 15:12:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Stefan Olivier
-- Create date: <04-12-2013>
-- Description:	<Finds a specific Screen Name>
-- =============================================
CREATE PROCEDURE [dbo].[SearchScreenNameSp]
	-- Add the parameters for the stored procedure here
	@ScreenNameSp varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT ScreenName,PersonTitle,PersonName, PersonSurname, eMail, Cell, Phone_Ext ,Phone, CS.FKCompany, CD.FKSite, CP.FKDepartment, PersonRole, TA.[No], TA.St, TA.City, TA.Zip, TA.Country, Keyword, FKAddress, IDPerson
									FROM [contactASPDB].[dbo].[contactPerson] CP
										INNER JOIN tblAddresses TA
											ON CP.FKAddress = TA.AddressID 
										INNER JOIN contactDepartment CD
											ON CD.IDDepartment = CP.FKDepartment
  										INNER JOIN contactSite CS
  											ON CS.IDSite = CD.FKSite
  										INNER JOIN contactCompany CC
  											ON CS.FKCompany = cc.IDCompany
  										INNER JOIN ContactIndustry CI 
  											ON CI.IDIndustry = CC.FKIndustry
  										INNER JOIN contactKeyword CK
											ON CK.IDKeyword = CP.FKKeyword
									WHERE CP.ScreenName = @ScreenNameSp
END
GO
/****** Object:  StoredProcedure [dbo].[SearchProductsSp]    Script Date: 10/01/2014 15:12:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SearchProductsSp]
	-- Add the parameters for the stored procedure here
	@SpSearch varchar(max),
	@SpCompany int = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    IF @SpCompany IS NULL
    BEGIN
		SELECT ProductID, Product, Company, Price, Barcode FROM Products PR
			INNER JOIN contactCompany CC
			ON IDCompany = FKCompany
			WHERE Product LIKE '%''' + @SpSearch + '''%'
    END
    ELSE
    BEGIN
		SELECT ProductID, Product, Company, Price, Barcode FROM Products PR
			INNER JOIN contactCompany CC
			ON IDCompany = FKCompany
			WHERE FKCompany = @SpCompany
			AND Product LIKE '%''' + @SpSearch + '''%'
			
	END
END
GO
/****** Object:  StoredProcedure [dbo].[sp_GetDepartments]    Script Date: 10/01/2014 15:12:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetDepartments]
	@Company varchar(255),
	@Site varchar(255),
	@Dep varchar(255)
AS
BEGIN
  SELECT cc.IDCompany,cc.Company,cs.IDSite,cs.Site,cd.IDDepartment,cd.Department  FROM [contactDepartment] cd
  INNER JOIN contactSite cs ON cs.IDSite = cd.FKSite and cs.Site = @Site
  INNER JOIN contactCompany CC ON cc.IDCompany = cs.FKCompany AND cc.Company = @Company
  WHERE cd.Department = @Dep
END
GO
/****** Object:  StoredProcedure [dbo].[sp_DeleteSite]    Script Date: 10/01/2014 15:12:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_DeleteSite]
@ID INT
AS
BEGIN
DELETE FROM contactSite WHERE IDSite = @ID
END
GO
/****** Object:  StoredProcedure [dbo].[sp_DeleteIndustry]    Script Date: 10/01/2014 15:12:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_DeleteIndustry]
@ID INT
AS
BEGIN
DELETE FROM ContactIndustry WHERE IDIndustry = @ID
END
GO
/****** Object:  StoredProcedure [dbo].[sp_DeleteDept]    Script Date: 10/01/2014 15:12:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_DeleteDept]
@ID INT
AS
BEGIN
DELETE FROM contactDepartment WHERE IDDepartment = @ID
END
GO
/****** Object:  StoredProcedure [dbo].[sp_DeleteCompany]    Script Date: 10/01/2014 15:12:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_DeleteCompany]
@ID INT
AS
BEGIN
DELETE FROM contactCompany WHERE IDCompany = @ID
END
GO
/****** Object:  StoredProcedure [dbo].[sp_TOP1PersonHistory]    Script Date: 10/01/2014 15:12:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Stefan Olivier>
-- Create date: <2013-12-19>
-- Description:	<Selects newest row in Person History>
-- =============================================
CREATE PROCEDURE [dbo].[sp_TOP1PersonHistory]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT TOP 1 * FROM contactPerson_History ORDER BY IDPersonHistory DESC
END
GO
/****** Object:  StoredProcedure [dbo].[sp_SendMessage]    Script Date: 10/01/2014 15:12:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_SendMessage]
	-- Add the parameters for the stored procedure here
	@Title varchar(50),
	@MessText varchar(max),
	@Username varchar(max) = NULL,
	@DEP int = NULL,
	@ImgURL varchar(max) = '~/Images/logo_small.jpg'
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	DECLARE @PERSON int
	
	SELECT @PERSON = IDPerson FROM contactPerson WHERE @Username = ScreenName
	
	INSERT INTO NewsFeed (Heading, [Message], DateCreated, FKPerson, FKDepartment, [Image])
	VALUES (@Title, @MessText, GETDATE(), @PERSON, @DEP, @ImgURL)
END
GO
/****** Object:  StoredProcedure [dbo].[sp_SearchExactPerson]    Script Date: 10/01/2014 15:12:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Hendriks, Jano;Olivier, Stefan>
-- Create date: <5/12/2013>
-- Description:	<SP to return the advanced search results for contacts>
-- =============================================
CREATE PROCEDURE [dbo].[sp_SearchExactPerson] 
	-- Add the parameters for the stored procedure here
	@Username varchar(max) = NULL,
	@Name varchar(max) = NULL,
	@Surname varchar(max) = NULL,
	@Keyword varchar(max) = '',
	@Filter varchar(max) = NULL,
	@ID INT
AS
BEGIN
DECLARE @SQL VARCHAR(MAX),
		@Flag BIT = 0,
		@KEYWORDS VARCHAR(MAX),
		@OP varchar(max) = 'OR'
		
SET @KEYWORDS =  @Keyword

SELECT IDKeyword
INTO #TEMP 
FROM contactKeyword
WHERE Keyword LIKE @KEYWORDS 

	IF @Keyword = ''
	BEGIN
		SET @OP = 'OR'
	END

	SET @SQL = '  SELECT 
      [ScreenName]
      ,[PersonName]
      ,[PersonSurname]
      ,[PersonTitle]
      ,[PersonRole]
      ,[Cell]
      ,[Phone]
      ,[eMail]
      ,CI.Industry
      ,CC.Company
      ,CD.Department
      ,CS.Site
      ,[DateTimeStamp]  
  FROM [contactASPDB].[dbo].[contactPerson] CP
  INNER JOIN contactDepartment CD 
  ON CD.IDDepartment = CP.FKDepartment
  INNER JOIN ContactIndustry CI 
  ON CI.IDIndustry = CP.FKIndustry
  INNER JOIN contactSite CS ON CS.IDSite = CD.FKSite
  INNER JOIN contactCompany CC ON CS.FKCompany = cc.IDCompany'
  
	
	IF @Filter = 'Site'
	BEGIN
		SET @SQL = @SQL + ' WHERE CS.IDSite = ' + CONVERT(VARCHAR(10),@ID)
							SET @Flag = 1
	END
		IF @Filter = 'Department'
	BEGIN
		SET @SQL = @SQL + ' WHERE CP.FKDepartment = '+ CONVERT(VARCHAR(10),@ID)
		SET @Flag = 1
	END
			IF @Filter = 'Industry'
	BEGIN
		SET @SQL = @SQL + '  WHERE CP.FKIndustry = '+ CONVERT(VARCHAR(10),@ID)
		SET @Flag = 1
	END
		IF @Flag = 1
		BEGIN
			
	
	SET @SQL = @SQL +' AND (CP.ScreenName = '+ @Username +
				   ' OR CP.PersonName = ' + @Name + 
                   ' OR CP.PersonSurname = ' + @Surname + 
                   ' ) ' + @OP + ' CP.FKKeyword IN (SELECT * FROM #TEMP)
                   (SELECT * FROM #TEMP)'
				 
		END
		ELSE
		BEGIN
		SET @SQL = @SQL +' WHERE (CP.ScreenName = '+ @Username +
				   ' OR CP.PersonName = ' + @Name + 
                   ' OR CP.PersonSurname = ' + @Surname + 
                   ') ' + @OP + ' CP.FKKeyword IN (SELECT * FROM #TEMP)'
        END
			print (@sql)
	EXEC(@SQL)
	
END
GO
/****** Object:  StoredProcedure [dbo].[sp_SearchAdvPerson]    Script Date: 10/01/2014 15:12:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<De Jesus, Renato>
-- Create date: <5/12/2013>
-- Description:	<SP to return the advanced search results for contacts>
-- =============================================
CREATE PROCEDURE [dbo].[sp_SearchAdvPerson] 
	-- Add the parameters for the stored procedure here
	@Username varchar(max) = NULL,
	@Name varchar(max) = NULL,
	@Surname varchar(max) = NULL,
	@Keyword varchar(max) = '',
	@Filter varchar(max) = NULL,
	@ID INT
AS
BEGIN
DECLARE @SQL VARCHAR(MAX),
		@Flag BIT = 0,
		@KEYWORDS VARCHAR(MAX),
		@OP varchar(max) = 'OR'
		
SET @KEYWORDS =  '%' + @Keyword +'%' 

SELECT IDKeyword
INTO #TEMP 
FROM contactKeyword
WHERE Keyword like @KEYWORDS 

	IF @Keyword = ''
	BEGIN
		SET @OP = 'AND'
	END

	SET @SQL = '  SELECT 
       [ScreenName]		as UserName
      ,[PersonName]		as [First Name]
      ,[PersonSurname]	as Surname
      ,[PersonTitle]	as Title
      ,[PersonRole]		as Role
      ,[Cell]			as [Cell No.]
      ,[Phone]			as [Tell No.]
      ,[eMail]			as [E-mail]
      ,CI.Industry
      ,CC.Company
      ,CD.Department
      ,CS.Site
  FROM [contactASPDB].[dbo].[contactPerson] CP
  INNER JOIN contactDepartment CD 
  ON CD.IDDepartment = CP.FKDepartment
  INNER JOIN contactIndustry CI 
  ON CI.IDIndustry = CP.FKIndustry
  INNER JOIN contactSite CS ON CS.IDSite = CD.FKSite
  INNER JOIN contactCompany CC ON CS.FKCompany = cc.IDCompany'
  
	
	IF @Filter = 'Site'
	BEGIN
		SET @SQL = @SQL + ' WHERE CS.IDSite = ' + CONVERT(VARCHAR(10),@ID)
							SET @Flag = 1
	END
		IF @Filter = 'Department'
	BEGIN
		SET @SQL = @SQL + ' WHERE CP.FKDepartment = '+ CONVERT(VARCHAR(10),@ID)
		SET @Flag = 1
	END
			IF @Filter = 'Industry'
	BEGIN
		SET @SQL = @SQL + '  WHERE CP.FKIndustry = '+ CONVERT(VARCHAR(10),@ID)
		SET @Flag = 1
	END
		IF @Flag = 1
		BEGIN
			
	
	SET @SQL = @SQL +' AND (CP.ScreenName LIKE '''+ @Username +
				   ''' OR CP.PersonName LIKE ''' + @Name + 
                   ''' OR CP.PersonSurname LIKE ''' + @Surname + 
                   ''' ) ' + @OP + ' CP.FKKeyword IN (SELECT * FROM #TEMP)'
				 
		END
		ELSE
		BEGIN
		SET @SQL = @SQL +' WHERE (CP.ScreenName LIKE '''+ @Username +
				   ''' OR CP.PersonName LIKE ''' + @Name + 
                   ''' OR CP.PersonSurname LIKE ''' + @Surname + 
                   ''') ' + @OP + ' CP.FKKeyword IN (SELECT * FROM #TEMP)'
        END
			print (@sql)
	EXEC(@SQL)
	
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Price]    Script Date: 10/01/2014 15:12:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_Price]
	@product int
AS
BEGIN
	SELECT Price FROM Products
	WHERE ProductID = @product
END
GO
/****** Object:  StoredProcedure [dbo].[sp_LoadIndustry]    Script Date: 10/01/2014 15:12:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_LoadIndustry]

AS
BEGIN
--DROP TABLE #TEMP
		CREATE TABLE #TEMP(
		ID [int] IDENTITY(1,1) NOT NULL,
		Industry VARCHAR(255),
		COMPANY VARCHAR(255),
		SITE VARCHAR(255),
		DEPARTMENT VARCHAR(255))
		
		INSERT INTO #TEMP(Industry,COMPANY,SITE,DEPARTMENT)
		SELECT Industry,CC.Company,CS.Site,CD.Department
		FROM ContactIndustry CI 
		LEFT JOIN contactCompany CC 
		ON CI.IDIndustry = CC.FkIndustry 
		LEFT JOIN contactSite CS 
		ON CS.FKCompany = CC.IDCompany 
		LEFT JOIN contactDepartment CD 
		ON CD.FKSite =CS.IDSite
		SELECT * FROM #TEMP
END

select * from ContactIndustry
GO
/****** Object:  StoredProcedure [dbo].[sp_LoadEventCompany]    Script Date: 10/01/2014 15:12:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_LoadEventCompany]
@IndID int 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	
	SELECT CS.IDCompany,CS.Company FROM contactCompany CS 
    WHERE @IndID = CS.FKIndustry
	
END
GO
/****** Object:  StoredProcedure [dbo].[sp_GetUserRatings]    Script Date: 10/01/2014 15:12:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Hendriks,Jano, Olivier, Stefan>
-- Create date: <19-12-13>
-- Description:	<Determines the avg values for Ratings for a person's Department and company>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetUserRatings]
	-- Add the parameters for the stored procedure here
	@UID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	DECLARE @DepCount int
			,@DepSum int
			,@CompCount int
			,@CompSum int
			,@DEP int
			,@COMP int
			--,@UID int = 3
			
	SELECT @DEP = FKDepartment FROM contactPerson WHERE IDPerson = @UID
	
	SELECT @COMP = CS.FKCompany FROM contactSite CS 
								INNER JOIN contactDepartment CD 
								 ON CD.FKSite = CS.IDSite
								WHERE CD.IDDepartment = @DEP
			
	SELECT @DepCount = COUNT(FKDepartment) FROM ProductRatings 
										   WHERE FKDepartment = @DEP
	
	SELECT @DepSum = SUM(Rating) FROM ProductRatings
								 WHERE FKDepartment = @DEP
	
	SELECT @CompCount = COUNT(PR.FKDepartment) FROM ProductRatings PR
											   INNER JOIN (SELECT * FROM contactCompany CC 
											     INNER JOIN contactSite CS
												  ON CS.FKCompany = CC.IDCompany 
												 INNER JOIN contactDepartment CD
												  ON CS.IDSite = CD.FKSite
												 WHERE CC.IDCompany = @COMP) AS TEMP 
											   ON TEMP.IDDepartment = PR.FKDepartment
	
	SELECT @CompSum = SUM(Rating) FROM ProductRatings PR
								  INNER JOIN (SELECT * FROM contactCompany CC 
									INNER JOIN contactSite CS 
									 ON CS.FKCompany = CC.IDCompany 
									INNER JOIN contactDepartment CD
									 ON CS.IDSite = CD.FKSite
									WHERE CC.IDCompany = @COMP) AS TEMP
								  ON TEMP.IDDepartment = PR.FKDepartment
	
	SELECT (@DepSum * 1.0 / @DepCount) * 10 AS [Department Average]
			,(@CompSum * 1.0 / @CompCount) * 10 AS [Company Average]
END
GO
/****** Object:  StoredProcedure [dbo].[sp_GetUserNews]    Script Date: 10/01/2014 15:12:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetUserNews]
	-- Add the parameters for the stored procedure here
	@ID INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @Dep INT
	
	SELECT @Dep = FKDepartment FROM contactPerson WHERE IDPerson = @ID

    -- Insert statements for procedure here
	SELECT [IDMessage]
      ,[Heading]
      ,[Message]
      ,[DateCreated]
      ,[Image]
      FROM NewsFeed WHERE (FKPerson = @ID
						OR FKDepartment = @Dep
						OR (FKPerson IS NULL
						AND FKDepartment IS NULL))
						ORDER BY DateCreated DESC
END
GO
/****** Object:  Table [dbo].[SetupLeague]    Script Date: 10/01/2014 15:12:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[SetupLeague](
	[LeagueID] [int] IDENTITY(1,1) NOT NULL,
	[LeagueName] [varchar](50) NULL,
	[NumberOfTeams] [int] NULL,
	[GamesAgainst] [int] NULL,
	[FKGameID] [int] NOT NULL,
 CONSTRAINT [PK_SetupLeague] PRIMARY KEY CLUSTERED 
(
	[LeagueID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[RateProductSp]    Script Date: 10/01/2014 15:12:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[RateProductSp]
	-- Add the parameters for the stored procedure here
	@SpProductID int,
	@SpRating int,
	@SpComment varchar(max) = NULL,
	@SpDepartment int = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
     INSERT INTO ProductRatings (FKProduct, Rating, Comments, FkDepartment) VALUES (@SpProductID, @SpRating,	@SpComment,	@SpDepartment)
     DECLARE @NUM INT,
			@rating INT,
			@Total INT
  
		SELECT @NUM =COUNT([FKProduct]) FROM [ProductRatings] WHERE FKProduct = @SpProductID
    
     SELECT @rating =SUM([Rating]) FROM [ProductRatings] WHERE FKProduct = @SpProductID
     SELECT @total =@rating / @NUM
     UPDATE Products SET Ave_Rating = @total WHERE @SpProductID = ProductID
     
	
END
GO
/****** Object:  StoredProcedure [dbo].[FilterDepartmentSp]    Script Date: 10/01/2014 15:12:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Stefan Olivier>
-- Create date: <04-12-2013>
-- Description:	<Gets the department and ID>
-- =============================================
CREATE PROCEDURE [dbo].[FilterDepartmentSp]
	-- Add the parameters for the stored procedure here
	@SiteID int = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    IF @SiteID IS NOT NULL
    BEGIN
    SELECT CD.IDDepartment, CD.Department FROM contactSite CS 
    INNER JOIN contactDepartment CD ON
    CS.IDSite = CD.FKSite
    WHERE @SiteID = CD.FKSite
    END
	ELSE BEGIN 
	SELECT IDDepartment, Department FROM contactDepartment
	END
	
END
GO
/****** Object:  StoredProcedure [dbo].[FilterCompanySp]    Script Date: 10/01/2014 15:12:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Stefan Olivier>
-- Create date: <04-12-2013>
-- Description:	<Gets the department and ID>
-- =============================================
Create PROCEDURE [dbo].[FilterCompanySp]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT IDCompany, Company FROM contactCompany
END
GO
/****** Object:  StoredProcedure [dbo].[FilterAllHistorySp]    Script Date: 10/01/2014 15:12:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Stefan Olivier>
-- Create date: <10-12-2013>
-- Description:	<Gives complete history of all users>
-- =============================================
CREATE PROCEDURE [dbo].[FilterAllHistorySp]
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT CP.[ScreenName]
      ,CP.[PersonName]
      ,CP.[PersonSurname]
      ,CC.Company
      ,CS.[Site]
      ,CI.[Industry]
      ,CD.[Department]
      ,CP.[PersonTitle]
      ,CP.[PersonRole]
      ,CP.[Cell]
      ,CP.[Phone]
      ,CP.[Phone_Ext]
      ,CP.[eMail]
      
      ,CP.[GIS_Location]
      ,CI.Industry
      ,CP.[MarketProducts]
      ,TA.St
      ,CP.[Comments]
      ,CP.[DateTimeStamp]
      ,CPH.[Done]
      ,CPH.[Note_Date]
      ,CPH.[Note_Heading]
      ,CPH.[Note_Detail]
      ,CPH.[Followup_Date]
      ,CPH.[Attachment]
      ,CPH.[ReVisit]
      ,CPH.[ReVisit_Reason]
        FROM contactPerson CP
		LEFT JOIN contactPerson_History CPH ON 
		CP.IDPerson = CPH.FKPerson
		INNER JOIN ContactIndustry CI ON
		CP.FKIndustry = CI.IDIndustry
		INNER JOIN contactDepartment CD ON
		CP.FKDepartment = CD.IDDepartment
		INNER JOIN tblAddresses TA ON
		CP.FKAddress = TA.AddressID
		INNER JOIN contactSite CS ON
		CD.FKSite = CS.IDSite
		INNER JOIN contactCompany CC ON
		CS.FKCompany = CC.IDCompany
END
GO
/****** Object:  Table [dbo].[Events]    Script Date: 10/01/2014 15:12:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Events](
	[IDEvent] [int] IDENTITY(1,1) NOT NULL,
	[TrackerNo] [int] NOT NULL,
	[FKIndustry] [int] NOT NULL,
	[FKCompany] [int] NOT NULL,
	[FKSite] [int] NOT NULL,
	[FKDepartment] [int] NOT NULL,
	[Heading] [varchar](100) NOT NULL,
	[FKProduct] [int] NOT NULL,
	[Offer_Value] [float] NOT NULL,
	[Client] [varchar](255) NULL,
	[Status] [varchar](255) NOT NULL,
	[Comment] [varchar](max) NULL,
	[Complete] [bit] NOT NULL,
 CONSTRAINT [PK_Events] PRIMARY KEY CLUSTERED 
(
	[IDEvent] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[EditSite]    Script Date: 10/01/2014 15:12:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[EditSite]
	@ID INT,
	@Name VARCHAR(255),
	@Flag BIT,
	@NID INT
AS
BEGIN
UPDATE contactSite
SET Site = @Name
WHERE IDSite = @ID

IF @Flag = 1
BEGIN
	UPDATE contactSite
	SET FKCompany = @NID
	WHERE IDSite = @ID
END
END
GO
/****** Object:  StoredProcedure [dbo].[EditIndustry]    Script Date: 10/01/2014 15:12:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[EditIndustry]
	@ID INT,
	@Name varchar(255)
AS
BEGIN
UPDATE ContactIndustry
SET Industry = @Name
WHERE IDIndustry = @ID
END
GO
/****** Object:  StoredProcedure [dbo].[EditDep]    Script Date: 10/01/2014 15:12:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[EditDep]
	@ID INT,
	@Name VARCHAR(255),
	@Flag BIT,
	@NID INT
AS
BEGIN
UPDATE contactDepartment
SET Department = @Name
WHERE IDDepartment = @ID

IF @Flag = 1
BEGIN
	UPDATE contactDepartment
	SET FKSite = @NID
	WHERE IDDepartment = @ID
END
END
GO
/****** Object:  StoredProcedure [dbo].[EditComapny]    Script Date: 10/01/2014 15:12:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[EditComapny]
	@ID INT,
	@Name VARCHAR(255),
	@Flag BIT,
	@NID INT
AS
BEGIN
UPDATE contactCompany
SET Company = @Name
WHERE IDCompany = @ID

IF @Flag = 1
BEGIN
	UPDATE contactCompany
	SET FKIndustry = @NID
	WHERE IDCompany = @ID
END
END
GO
/****** Object:  StoredProcedure [dbo].[PopulateKeywordSp]    Script Date: 10/01/2014 15:12:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Hendriks, Jano>
-- Create date: <12/9/2013>
-- Description:	<Populate [contactKeyword].[Keyword] with a list of default keyords.>
-- =============================================
CREATE PROCEDURE [dbo].[PopulateKeywordSp]
	-- Add the parameters for the stored procedure here
	@ScreenNameSp varchar(max)
	,@NewKeywordSp varchar(max)
AS
BEGIN
	DECLARE @KeywordList varchar(max) = ''
			,@ID int
			--,@ScreenNameSp varchar(max) = 'ereewr'
			--,@NewKeywordSp varchar(max) = N'asdf,sadf,sy,h'
	
	SET @ID = (SELECT IDPerson
	FROM contactPerson
	WHERE ScreenName = @ScreenNameSp)
	--print @ID
	DECLARE @FkKeyword int = (SELECT FKKeyword FROM contactPerson INNER JOIN contactKeyword ON IDKeyword = FKKeyword WHERE IDPerson = @ID)
	--print @FkKeyword
		SELECT Industry
			   ,Company
			   ,[Site]
			   ,Department
			   ,[PersonRole]
		INTO #TEMPDATA
		FROM [contactASPDB].[dbo].[contactPerson] CP
			 INNER JOIN contactDepartment CD 
				ON CD.IDDepartment = CP.FKDepartment
			 INNER JOIN ContactIndustry CI 
				ON CI.IDIndustry = CP.FKIndustry
			 INNER JOIN contactSite CS 
				ON CS.IDSite = CD.FKSite
			 INNER JOIN contactCompany CC 
				ON CS.FKCompany = CC.IDCompany
			WHERE CP.IDPerson = CONVERT(int, @ID)
			
			--drop table #TEMPDATA
						
		SET @KeywordList = (SELECT Industry FROM #TEMPDATA) + ',' + (SELECT Company FROM #TEMPDATA) + ',' + (SELECT [Site] FROM #TEMPDATA)
						+ ',' + (SELECT Department FROM #TEMPDATA)
		----print @KeywordList				
		DECLARE @Role varchar(max)
		SET @Role = (SELECT [PersonRole] FROM #TEMPDATA)
		----print @KeywordList
		IF @Role IS NOT NULL
		BEGIN
			SET @KeywordList = @KeywordList + ',' + @Role
		END
	
	IF (SELECT IDKeyword FROM contactKeyword INNER JOIN contactPerson ON IDKeyword = FKKeyword WHERE IDPerson = @ID) IS NULL
	 BEGIN
	 ----print 'IsNull'
		INSERT INTO contactKeyword (Keyword) VALUES (@KeywordList)
		DECLARE @FKKeyTemp int = (SELECT TOP 1 IDKeyword FROM contactKeyword ORDER BY IDKeyword DESC)
		UPDATE contactPerson 
		SET FKKeyword = @FKKeyTemp
		WHERE ScreenName = @ScreenNameSp
		--print @FKKeyTemp
		--print @ScreenNameSp
		--print @KeywordList
	 END
	ELSE
	 BEGIN
	 --print 'Update'
		UPDATE contactKeyword
		SET Keyword = @KeywordList
		WHERE @FkKeyword = IDKeyword
		--print @KeywordList
	 END
		
	--DECLARE @ID int = 4,
	--	@NewKeywordSp  varchar(max) = N'dom,snaaks,vergeetagtig',
	--	@KeywordList varchar(max) = ''
	--	DECLARE @FkKeyword int = (SELECT FKKeyword FROM contactPerson INNER JOIN contactKeyword ON IDKeyword = FKKeyword WHERE IDPerson = @ID)
	----print @ID
	----print @NewKeywordSp
	----print @FkKeyword
	
	IF @NewKeywordSp IS NOT NULL
	BEGIN
	--print 'Extra Keywords'
	--print @KeywordList
		SET @KeywordList = (SELECT Keyword FROM contactPerson INNER JOIN contactKeyword ON IDKeyword = FKKeyword WHERE IDPerson = @ID)
							+ ',' + @NewKeywordSp
								
		UPDATE contactKeyword
		SET Keyword = @KeywordList
		WHERE IDKeyword = @FkKeyword
	END
	
END
GO
/****** Object:  StoredProcedure [dbo].[PersonLoginSP]    Script Date: 10/01/2014 15:12:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[PersonLoginSP] 
	-- Add the parameters for the stored procedure here
	@username varchar(50),
	@password varchar (100)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT ScreenName FROM contactPerson WHERE ScreenName = @username AND Password = @password
END
GO
/****** Object:  StoredProcedure [dbo].[PersonLogin_HistorySp]    Script Date: 10/01/2014 15:12:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[PersonLogin_HistorySp]
	-- Add the parameters for the stored procedure here
	@spFKEvent int = NULL,
	@spStatus varchar(255) = 'Invalid User'
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO [contactASPDB].[dbo].[EventPerson_History]
	(
		[FKEvent],
		[Status_Date],
		[Status],
		[Followup_Date],
		[Done]
	)
	VALUES
	(
		@spFKEvent,
		GETDATE(),
		@spStatus,
		NULL,
		0
	)
		
		
END
GO
/****** Object:  StoredProcedure [dbo].[FilterProductsSp]    Script Date: 10/01/2014 15:12:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[FilterProductsSp]
	-- Add the parameters for the stored procedure here
	@SpCompany int = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    IF @SpCompany IS NULL
    BEGIN
		SELECT ProductID, Product, Company, Price, Barcode, Ave_Rating FROM Products PR
			INNER JOIN contactCompany CC
			ON IDCompany = FKCompany
    END
    ELSE
    BEGIN
		SELECT ProductID, Product, Company, Price, Barcode, Ave_Rating FROM Products PR
			INNER JOIN contactCompany CC
			ON IDCompany = FKCompany
			WHERE FKCompany = @SpCompany
			
	END
END
GO
/****** Object:  StoredProcedure [dbo].[FilterPHistorySp]    Script Date: 10/01/2014 15:12:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Stefan Olivier>
-- Create date: <05-12-2013>
-- Description:	<Gives complete history of a user>
-- =============================================
CREATE PROCEDURE [dbo].[FilterPHistorySp]
	-- Add the parameters for the stored procedure here
	@ScreenName varchar(max) = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT CP.[ScreenName]
      ,CP.[PersonName]
      ,CP.[PersonSurname]
      ,CC.Company
      ,CS.[Site]
      ,CI.[Industry]
      ,CD.[Department]
      ,CP.[PersonTitle]
      ,CP.[PersonRole]
      ,CP.[Cell]
      ,CP.[Phone]
      ,CP.[Phone_Ext]
      ,CP.[eMail]
      
      ,CP.[GIS_Location]
      ,CI.Industry
      ,CP.[MarketProducts]
      ,TA.St
      ,CP.[Comments]
      ,CP.[DateTimeStamp]
      ,CPH.[Done]
      ,CPH.[Note_Date]
      ,CPH.[Note_Heading]
      ,CPH.[Note_Detail]
      ,CPH.[Followup_Date]
      ,CPH.[Attachment]
      ,CPH.[ReVisit]
      ,CPH.[ReVisit_Reason]
        FROM contactPerson CP
		LEFT JOIN contactPerson_History CPH ON 
		CP.IDPerson = CPH.FKPerson
		INNER JOIN ContactIndustry CI ON
		CP.FKIndustry = CI.IDIndustry
		INNER JOIN contactDepartment CD ON
		CP.FKDepartment = CD.IDDepartment
		INNER JOIN tblAddresses TA ON
		CP.FKAddress = TA.AddressID
		INNER JOIN contactSite CS ON
		CD.FKSite = CS.IDSite
		INNER JOIN contactCompany CC ON
		CS.FKCompany = CC.IDCompany
		WHERE CP.ScreenName = @ScreenName
END
GO
/****** Object:  StoredProcedure [dbo].[FilterPersonAliasesSp]    Script Date: 10/01/2014 15:12:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE  [dbo].[FilterPersonAliasesSp]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	SELECT * INTO #TEMPTABLE FROM
	(SELECT IDPerson, ScreenName, ScreenName as Names
	FROM contactPerson
	UNION SELECT IDPerson, ScreenName,PersonName  as Names
	FROM contactPerson
	UNION SELECT IDPerson, ScreenName, PersonSurname  as Names
	FROM contactPerson) AS NameTable
	
	SELECT * from #TEMPTABLE	
END
GO
/****** Object:  StoredProcedure [dbo].[FilterIndustrySp]    Script Date: 10/01/2014 15:12:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[FilterIndustrySp]
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT IDIndustry, Industry FROM contactIndustry
END
GO
/****** Object:  StoredProcedure [dbo].[FilterTitleSp]    Script Date: 10/01/2014 15:12:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[FilterTitleSp] 

AS
BEGIN
	SELECT TitleID, Title FROM ContactTitle
END
GO
/****** Object:  StoredProcedure [dbo].[FilterSiteSp]    Script Date: 10/01/2014 15:12:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[FilterSiteSp]
	-- Add the parameters for the stored procedure here
	@CompanyID int = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    IF @CompanyID is NULL
    BEGIN
    SELECT IDSite,[Site] FROM contactSite
    END
	ELSE BEGIN 
	SELECT IDSite,[Site] FROM contactSite CS 
    INNER JOIN contactCompany CC ON
    CS.FKCompany = CC.IDCompany 
    WHERE @CompanyID = CC.IDCompany
	END
END
GO
/****** Object:  Table [dbo].[Fixtures]    Script Date: 10/01/2014 15:12:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Fixtures](
	[FixtureID] [int] IDENTITY(1,1) NOT NULL,
	[HomeTeamID] [int] NULL,
	[AwayTeamID] [int] NULL,
	[DateTime] [varchar](50) NULL,
	[LeagueID] [int] NULL,
 CONSTRAINT [PK_Fixtures] PRIMARY KEY CLUSTERED 
(
	[FixtureID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[FilterIDsSp]    Script Date: 10/01/2014 15:12:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[FilterIDsSp]
	-- Add the parameters for the stored procedure here
	@EventID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SELECT CI.IDIndustry, CC.IDCompany, CS.IDSite, CD.IDDepartment
		   FROM Events EV
		   INNER JOIN contactDepartment CD
			ON CD.IDDepartment = EV.FKDepartment
		   INNER JOIN contactSite CS
			ON CS.IDSite = EV.FKSite
		   INNER JOIN contactCompany CC
		    ON CC.IDCompany = EV.FKCompany
		   INNER JOIN ContactIndustry CI
		    ON CI.IDIndustry = EV.FKIndustry
		   WHERE EV.IDEvent = @EventID
			
END
GO
/****** Object:  Table [dbo].[EventPerson]    Script Date: 10/01/2014 15:12:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EventPerson](
	[IDEventPerson] [int] IDENTITY(1,1) NOT NULL,
	[FKEvent] [int] NOT NULL,
	[FKPerson] [int] NOT NULL,
 CONSTRAINT [PK_EventPerson] PRIMARY KEY CLUSTERED 
(
	[IDEventPerson] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[News]    Script Date: 10/01/2014 15:12:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[News](
	[NewsID] [int] IDENTITY(1,1) NOT NULL,
	[Publisher] [varchar](50) NOT NULL,
	[Header] [varchar](100) NOT NULL,
	[Content] [varchar](1000) NOT NULL,
	[LeagueID] [int] NOT NULL,
 CONSTRAINT [PK_News] PRIMARY KEY CLUSTERED 
(
	[NewsID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateEvent]    Script Date: 10/01/2014 15:12:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Jano Hendriks>
-- Create date: <Create Date,,>
-- Description:	<Based on Sp_AddEvent>
Create PROCEDURE [dbo].[sp_UpdateEvent]
	@ID INT,
	@IND INT,
	@COMP INT,
	@SITE INT,
	@DEP INT,
	@Heading VARCHAR(255),
	@Prod INT,
	@Offer FLOAT,
	@Client VARCHAR(255),
	@Comment VARCHAR(Max),
	@Done BIT
	
AS
BEGIN

	UPDATE Events SET [FKIndustry] = @IND,
					  [FKCompany] = @COMP,
					  [FKSite] = @SITE,
					  [FKDepartment] = @DEP,
					  [Heading] = @Heading,
					  [FKProduct] = @Prod,
					  [Offer_Value] = @Offer,
					  [Client] = @Client,
					  [Comment] = @Comment,
					  [Complete] = @Done
				  WHERE  IDEvent = @ID
				  
	IF @Done = 1
	 BEGIN
		UPDATE Events SET [Status] = 'Complete'
				  WHERE  IDEvent = @ID
	 END
	ELSE
	 BEGIN
		UPDATE Events SET [Status] = 'In Progress'
				  WHERE  IDEvent = @ID
	 END
END
GO
/****** Object:  StoredProcedure [dbo].[sp_AddEvent]    Script Date: 10/01/2014 15:12:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_AddEvent]
	@IND INT,
	@COMP INT,
	@SITE INT,
	@DEP INT,
	@Heading VARCHAR(255),
	@Prod INT,
	@Offer FLOAT,
	@Client VARCHAR(255),
	@Comment VARCHAR(Max)
	
AS
BEGIN
	DECLARE @Track INT
	SELECT @Track = MAX(IDEvent) + 1 FROM Events
	IF @Track IS NULL
	BEGIN
		SET @Track = 1
	END
	INSERT INTO Events([TrackerNo],[FKIndustry],[FKCompany],[FKSite],[FKDepartment],[Heading],[FKProduct],[Offer_Value],[Client],[Status],[Comment],[Complete])
		VALUES(@Track,@IND,@COMP,@SITE,@DEP,@Heading,@Prod,@Offer,@Client,'New',@Comment,0)
END
GO
/****** Object:  StoredProcedure [dbo].[sp_TrackNO]    Script Date: 10/01/2014 15:12:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_TrackNO]
AS
BEGIN
	SELECT TOP 1 [IDEvent],TrackerNo FROM Events ORDER BY [IDEvent] DESC
END
GO
/****** Object:  Table [dbo].[LeagueLog]    Script Date: 10/01/2014 15:12:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LeagueLog](
	[LogID] [int] IDENTITY(1,1) NOT NULL,
	[FKLeagueID] [int] NOT NULL,
	[FKTeamID] [int] NOT NULL,
	[Wins] [int] NOT NULL,
	[Draws] [int] NOT NULL,
	[Loses] [int] NOT NULL,
	[Points] [int] NOT NULL,
 CONSTRAINT [PK_LeagueLog] PRIMARY KEY CLUSTERED 
(
	[LogID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateEventPerson]    Script Date: 10/01/2014 15:12:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_UpdateEventPerson]
	@Event INT,
	@Screen VARCHAR(255)
	
AS
BEGIN
	DECLARE @UID INT,
	@EIP INT
	
	SELECT @UID = IDPerson FROM contactPerson WHERE ScreenName = @Screen
	
	SELECT * INTO TEMP FROM EventPerson WHERE FKEvent = @Event AND FKPerson = @UID
	
	SELECT @EIP = [IDEventPerson] FROM TEMP
	IF @EIP IS NOT NULL
	BEGIN
		UPDATE EventPerson SET FKEvent = @Event ,[FKPerson] = @UID
		WHERE IDEventPerson = @EIP
	END 
	ELSE
	BEGIN
		INSERT INTO EventPerson(FKEvent,[FKPerson])
		VALUES(@Event,@UID)
	END
END
GO
/****** Object:  StoredProcedure [dbo].[sp_GetUserEvents]    Script Date: 10/01/2014 15:12:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetUserEvents]
	-- Add the parameters for the stored procedure here
	@scrName varchar(max),
	@TOP5 BIT = 0
AS
BEGIN
	DECLARE @UID INT
	
	SELECT @UID = [IDPerson] FROM contactPerson WHERE ScreenName = @scrName
	
	IF @TOP5 = 1
	 BEGIN
		SELECT TOP 5 IDEvent
			   ,Heading
			   ,Status
			   ,Complete
			   ,Client
			   ,CI.Industry
			   ,CC.Company
			   ,CD.Department
			   ,CS.Site
			   ,Comment
			   ,PR.Product
			   ,Offer_Value as [Offer Value] 
			   ,TrackerNo as [Tracker No]
		  FROM [contactASPDB].[dbo].[Events] CP
		  INNER JOIN ContactIndustry CI
			ON CI.IDIndustry = CP.FKIndustry
		  INNER JOIN contactDepartment CD 
			ON CD.IDDepartment = CP.FKDepartment
		  INNER JOIN contactSite CS
			ON CS.IDSite = CD.FKSite
		  INNER JOIN contactCompany CC
			ON CS.FKCompany = cc.IDCompany
		  INNER JOIN Products PR ON CP.FKProduct = PR.ProductID
		  LEFT JOIN EventPerson EP ON EP.FKEvent = CP.IDEvent
		  LEFT JOIN contactPerson PP ON PP.IDPerson = EP.FKPerson
		  WHERE EP.FKPerson = @UID ORDER BY [IDEvent] DESC
	 END
	ELSE
	 BEGIN
		SELECT IDEvent
			   ,Heading
			   ,Status
			   ,Complete
			   ,Client
			   ,CI.Industry
			   ,CC.Company
			   ,CD.Department
			   ,CS.Site
			   ,Comment
			   ,PR.Product
			   ,Offer_Value as [Offer Value] 
			   ,TrackerNo as [Tracker No]
		  FROM [contactASPDB].[dbo].[Events] CP
		  INNER JOIN ContactIndustry CI
			ON CI.IDIndustry = CP.FKIndustry
		  INNER JOIN contactDepartment CD 
			ON CD.IDDepartment = CP.FKDepartment
		  INNER JOIN contactSite CS
			ON CS.IDSite = CD.FKSite
		  INNER JOIN contactCompany CC
			ON CS.FKCompany = cc.IDCompany
		  INNER JOIN Products PR ON CP.FKProduct = PR.ProductID
		  LEFT JOIN EventPerson EP ON EP.FKEvent = CP.IDEvent
		  LEFT JOIN contactPerson PP ON PP.IDPerson = EP.FKPerson
		  WHERE EP.FKPerson = @UID
	 END
END
GO
/****** Object:  StoredProcedure [dbo].[sp_AddEventPerson]    Script Date: 10/01/2014 15:12:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_AddEventPerson]
	@Event INT,
	@Screen VARCHAR(255)
	
AS
BEGIN
	DECLARE @UID INT
	
	SELECT @UID = IDPerson FROM contactPerson WHERE ScreenName = @Screen
	
	INSERT INTO EventPerson(FKEvent,[FKPerson])
		VALUES(@Event,@UID)
END
GO
/****** Object:  Default [DF_zDataSetAdapter_DateTimeStamp]    Script Date: 10/01/2014 15:12:27 ******/
ALTER TABLE [dbo].[zDataSetAdapter] ADD  CONSTRAINT [DF_zDataSetAdapter_DateTimeStamp]  DEFAULT (getdate()) FOR [DateTimeStamp]
GO
/****** Object:  ForeignKey [FK__AuditLog__FKUser__3C34F16F]    Script Date: 10/01/2014 15:12:27 ******/
ALTER TABLE [dbo].[AuditLog]  WITH CHECK ADD FOREIGN KEY([FKUserID])
REFERENCES [dbo].[SetupUser] ([IDUser])
GO
/****** Object:  ForeignKey [FK__SetupLeag__FKGam__236943A5]    Script Date: 10/01/2014 15:12:27 ******/
ALTER TABLE [dbo].[SetupLeague]  WITH CHECK ADD FOREIGN KEY([FKGameID])
REFERENCES [dbo].[SetupGame] ([GameID])
GO
/****** Object:  ForeignKey [FK__Fixtures__AwayTe__45BE5BA9]    Script Date: 10/01/2014 15:12:27 ******/
ALTER TABLE [dbo].[Fixtures]  WITH CHECK ADD FOREIGN KEY([AwayTeamID])
REFERENCES [dbo].[SetupTeams] ([TeamID])
GO
/****** Object:  ForeignKey [FK__Fixtures__HomeTe__43D61337]    Script Date: 10/01/2014 15:12:27 ******/
ALTER TABLE [dbo].[Fixtures]  WITH CHECK ADD FOREIGN KEY([HomeTeamID])
REFERENCES [dbo].[SetupTeams] ([TeamID])
GO
/****** Object:  ForeignKey [FK__Fixtures__League__44CA3770]    Script Date: 10/01/2014 15:12:27 ******/
ALTER TABLE [dbo].[Fixtures]  WITH CHECK ADD FOREIGN KEY([LeagueID])
REFERENCES [dbo].[SetupLeague] ([LeagueID])
GO
/****** Object:  ForeignKey [FK__News__LeagueID__2BFE89A6]    Script Date: 10/01/2014 15:12:27 ******/
ALTER TABLE [dbo].[News]  WITH CHECK ADD FOREIGN KEY([LeagueID])
REFERENCES [dbo].[SetupLeague] ([LeagueID])
GO
/****** Object:  ForeignKey [FK__LeagueLog__FKLea__31B762FC]    Script Date: 10/01/2014 15:12:27 ******/
ALTER TABLE [dbo].[LeagueLog]  WITH CHECK ADD FOREIGN KEY([FKLeagueID])
REFERENCES [dbo].[SetupLeague] ([LeagueID])
GO
/****** Object:  ForeignKey [FK__LeagueLog__FKTea__32AB8735]    Script Date: 10/01/2014 15:12:27 ******/
ALTER TABLE [dbo].[LeagueLog]  WITH CHECK ADD FOREIGN KEY([FKTeamID])
REFERENCES [dbo].[SetupTeams] ([TeamID])
GO
