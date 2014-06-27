USE [master]
GO
/****** Object:  Database [Esports]    Script Date: 06/27/2014 04:02:33 ******/
CREATE DATABASE [Esports] ON  PRIMARY 
( NAME = N'Esports', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\DATA\Esports.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Esports_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\DATA\Esports_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [Esports] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Esports].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Esports] SET ANSI_NULL_DEFAULT OFF
GO
ALTER DATABASE [Esports] SET ANSI_NULLS OFF
GO
ALTER DATABASE [Esports] SET ANSI_PADDING OFF
GO
ALTER DATABASE [Esports] SET ANSI_WARNINGS OFF
GO
ALTER DATABASE [Esports] SET ARITHABORT OFF
GO
ALTER DATABASE [Esports] SET AUTO_CLOSE OFF
GO
ALTER DATABASE [Esports] SET AUTO_CREATE_STATISTICS ON
GO
ALTER DATABASE [Esports] SET AUTO_SHRINK OFF
GO
ALTER DATABASE [Esports] SET AUTO_UPDATE_STATISTICS ON
GO
ALTER DATABASE [Esports] SET CURSOR_CLOSE_ON_COMMIT OFF
GO
ALTER DATABASE [Esports] SET CURSOR_DEFAULT  GLOBAL
GO
ALTER DATABASE [Esports] SET CONCAT_NULL_YIELDS_NULL OFF
GO
ALTER DATABASE [Esports] SET NUMERIC_ROUNDABORT OFF
GO
ALTER DATABASE [Esports] SET QUOTED_IDENTIFIER OFF
GO
ALTER DATABASE [Esports] SET RECURSIVE_TRIGGERS OFF
GO
ALTER DATABASE [Esports] SET  DISABLE_BROKER
GO
ALTER DATABASE [Esports] SET AUTO_UPDATE_STATISTICS_ASYNC OFF
GO
ALTER DATABASE [Esports] SET DATE_CORRELATION_OPTIMIZATION OFF
GO
ALTER DATABASE [Esports] SET TRUSTWORTHY OFF
GO
ALTER DATABASE [Esports] SET ALLOW_SNAPSHOT_ISOLATION OFF
GO
ALTER DATABASE [Esports] SET PARAMETERIZATION SIMPLE
GO
ALTER DATABASE [Esports] SET READ_COMMITTED_SNAPSHOT OFF
GO
ALTER DATABASE [Esports] SET HONOR_BROKER_PRIORITY OFF
GO
ALTER DATABASE [Esports] SET  READ_WRITE
GO
ALTER DATABASE [Esports] SET RECOVERY FULL
GO
ALTER DATABASE [Esports] SET  MULTI_USER
GO
ALTER DATABASE [Esports] SET PAGE_VERIFY CHECKSUM
GO
ALTER DATABASE [Esports] SET DB_CHAINING OFF
GO
EXEC sys.sp_db_vardecimal_storage_format N'Esports', N'ON'
GO
USE [Esports]
GO
/****** Object:  Table [dbo].[SetupGame]    Script Date: 06/27/2014 04:02:36 ******/
DROP TABLE [dbo].[SetupGame]
GO
/****** Object:  Table [dbo].[SetupLeague]    Script Date: 06/27/2014 04:02:35 ******/
DROP TABLE [dbo].[SetupLeague]
GO
/****** Object:  Table [dbo].[SetupMapGames]    Script Date: 06/27/2014 04:02:35 ******/
DROP TABLE [dbo].[SetupMapGames]
GO
/****** Object:  Table [dbo].[SetupMapUserTeams]    Script Date: 06/27/2014 04:02:35 ******/
DROP TABLE [dbo].[SetupMapUserTeams]
GO
/****** Object:  Table [dbo].[SetupTeams]    Script Date: 06/27/2014 04:02:35 ******/
DROP TABLE [dbo].[SetupTeams]
GO
/****** Object:  Table [dbo].[SetupUser]    Script Date: 06/27/2014 04:02:35 ******/
DROP TABLE [dbo].[SetupUser]
GO
/****** Object:  Table [dbo].[SetupUser]    Script Date: 06/27/2014 04:02:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
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
