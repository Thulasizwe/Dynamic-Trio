USE master
GO

CREATE DATABASE Esports GO

CREATE TABLE [dbo].[SetupUser](
	[IDUser] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [varchar](50) NOT NULL,
	[FirstName] [varchar](50) NULL,
	[Surname] [varchar](100) NULL,
	[Email] [varchar](200) NULL,
	[Cell] [varchar](10) NULL,
	[ViewAll] [bit] NULL,
	[ModifyAll] [bit] NULL,
	[Password] [varbinary](1024) NULL,
	[Disabled] [bit] NULL,
 CONSTRAINT [PK_setupUser] PRIMARY KEY CLUSTERED 
(
	[IDUser] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SetupTeams]    Script Date: 06/27/2014 04:02:35 ******/
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
	[TeamZone] [varchar](50) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SetupMapUserTeams]    Script Date: 06/27/2014 04:02:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SetupMapUserTeams](
	[IDTeamUsersMap] [int] IDENTITY(1,1) NOT NULL,
	[FKUserID] [int] NULL,
	[FKTeamID] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SetupMapGames]    Script Date: 06/27/2014 04:02:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SetupMapGames](
	[IDMapGames] [int] IDENTITY(1,1) NOT NULL,
	[FKLeagueID] [int] NOT NULL,
	[FKGameID] [int] NOT NULL,
	[NextMatchDate] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SetupLeague]    Script Date: 06/27/2014 04:02:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SetupLeague](
	[LeagueID] [int] IDENTITY(1,1) NOT NULL,
	[LeagueName] [varchar](50) NULL,
	[FKTeamID] [int] NOT NULL,
	[Score] [int] NOT NULL,
	[FKGameID] [nchar](10) NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SetupGame]    Script Date: 06/27/2014 04:02:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SetupGame](
	[GameID] [int] IDENTITY(1,1) NOT NULL,
	[GameName] [varchar](50) NULL,
	[PointsPerGAme] [varchar](50) NULL,
	[GameDescription] [varbinary](max) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
