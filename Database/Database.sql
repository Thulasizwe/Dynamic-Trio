USE [Esports]
GO
/****** Object:  Table [dbo].[SetupUser]    Script Date: 07/23/2014 23:44:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[SetupUser](
	[IDUser] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [varchar](50) NOT NULL,
	[FirstName] [varchar](50) NULL,
	[Surname] [varchar](100) NULL,
	[Email] [varchar](200) NULL,
	[Cell] [varchar](10) NULL,
	[FKUserType] [int] NULL,
	[UserPassword] [varchar](1024) NULL,
	[UserStatus] [varchar](50) NULL,
	 CONSTRAINT [PK_setupUser] PRIMARY KEY CLUSTERED 
(
	[IDUser] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SetupTeams]    Script Date: 07/23/2014 23:44:08 ******/
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
/****** Object:  Table [dbo].[SetupMapUserTeams]    Script Date: 07/23/2014 23:44:08 ******/
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
/****** Object:  Table [dbo].[SetupMapGames]    Script Date: 07/23/2014 23:44:08 ******/
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
/****** Object:  Table [dbo].[SetupLeague]    Script Date: 07/23/2014 23:44:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SetupLeague](
	[LeagueID] [int] IDENTITY(1,1) NOT NULL,
	[LeagueName] [varchar](50) NULL,
	[FKGameID] [nchar](10) NOT NULL,
 CONSTRAINT [PK_SetupLeague] PRIMARY KEY CLUSTERED 
(
	[LeagueID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SetupGame]    Script Date: 07/23/2014 23:44:08 ******/
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
	[GameDescription] [varchar](max) NULL,
 CONSTRAINT [PK_SetupGame] PRIMARY KEY CLUSTERED 
(
	[GameID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Results]    Script Date: 07/23/2014 23:44:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[Results](
	[ResultID] [int] IDENTITY(1,1) NOT NULL,
	[HomeTeam] [varchar](50) NULL,
	[AwayTeam] [varchar](50) NULL,
	[FKLeagueID] [varchar](50) NULL,
	[FirstScore] [varchar](4) NOT NULL,
	[SecondScore] [varchar](4) NOT NULL,
	[FKGameID] [varchar](50) NULL,
	[Confirmed] [varchar](50) NULL,
	[ResultPath] [varchar](100) NOT NULL,
	PRIMARY KEY (ResultID)
	
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[News]    Script Date: 07/23/2014 23:44:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[News](
	[NewsID] [int] IDENTITY(1,1) NOT NULL,
	[Publisher] [varchar](50) NOT NULL,
	[Header] [varchar](100) NOT NULL,
	[Content] [varchar](1000) NOT NULL,
	[LeagueID] [int] NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[LeagueTeams]    Script Date: 07/23/2014 23:44:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LeagueTeams](
	[LTId] [int] IDENTITY(1,1) NOT NULL,
	[TeamID] [int] NOT NULL,
	[LeagueID] [int] NOT NULL,
	[GameID] [int] NOT NULL
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[TeamZone](
	[TeamZoneID] [int] IDENTITY(1,1) NOT NULL,
	[TeamZone] [varchar](50) NULL
	
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Fixtures](
	[FixtureID] [int] IDENTITY(1,1) NOT NULL,
	[HomeTeam] [varchar](50) NULL,
	[AwayTeam] [varchar](50) NULL,
	[DateTime] [varchar](50) NULL,
	
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[UserType]
(
	[UserTypeID][int] IDENTITY (1,1) NOT NULL,
	[UserType] [varchar] (50) NULL
) ON [PRIMARY]
GO
/****** Object:  ForeignKey [FK__LeagueTea__GameI__1A14E395]    Script Date: 07/23/2014 23:44:08 ******/
ALTER TABLE [dbo].[LeagueTeams]  WITH CHECK ADD FOREIGN KEY([GameID])
REFERENCES [dbo].[SetupGame] ([GameID])
GO
/****** Object:  ForeignKey [FK__LeagueTea__Leagu__1920BF5C]    Script Date: 07/23/2014 23:44:08 ******/
ALTER TABLE [dbo].[LeagueTeams]  WITH CHECK ADD FOREIGN KEY([LeagueID])
REFERENCES [dbo].[SetupLeague] ([LeagueID])
GO
/****** Object:  ForeignKey [FK__LeagueTea__TeamI__182C9B23]    Script Date: 07/23/2014 23:44:08 ******/
ALTER TABLE [dbo].[LeagueTeams]  WITH CHECK ADD FOREIGN KEY([TeamID])
REFERENCES [dbo].[SetupTeams] ([TeamID])
GO
/****** Object:  ForeignKey [FK__News__LeagueID__1BFD2C07]    Script Date: 07/23/2014 23:44:08 ******/
ALTER TABLE [dbo].[News]  WITH CHECK ADD FOREIGN KEY([LeagueID])
REFERENCES [dbo].[SetupLeague] ([LeagueID])
GO
