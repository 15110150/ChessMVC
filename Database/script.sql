USE [master]
GO
/****** Object:  Database [ChessResultDB]    Script Date: 09/20/2019 16:37:32 ******/
CREATE DATABASE [ChessResultDB] ON  PRIMARY 
( NAME = N'ChessResultDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\DATA\ChessResultDB.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'ChessResultDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\DATA\ChessResultDB_log.ldf' , SIZE = 5184KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [ChessResultDB] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ChessResultDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ChessResultDB] SET ANSI_NULL_DEFAULT OFF
GO
ALTER DATABASE [ChessResultDB] SET ANSI_NULLS OFF
GO
ALTER DATABASE [ChessResultDB] SET ANSI_PADDING OFF
GO
ALTER DATABASE [ChessResultDB] SET ANSI_WARNINGS OFF
GO
ALTER DATABASE [ChessResultDB] SET ARITHABORT OFF
GO
ALTER DATABASE [ChessResultDB] SET AUTO_CLOSE OFF
GO
ALTER DATABASE [ChessResultDB] SET AUTO_CREATE_STATISTICS ON
GO
ALTER DATABASE [ChessResultDB] SET AUTO_SHRINK OFF
GO
ALTER DATABASE [ChessResultDB] SET AUTO_UPDATE_STATISTICS ON
GO
ALTER DATABASE [ChessResultDB] SET CURSOR_CLOSE_ON_COMMIT OFF
GO
ALTER DATABASE [ChessResultDB] SET CURSOR_DEFAULT  GLOBAL
GO
ALTER DATABASE [ChessResultDB] SET CONCAT_NULL_YIELDS_NULL OFF
GO
ALTER DATABASE [ChessResultDB] SET NUMERIC_ROUNDABORT OFF
GO
ALTER DATABASE [ChessResultDB] SET QUOTED_IDENTIFIER OFF
GO
ALTER DATABASE [ChessResultDB] SET RECURSIVE_TRIGGERS OFF
GO
ALTER DATABASE [ChessResultDB] SET  DISABLE_BROKER
GO
ALTER DATABASE [ChessResultDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF
GO
ALTER DATABASE [ChessResultDB] SET DATE_CORRELATION_OPTIMIZATION OFF
GO
ALTER DATABASE [ChessResultDB] SET TRUSTWORTHY OFF
GO
ALTER DATABASE [ChessResultDB] SET ALLOW_SNAPSHOT_ISOLATION OFF
GO
ALTER DATABASE [ChessResultDB] SET PARAMETERIZATION SIMPLE
GO
ALTER DATABASE [ChessResultDB] SET READ_COMMITTED_SNAPSHOT OFF
GO
ALTER DATABASE [ChessResultDB] SET HONOR_BROKER_PRIORITY OFF
GO
ALTER DATABASE [ChessResultDB] SET  READ_WRITE
GO
ALTER DATABASE [ChessResultDB] SET RECOVERY FULL
GO
ALTER DATABASE [ChessResultDB] SET  MULTI_USER
GO
ALTER DATABASE [ChessResultDB] SET PAGE_VERIFY CHECKSUM
GO
ALTER DATABASE [ChessResultDB] SET DB_CHAINING OFF
GO
EXEC sys.sp_db_vardecimal_storage_format N'ChessResultDB', N'ON'
GO
USE [ChessResultDB]
GO
/****** Object:  User [vikute]    Script Date: 09/20/2019 16:37:32 ******/
CREATE USER [vikute] FOR LOGIN [vikute] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  Table [dbo].[Round]    Script Date: 09/20/2019 16:37:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Round](
	[ID] [int] NOT NULL,
	[Name] [nchar](10) NULL,
	[Description] [nchar](10) NULL,
 CONSTRAINT [PK_Round] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Round] ([ID], [Name], [Description]) VALUES (1, N'Round1    ', NULL)
INSERT [dbo].[Round] ([ID], [Name], [Description]) VALUES (2, N'Round2    ', NULL)
INSERT [dbo].[Round] ([ID], [Name], [Description]) VALUES (3, N'Round3    ', NULL)
INSERT [dbo].[Round] ([ID], [Name], [Description]) VALUES (4, N'Round4    ', NULL)
INSERT [dbo].[Round] ([ID], [Name], [Description]) VALUES (5, N'Round5    ', NULL)
INSERT [dbo].[Round] ([ID], [Name], [Description]) VALUES (6, N'Round6    ', NULL)
INSERT [dbo].[Round] ([ID], [Name], [Description]) VALUES (7, N'Round7    ', NULL)
/****** Object:  StoredProcedure [dbo].[TournamentManagement_SearchTournament]    Script Date: 09/20/2019 16:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE  [dbo].[TournamentManagement_SearchTournament]
	@Name				NVARCHAR(250)		= '',
	@StartDate			DATETIME			= NULL,
	@FederationID		INT					= 0
AS
BEGIN
	DECLARE @SQL    NVARCHAR(MAX) = N''
	DECLARE @Select NVARCHAR(MAX) = N'	SELECT Tournament.TournamentID,
										Tournament.Name,
										Tournament.Organizer,
										Tournament.Director,
										Tournament.Location,
										Tournament.StartDate,
										Tournament.EndDate,
										Tournament.UpdateDate,
										Federation.FederationID, 
										Federation.Name, 
										Federation.Acronym, 
										Federation.Flag '
	DECLARE @From   NVARCHAR(MAX) = N'	FROM Tournament LEFT JOIN Federation ON Tournament.FederationID = Federation.FederationID' 
	DECLARE @Where  NVARCHAR(MAX) = N'	WHERE '
	SET @Name = '''%' + @Name + '%'''
	SET @StartDate = CAST(@StartDate AS DATE)
IF @StartDate IS NULL
    Begin
    	
		IF  @FederationID = 0
			Begin
				SET @Where = @Where + 'Tournament.Name LIKE ' + @Name
			End
		ELSE
			BEGIN
				SET @Where = @Where + 'Tournament.Name LIKE ' + @Name + ' AND Tournament.FederationID = ' + CAST(@FederationID AS NVARCHAR(100))
			END
    End

ELSE
    Begin
		IF  @FederationID = 0
			Begin
				SET @Where = @Where + '	Tournament.Name LIKE ' + @Name + ' AND Tournament.StartDate >= ''' + CONVERT(NVARCHAR(10), @StartDate, 101) + ''''
			End
		ELSE
			BEGIN
			SET @Where = @Where + ' Tournament.Name LIKE ' + @Name  +
							  ' AND Tournament.FederationID = ' + CAST(@FederationID AS NVARCHAR(100)) +
							  ' AND Tournament.StartDate >= ''' + CONVERT(NVARCHAR(10), @StartDate, 101) + ''''
			END
    End

Set @SQL = @Select + @From + @Where

EXECUTE sp_executesql @sql

END
GO
/****** Object:  Table [dbo].[Role]    Script Date: 09/20/2019 16:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Role](
	[ID] [int] NOT NULL,
	[Name] [varchar](100) NULL,
	[Description] [varchar](max) NULL,
 CONSTRAINT [PK_Role] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[Role] ([ID], [Name], [Description]) VALUES (1, N'admin', NULL)
INSERT [dbo].[Role] ([ID], [Name], [Description]) VALUES (2, N'user', NULL)
/****** Object:  Table [dbo].[Federation]    Script Date: 09/20/2019 16:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Federation](
	[FederationID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](100) NULL,
	[Flag] [varchar](255) NULL,
	[Acronym] [varchar](50) NULL,
 CONSTRAINT [PK_National] PRIMARY KEY CLUSTERED 
(
	[FederationID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[Federation] ON
INSERT [dbo].[Federation] ([FederationID], [Name], [Flag], [Acronym]) VALUES (1, N'Argentina', N'Argentina.png', N'ARG')
INSERT [dbo].[Federation] ([FederationID], [Name], [Flag], [Acronym]) VALUES (2, N'Brazil', N'Brazil.png', N'BRA')
INSERT [dbo].[Federation] ([FederationID], [Name], [Flag], [Acronym]) VALUES (3, N'Vietnam', N'Vietnam.png', N'VIE')
INSERT [dbo].[Federation] ([FederationID], [Name], [Flag], [Acronym]) VALUES (4, N'Laos', N'Laos.png', N'LAO')
INSERT [dbo].[Federation] ([FederationID], [Name], [Flag], [Acronym]) VALUES (5, N'Albania', N'Albania.png', N'ALB')
INSERT [dbo].[Federation] ([FederationID], [Name], [Flag], [Acronym]) VALUES (6, N'Angola', N'Angola.png', N'ANG')
INSERT [dbo].[Federation] ([FederationID], [Name], [Flag], [Acronym]) VALUES (7, N'Australia', N'Australia.png', N'AUS')
INSERT [dbo].[Federation] ([FederationID], [Name], [Flag], [Acronym]) VALUES (8, N'Bangladesh', N'Bangladesh.png', N'BLA')
INSERT [dbo].[Federation] ([FederationID], [Name], [Flag], [Acronym]) VALUES (9, N'Belgium', N'Belgium.png', N'BEL')
INSERT [dbo].[Federation] ([FederationID], [Name], [Flag], [Acronym]) VALUES (10, N'Bolivia', N'Bolivia.png', N'BOL')
INSERT [dbo].[Federation] ([FederationID], [Name], [Flag], [Acronym]) VALUES (11, N'Brunei', N'Brunei.png', N'BRU')
INSERT [dbo].[Federation] ([FederationID], [Name], [Flag], [Acronym]) VALUES (12, N'Cambodia', N'Cambodia.png', N'CAM')
INSERT [dbo].[Federation] ([FederationID], [Name], [Flag], [Acronym]) VALUES (13, N'Canada', N'Canada.png', N'CND')
INSERT [dbo].[Federation] ([FederationID], [Name], [Flag], [Acronym]) VALUES (14, N'Chile', N'Chile.png', N'CHI')
INSERT [dbo].[Federation] ([FederationID], [Name], [Flag], [Acronym]) VALUES (15, N'China', N'China.png', N'CHA')
INSERT [dbo].[Federation] ([FederationID], [Name], [Flag], [Acronym]) VALUES (16, N'Colombia', N'Colombia.png', N'COL')
INSERT [dbo].[Federation] ([FederationID], [Name], [Flag], [Acronym]) VALUES (17, N'South-Africa', N'South-Africa.png', N'SOA')
INSERT [dbo].[Federation] ([FederationID], [Name], [Flag], [Acronym]) VALUES (18, N'Iran', N'Iran.png', N'IRA')
INSERT [dbo].[Federation] ([FederationID], [Name], [Flag], [Acronym]) VALUES (19, N'Japan', N'Japan.png', N'JPA')
INSERT [dbo].[Federation] ([FederationID], [Name], [Flag], [Acronym]) VALUES (20, N'Croatia', N'Croatia.png', N'CRO')
INSERT [dbo].[Federation] ([FederationID], [Name], [Flag], [Acronym]) VALUES (21, N'Egypt', N'Egypt.png', N'EGY')
INSERT [dbo].[Federation] ([FederationID], [Name], [Flag], [Acronym]) VALUES (22, N'France', N'France.png', N'FRA')
INSERT [dbo].[Federation] ([FederationID], [Name], [Flag], [Acronym]) VALUES (23, N'Germany', N'Germany.png', N'GRE')
INSERT [dbo].[Federation] ([FederationID], [Name], [Flag], [Acronym]) VALUES (24, N'Ghana', N'Ghana.png', N'GHA')
INSERT [dbo].[Federation] ([FederationID], [Name], [Flag], [Acronym]) VALUES (25, N'India', N'India.png', N'IND')
INSERT [dbo].[Federation] ([FederationID], [Name], [Flag], [Acronym]) VALUES (26, N'Malaysia', N'Malaysia.png', N'MAL')
INSERT [dbo].[Federation] ([FederationID], [Name], [Flag], [Acronym]) VALUES (27, N'Mexico', N'Mexico.png', N'MEX')
INSERT [dbo].[Federation] ([FederationID], [Name], [Flag], [Acronym]) VALUES (28, N'Mozambique', N'Mozambique.png', N'MOZ')
INSERT [dbo].[Federation] ([FederationID], [Name], [Flag], [Acronym]) VALUES (29, N'New-Zealand', N'New-Zealand.png', N'NEZ')
INSERT [dbo].[Federation] ([FederationID], [Name], [Flag], [Acronym]) VALUES (30, N'Palestine', N'Palestine.png', N'PAL')
INSERT [dbo].[Federation] ([FederationID], [Name], [Flag], [Acronym]) VALUES (31, N'Peru', N'Peru.png', N'PERU')
INSERT [dbo].[Federation] ([FederationID], [Name], [Flag], [Acronym]) VALUES (32, N'Switzerland', N'Switzerland.png', N'SWI')
INSERT [dbo].[Federation] ([FederationID], [Name], [Flag], [Acronym]) VALUES (33, N'United-Kingdom', N'United-Kingdom.png', N'UK')
INSERT [dbo].[Federation] ([FederationID], [Name], [Flag], [Acronym]) VALUES (34, N'Russia', N'Russia.png', N'RUS')
INSERT [dbo].[Federation] ([FederationID], [Name], [Flag], [Acronym]) VALUES (35, N'Georgia', N'Georgia.png', N'GEO')
INSERT [dbo].[Federation] ([FederationID], [Name], [Flag], [Acronym]) VALUES (36, N'Poland', N'Poland.png', N'POL')
SET IDENTITY_INSERT [dbo].[Federation] OFF
/****** Object:  Table [dbo].[Group]    Script Date: 09/20/2019 16:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Group](
	[ID] [int] NOT NULL,
	[Name] [nchar](10) NULL,
	[Desciption] [varchar](max) NULL,
 CONSTRAINT [PK_Group] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[Group] ([ID], [Name], [Desciption]) VALUES (1, N'Standard  ', NULL)
INSERT [dbo].[Group] ([ID], [Name], [Desciption]) VALUES (2, N'Blitz     ', NULL)
INSERT [dbo].[Group] ([ID], [Name], [Desciption]) VALUES (3, N'Rapid     ', NULL)
/****** Object:  Table [dbo].[Form]    Script Date: 09/20/2019 16:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Form](
	[ID] [int] NOT NULL,
	[Name] [nvarchar](100) NULL,
	[MaxAge] [int] NULL,
	[Description] [nvarchar](max) NULL,
 CONSTRAINT [PK_Form] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Form] ([ID], [Name], [MaxAge], [Description]) VALUES (1, N'U10', 10, NULL)
INSERT [dbo].[Form] ([ID], [Name], [MaxAge], [Description]) VALUES (2, N'U12', 12, NULL)
INSERT [dbo].[Form] ([ID], [Name], [MaxAge], [Description]) VALUES (3, N'U14', 14, NULL)
INSERT [dbo].[Form] ([ID], [Name], [MaxAge], [Description]) VALUES (4, N'U16', 16, NULL)
INSERT [dbo].[Form] ([ID], [Name], [MaxAge], [Description]) VALUES (5, N'U18', 18, NULL)
INSERT [dbo].[Form] ([ID], [Name], [MaxAge], [Description]) VALUES (6, N'U20', 20, NULL)
/****** Object:  StoredProcedure [dbo].[FederationManagement_GetFederationByID]    Script Date: 09/20/2019 16:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FederationManagement_GetFederationByID] 
	@ID		INT		= 0
AS
BEGIN
	SET		NOCOUNT ON
	SELECT	Federation.FederationID, 
			Federation.Name, 
			Federation.Acronym, 
			Federation.Flag
	FROM	Federation 
	WHERE	Federation.FederationID = @ID;
END
GO
/****** Object:  StoredProcedure [dbo].[FederationManagement_GetAllFederation]    Script Date: 09/20/2019 16:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FederationManagement_GetAllFederation] 
AS
BEGIN
	SET		NOCOUNT ON
	SELECT	Federation.FederationID, 
			Federation.Name, 
			Federation.Acronym, 
			Federation.Flag		
	FROM	Federation
END
GO
/****** Object:  StoredProcedure [dbo].[FederationManagement_DeleteFederation]    Script Date: 09/20/2019 16:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FederationManagement_DeleteFederation]
	@ID				INT					= 0
AS
BEGIN
	DELETE	FROM	Federation
	WHERE			FederationID = @ID
END
GO
/****** Object:  StoredProcedure [dbo].[FederationManagement_CreateFederation]    Script Date: 09/20/2019 16:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FederationManagement_CreateFederation]
	@Name			VARCHAR(100)		= NULL,
	@Flag			VARCHAR(255)		= NULL,
	@Acronym		VARCHAR(50)			= NULL
AS
BEGIN
	INSERT INTO		Federation
					(Name,
					Flag,
					Acronym)
		   VALUES	(@Name,
					@Flag,
					@Acronym)
END
GO
/****** Object:  Table [dbo].[Tournament]    Script Date: 09/20/2019 16:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tournament](
	[TournamentID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](250) NOT NULL,
	[FederationID] [int] NOT NULL,
	[Description] [nvarchar](max) NULL,
	[StartDate] [datetime] NOT NULL,
	[EndDate] [datetime] NOT NULL,
	[Winner] [int] NULL,
	[CreatedDate] [date] NULL,
	[UpdateDate] [date] NULL,
	[Status] [bit] NULL,
	[Organizer] [nvarchar](250) NULL,
	[Director] [nvarchar](250) NULL,
	[Location] [nvarchar](500) NULL,
	[ParentTourID] [int] NULL,
	[FormID] [int] NULL,
 CONSTRAINT [PK_Tournament] PRIMARY KEY CLUSTERED 
(
	[TournamentID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Tournament] ON
INSERT [dbo].[Tournament] ([TournamentID], [Name], [FederationID], [Description], [StartDate], [EndDate], [Winner], [CreatedDate], [UpdateDate], [Status], [Organizer], [Director], [Location], [ParentTourID], [FormID]) VALUES (1, N'COPA LBX SUL DE MINAS - ETAPA CAXAMBU - Blitz Feminino B', 25, N'tour new', CAST(0x0000A9D000000000 AS DateTime), CAST(0x0000AAE100000000 AS DateTime), NULL, NULL, NULL, NULL, N'Chess Federation of Sri Lanka', N'Wijesuriya, G. Luxman', N'Citrus Hotel, Waskaduwa, Sri Lanka', NULL, NULL)
INSERT [dbo].[Tournament] ([TournamentID], [Name], [FederationID], [Description], [StartDate], [EndDate], [Winner], [CreatedDate], [UpdateDate], [Status], [Organizer], [Director], [Location], [ParentTourID], [FormID]) VALUES (2, N'2019 Etienne Lewis Trials ', 25, NULL, CAST(0x0000A9D000000000 AS DateTime), CAST(0x0000AB1E00000000 AS DateTime), NULL, NULL, NULL, NULL, N'SUB COMISION DE TORNEOS CNSG', N'DR. OSCAR FERNANDEZ', N'CLUB V.MAIAKOVSKI - RODRIGUEZ PEÑA 26 - BERNAL', NULL, NULL)
INSERT [dbo].[Tournament] ([TournamentID], [Name], [FederationID], [Description], [StartDate], [EndDate], [Winner], [CreatedDate], [UpdateDate], [Status], [Organizer], [Director], [Location], [ParentTourID], [FormID]) VALUES (3, N'Giải cờ vua đường đến đỉnh vinh quang mở rộng lần 2', 3, NULL, CAST(0x0000A9EF00000000 AS DateTime), CAST(0x0000AB0000000000 AS DateTime), NULL, NULL, NULL, NULL, N'chess HN', N'Nguyen Van Hau', N'Hai Ba Trung', NULL, NULL)
INSERT [dbo].[Tournament] ([TournamentID], [Name], [FederationID], [Description], [StartDate], [EndDate], [Winner], [CreatedDate], [UpdateDate], [Status], [Organizer], [Director], [Location], [ParentTourID], [FormID]) VALUES (4, N'	Western Asian Youth & Junior Chess Championship-2019 (U20O)', 25, NULL, CAST(0x0000AABB00000000 AS DateTime), CAST(0x0000AAC900000000 AS DateTime), NULL, NULL, NULL, NULL, N'Delhi Chess Association', N'IA Ajeet Kumar Verma', N'	HOTEL TIVOLI GRAND RESORT, NEW DELHI', NULL, NULL)
INSERT [dbo].[Tournament] ([TournamentID], [Name], [FederationID], [Description], [StartDate], [EndDate], [Winner], [CreatedDate], [UpdateDate], [Status], [Organizer], [Director], [Location], [ParentTourID], [FormID]) VALUES (5, N'Western Asian Youth & Junior Chess Championship-2019 (U6G)', 25, NULL, CAST(0x0000AABB00000000 AS DateTime), CAST(0x0000AAC900000000 AS DateTime), NULL, NULL, NULL, NULL, N'Delhi Chess Association', N'IA Ajeet Kumar Verma', N'HOTEL TIVOLI GRAND RESORT, NEW DELHI', NULL, NULL)
INSERT [dbo].[Tournament] ([TournamentID], [Name], [FederationID], [Description], [StartDate], [EndDate], [Winner], [CreatedDate], [UpdateDate], [Status], [Organizer], [Director], [Location], [ParentTourID], [FormID]) VALUES (6, N'Arbëria Open 2019 Blitz', 13, NULL, CAST(0x0000AAB900000000 AS DateTime), CAST(0x0000AABF00000000 AS DateTime), NULL, NULL, NULL, NULL, N'Arbëria Vjenë', N'Anton Marku', N'Haus des Schachsports, Marathonweg 14, 1020 Wien', NULL, NULL)
INSERT [dbo].[Tournament] ([TournamentID], [Name], [FederationID], [Description], [StartDate], [EndDate], [Winner], [CreatedDate], [UpdateDate], [Status], [Organizer], [Director], [Location], [ParentTourID], [FormID]) VALUES (7, N'Chess Championship of Gilan Province U(12) 1398', 18, NULL, CAST(0x0000AAB600000000 AS DateTime), CAST(0x0000AACE00000000 AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Tournament] ([TournamentID], [Name], [FederationID], [Description], [StartDate], [EndDate], [Winner], [CreatedDate], [UpdateDate], [Status], [Organizer], [Director], [Location], [ParentTourID], [FormID]) VALUES (8, N'Спартакиада ГУ ФСИН 2019г.', 34, NULL, CAST(0x0000AABB00000000 AS DateTime), CAST(0x0000AAC900000000 AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Tournament] ([TournamentID], [Name], [FederationID], [Description], [StartDate], [EndDate], [Winner], [CreatedDate], [UpdateDate], [Status], [Organizer], [Director], [Location], [ParentTourID], [FormID]) VALUES (9, N'Maia Cup (Open-C, Rapid, U-12) 2019', 35, NULL, CAST(0x0000AABD00000000 AS DateTime), CAST(0x0000AACE00000000 AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Tournament] ([TournamentID], [Name], [FederationID], [Description], [StartDate], [EndDate], [Winner], [CreatedDate], [UpdateDate], [Status], [Organizer], [Director], [Location], [ParentTourID], [FormID]) VALUES (10, N'Berdsk Cup Open 2019 Blitz, Stage 4 - Maestro Day. Открытый кубок Бердска 2019 по блицу, этап 4 - День Маэстро', 34, NULL, CAST(0x0000AABD00000000 AS DateTime), CAST(0x0000AABD00000000 AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Tournament] ([TournamentID], [Name], [FederationID], [Description], [StartDate], [EndDate], [Winner], [CreatedDate], [UpdateDate], [Status], [Organizer], [Director], [Location], [ParentTourID], [FormID]) VALUES (11, N'8th International Maria Trafalska Chess Memorial', 36, NULL, CAST(0x0000AAB600000000 AS DateTime), CAST(0x0000AAC000000000 AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Tournament] ([TournamentID], [Name], [FederationID], [Description], [StartDate], [EndDate], [Winner], [CreatedDate], [UpdateDate], [Status], [Organizer], [Director], [Location], [ParentTourID], [FormID]) VALUES (12, N'Campeonato Brasileiro de Xadrez Blitz 2019 - Campina Grande/PB - 14 e 15/09/2019', 2, NULL, CAST(0x0000AAC000000000 AS DateTime), CAST(0x0000AACE00000000 AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Tournament] ([TournamentID], [Name], [FederationID], [Description], [StartDate], [EndDate], [Winner], [CreatedDate], [UpdateDate], [Status], [Organizer], [Director], [Location], [ParentTourID], [FormID]) VALUES (13, N'Torneo Abierto de Ajedrez Rápido Sub 2.000 Liga de Ajedrez del Atlántico', 2, NULL, CAST(0x0000AABF00000000 AS DateTime), CAST(0x0000AACD00000000 AS DateTime), NULL, NULL, NULL, NULL, N'Federação Paraibana de Xadrez', N'Fernando Melo', N'Hotel Littoral - Joao Pessoa/PB', NULL, NULL)
INSERT [dbo].[Tournament] ([TournamentID], [Name], [FederationID], [Description], [StartDate], [EndDate], [Winner], [CreatedDate], [UpdateDate], [Status], [Organizer], [Director], [Location], [ParentTourID], [FormID]) VALUES (14, N'Circuito Escolar Xeque&Mate / Le2 - Etapa 3 ', 2, NULL, CAST(0x0000AABC00000000 AS DateTime), CAST(0x0000AACE00000000 AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Tournament] ([TournamentID], [Name], [FederationID], [Description], [StartDate], [EndDate], [Winner], [CreatedDate], [UpdateDate], [Status], [Organizer], [Director], [Location], [ParentTourID], [FormID]) VALUES (15, N'Circuito Escolar Xeque&Mate / Le2 - Etapa 3 - Sub 10', 2, NULL, CAST(0x0000AABC00000000 AS DateTime), CAST(0x0000AACE00000000 AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, 14, 1)
INSERT [dbo].[Tournament] ([TournamentID], [Name], [FederationID], [Description], [StartDate], [EndDate], [Winner], [CreatedDate], [UpdateDate], [Status], [Organizer], [Director], [Location], [ParentTourID], [FormID]) VALUES (16, N'Circuito Escolar Xeque&Mate / Le2 - Etapa 3 - Sub 12', 2, NULL, CAST(0x0000AABC00000000 AS DateTime), CAST(0x0000AACE00000000 AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, 14, 2)
INSERT [dbo].[Tournament] ([TournamentID], [Name], [FederationID], [Description], [StartDate], [EndDate], [Winner], [CreatedDate], [UpdateDate], [Status], [Organizer], [Director], [Location], [ParentTourID], [FormID]) VALUES (17, N'Circuito Escolar Xeque&Mate / Le2 - Etapa 3 - Sub 14', 2, NULL, CAST(0x0000AABC00000000 AS DateTime), CAST(0x0000AACE00000000 AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, 14, 3)
INSERT [dbo].[Tournament] ([TournamentID], [Name], [FederationID], [Description], [StartDate], [EndDate], [Winner], [CreatedDate], [UpdateDate], [Status], [Organizer], [Director], [Location], [ParentTourID], [FormID]) VALUES (18, N'Circuito Escolar Xeque&Mate / Le2 - Etapa 3 - Sub 16', 2, NULL, CAST(0x0000AABC00000000 AS DateTime), CAST(0x0000AACE00000000 AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, 14, 4)
INSERT [dbo].[Tournament] ([TournamentID], [Name], [FederationID], [Description], [StartDate], [EndDate], [Winner], [CreatedDate], [UpdateDate], [Status], [Organizer], [Director], [Location], [ParentTourID], [FormID]) VALUES (19, N'(Respaldo) IRT sub 1600 Club Circulo de Obrero', 1, NULL, CAST(0x0000AABB00000000 AS DateTime), CAST(0x0000AAC900000000 AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Tournament] ([TournamentID], [Name], [FederationID], [Description], [StartDate], [EndDate], [Winner], [CreatedDate], [UpdateDate], [Status], [Organizer], [Director], [Location], [ParentTourID], [FormID]) VALUES (20, N'Hurry up- 1st Lakecity International Open GM Rapid Chess Tournament 2019 at ​Lakecity,14-15 Sep.,9414812453,9413045606,9461389344,Prize 4 lac & Trophy', 25, NULL, CAST(0x0000AABB00000000 AS DateTime), CAST(0x0000AAC900000000 AS DateTime), NULL, NULL, NULL, NULL, N'Chess In Lakecity', N'Shri Rajeev Bharadwaj', N'ORBIT RESORT, NEW BHOPALPURA, NEAR MIRAJ MALAHAR, RK CIRCLE, UDAIPUR', NULL, NULL)
INSERT [dbo].[Tournament] ([TournamentID], [Name], [FederationID], [Description], [StartDate], [EndDate], [Winner], [CreatedDate], [UpdateDate], [Status], [Organizer], [Director], [Location], [ParentTourID], [FormID]) VALUES (21, N'Pearl City-All India OPEN Fide Rating Chess Tournament-1st Pz: Alto CAR,2nd Bike Dt:Sep 06th to 11th 2019', 25, NULL, CAST(0x0000AA6800000000 AS DateTime), CAST(0x0000AAF900000000 AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Tournament] ([TournamentID], [Name], [FederationID], [Description], [StartDate], [EndDate], [Winner], [CreatedDate], [UpdateDate], [Status], [Organizer], [Director], [Location], [ParentTourID], [FormID]) VALUES (22, N'REGIONAL NORTE DE XADREZ STD RIO BRANCO ACRE ID:4856', 2, NULL, CAST(0x0000AAB600000000 AS DateTime), CAST(0x0000AAE100000000 AS DateTime), NULL, NULL, NULL, NULL, N'NEURISMAR DA ROCHA SOUZA ID: 5994', N'SHEILA LIMA CUNHA DA COSTA', N'HOTEL HOLIDEY INN EXPRESS', NULL, NULL)
INSERT [dbo].[Tournament] ([TournamentID], [Name], [FederationID], [Description], [StartDate], [EndDate], [Winner], [CreatedDate], [UpdateDate], [Status], [Organizer], [Director], [Location], [ParentTourID], [FormID]) VALUES (23, N'First Thursday - Rapid Chess Tournament 2019 September', 7, NULL, CAST(0x0000AA9A00000000 AS DateTime), CAST(0x0000AAD300000000 AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Tournament] ([TournamentID], [Name], [FederationID], [Description], [StartDate], [EndDate], [Winner], [CreatedDate], [UpdateDate], [Status], [Organizer], [Director], [Location], [ParentTourID], [FormID]) VALUES (24, N'Championnat ouvert d’échecs de Montréal 2019 Montreal Open Section B - U2000', 13, NULL, CAST(0x0000AA6700000000 AS DateTime), CAST(0x0000AAC200000000 AS DateTime), NULL, NULL, NULL, NULL, N'Elevate My Chess Canada Inc.', NULL, N'Montreal, QC', NULL, NULL)
INSERT [dbo].[Tournament] ([TournamentID], [Name], [FederationID], [Description], [StartDate], [EndDate], [Winner], [CreatedDate], [UpdateDate], [Status], [Organizer], [Director], [Location], [ParentTourID], [FormID]) VALUES (25, N'	Giải cờ vua đường đến đỉnh vinh quang mở rộng lần 3', 3, NULL, CAST(0x0000AABF00000000 AS DateTime), CAST(0x0000AAD800000000 AS DateTime), NULL, NULL, NULL, NULL, N'	CLB Ki?n tu?ng tuong lai', N'Bùi Ng?c', N'CLB Ki?n tu?ng tuong lai - co s? 1: s? 45 ngõ 25 Bùi Huy Bích, qu?n Hoàng Mai', NULL, NULL)
INSERT [dbo].[Tournament] ([TournamentID], [Name], [FederationID], [Description], [StartDate], [EndDate], [Winner], [CreatedDate], [UpdateDate], [Status], [Organizer], [Director], [Location], [ParentTourID], [FormID]) VALUES (26, N'Giải Cờ vua Vietchess Văn Quán mở rộng tháng 9 năm 2019', 3, NULL, CAST(0x0000AABF00000000 AS DateTime), CAST(0x0000AAD800000000 AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Tournament] ([TournamentID], [Name], [FederationID], [Description], [StartDate], [EndDate], [Winner], [CreatedDate], [UpdateDate], [Status], [Organizer], [Director], [Location], [ParentTourID], [FormID]) VALUES (27, N'Giải cờ nội bộ VTI HRI 2018/08', 3, NULL, CAST(0x0000AABF00000000 AS DateTime), CAST(0x0000AAD800000000 AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Tournament] ([TournamentID], [Name], [FederationID], [Description], [StartDate], [EndDate], [Winner], [CreatedDate], [UpdateDate], [Status], [Organizer], [Director], [Location], [ParentTourID], [FormID]) VALUES (28, N'GIẢI CỜ VUA TRƯỜNG TIỂU HỌC HOÀN SƠN - Lần 2 - Năm 2018 - 2019 Khối : 1 - 2 - 3', 3, NULL, CAST(0x0000AABB00000000 AS DateTime), CAST(0x0000AAC900000000 AS DateTime), NULL, NULL, CAST(0x20400B00 AS Date), 1, N'CLB Cờ vua MC CHESS', N'Nguyễn Mạnh Cường - 0917.370.928', NULL, NULL, NULL)
INSERT [dbo].[Tournament] ([TournamentID], [Name], [FederationID], [Description], [StartDate], [EndDate], [Winner], [CreatedDate], [UpdateDate], [Status], [Organizer], [Director], [Location], [ParentTourID], [FormID]) VALUES (31, N'HSK Klubturnier 2019 - B1-Gruppe', 23, N'', CAST(0x0000AAC500000000 AS DateTime), CAST(0x0000AACC00000000 AS DateTime), NULL, CAST(0x20400B00 AS Date), NULL, 1, N'', N'', NULL, NULL, NULL)
INSERT [dbo].[Tournament] ([TournamentID], [Name], [FederationID], [Description], [StartDate], [EndDate], [Winner], [CreatedDate], [UpdateDate], [Status], [Organizer], [Director], [Location], [ParentTourID], [FormID]) VALUES (32, N'Školenie a seminár rozhodcov Prešov 21.9.2019', 34, N'', CAST(0x0000AAC400000000 AS DateTime), CAST(0x0000AACD00000000 AS DateTime), NULL, CAST(0x20400B00 AS Date), NULL, 1, N'', N'', NULL, NULL, NULL)
INSERT [dbo].[Tournament] ([TournamentID], [Name], [FederationID], [Description], [StartDate], [EndDate], [Winner], [CreatedDate], [UpdateDate], [Status], [Organizer], [Director], [Location], [ParentTourID], [FormID]) VALUES (35, N'Giải cờ vua nhanh MC CHESS 2019 tranh cúp MC CHESS lần thứ 3 - Bảng U06', 3, NULL, CAST(0x0000AAC600000000 AS DateTime), CAST(0x0000AACD00000000 AS DateTime), NULL, CAST(0x20400B00 AS Date), CAST(0x21400B00 AS Date), 1, N'CLB Cờ vua MC CHESS', N'Nguyễn Mạnh Cường - 0917.370.928', NULL, NULL, NULL)
INSERT [dbo].[Tournament] ([TournamentID], [Name], [FederationID], [Description], [StartDate], [EndDate], [Winner], [CreatedDate], [UpdateDate], [Status], [Organizer], [Director], [Location], [ParentTourID], [FormID]) VALUES (38, N'52º Torneo Marplatense por equipos - 2019 - Mar del Plata - Buenos Aires - Argentina', 1, NULL, CAST(0x0000AAC600000000 AS DateTime), CAST(0x0000AACA00000000 AS DateTime), NULL, CAST(0x21400B00 AS Date), NULL, 1, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Tournament] ([TournamentID], [Name], [FederationID], [Description], [StartDate], [EndDate], [Winner], [CreatedDate], [UpdateDate], [Status], [Organizer], [Director], [Location], [ParentTourID], [FormID]) VALUES (39, N'The 4th HANOI OPEN FIDE RATING CHESS TOURNAMENT 2019', 3, NULL, CAST(0x0000AACC00000000 AS DateTime), CAST(0x0000AACD00000000 AS DateTime), NULL, CAST(0x26400B00 AS Date), NULL, 1, N'Vietnam Chess Federation and Future Grandmaster Chess Club', N'GM Bui Vinh ', N'Future Grandmaster Chess Club, 44 lane 25, Bui Huy Bich street, Hoang Mai Ha Noi', NULL, NULL)
INSERT [dbo].[Tournament] ([TournamentID], [Name], [FederationID], [Description], [StartDate], [EndDate], [Winner], [CreatedDate], [UpdateDate], [Status], [Organizer], [Director], [Location], [ParentTourID], [FormID]) VALUES (40, N'22° Torneo Zonal 2A Atahualpa', 1, NULL, CAST(0x0000AACC00000000 AS DateTime), CAST(0x0000AACE00000000 AS DateTime), NULL, CAST(0x27400B00 AS Date), NULL, 1, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Tournament] ([TournamentID], [Name], [FederationID], [Description], [StartDate], [EndDate], [Winner], [CreatedDate], [UpdateDate], [Status], [Organizer], [Director], [Location], [ParentTourID], [FormID]) VALUES (42, N'2019 Etienne Lewis Trials  u10', 25, NULL, CAST(0x0000A9D000000000 AS DateTime), CAST(0x0000AB1E00000000 AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 1)
INSERT [dbo].[Tournament] ([TournamentID], [Name], [FederationID], [Description], [StartDate], [EndDate], [Winner], [CreatedDate], [UpdateDate], [Status], [Organizer], [Director], [Location], [ParentTourID], [FormID]) VALUES (44, N'2019 Etienne Lewis Trials  u12', 25, NULL, CAST(0x0000A9D000000000 AS DateTime), CAST(0x0000AB1E00000000 AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2)
INSERT [dbo].[Tournament] ([TournamentID], [Name], [FederationID], [Description], [StartDate], [EndDate], [Winner], [CreatedDate], [UpdateDate], [Status], [Organizer], [Director], [Location], [ParentTourID], [FormID]) VALUES (46, N'Ratnagiri District - DSO Selection Chess Tournament - 2019', 25, NULL, CAST(0x0000AACD00000000 AS DateTime), CAST(0x0000AAD100000000 AS DateTime), NULL, CAST(0x28400B00 AS Date), NULL, 1, N'DSO Ratnagiri & R. B. Shirke Highschool, Ratnagiri', N'Mr. Vinod Shinde', N'R. B. Shirke Highschool, Juna Maal Naka, Ratnagiri', NULL, NULL)
INSERT [dbo].[Tournament] ([TournamentID], [Name], [FederationID], [Description], [StartDate], [EndDate], [Winner], [CreatedDate], [UpdateDate], [Status], [Organizer], [Director], [Location], [ParentTourID], [FormID]) VALUES (47, N'Ratnagiri District - DSO Selection Chess Tournament - 2019 U14', 25, NULL, CAST(0x0000AACD00000000 AS DateTime), CAST(0x0000AAD100000000 AS DateTime), NULL, CAST(0x28400B00 AS Date), CAST(0x28400B00 AS Date), 1, NULL, NULL, NULL, 46, NULL)
INSERT [dbo].[Tournament] ([TournamentID], [Name], [FederationID], [Description], [StartDate], [EndDate], [Winner], [CreatedDate], [UpdateDate], [Status], [Organizer], [Director], [Location], [ParentTourID], [FormID]) VALUES (48, N'Ratnagiri District - DSO Selection Chess Tournament - 2019 U16', 25, NULL, CAST(0x0000AACD00000000 AS DateTime), CAST(0x0000AAD100000000 AS DateTime), NULL, CAST(0x28400B00 AS Date), NULL, 1, NULL, NULL, NULL, 46, NULL)
SET IDENTITY_INSERT [dbo].[Tournament] OFF
/****** Object:  Table [dbo].[Player]    Script Date: 09/20/2019 16:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Player](
	[PlayerID] [int] NOT NULL,
	[Name] [nvarchar](250) NULL,
	[FederationID] [int] NULL,
	[Sex] [varchar](50) NULL,
	[Birthdate] [date] NULL,
	[Image] [nvarchar](250) NULL,
	[Rating] [int] NULL,
	[FideID] [int] NULL,
 CONSTRAINT [PK_FIDEprofile] PRIMARY KEY CLUSTERED 
(
	[PlayerID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[Player] ([PlayerID], [Name], [FederationID], [Sex], [Birthdate], [Image], [Rating], [FideID]) VALUES (1, N'Nguyen Van Thi', 1, N'Male', CAST(0x671F0B00 AS Date), NULL, 100, NULL)
INSERT [dbo].[Player] ([PlayerID], [Name], [FederationID], [Sex], [Birthdate], [Image], [Rating], [FideID]) VALUES (2, N'Laxman R.R.', 25, N'Male', CAST(0x671F0B00 AS Date), NULL, 2437, 5005361)
INSERT [dbo].[Player] ([PlayerID], [Name], [FederationID], [Sex], [Birthdate], [Image], [Rating], [FideID]) VALUES (3, N'	Dhulipalla Bala Chandra Prasad', 25, N'Male', CAST(0xFC1F0B00 AS Date), NULL, 2422, 25005812)
INSERT [dbo].[Player] ([PlayerID], [Name], [FederationID], [Sex], [Birthdate], [Image], [Rating], [FideID]) VALUES (4, N'Mitrabha Guha', 25, N'Male', CAST(0xFC1F0B00 AS Date), NULL, 2411, 5092442)
INSERT [dbo].[Player] ([PlayerID], [Name], [FederationID], [Sex], [Birthdate], [Image], [Rating], [FideID]) VALUES (5, N'Senthil Maran K', 25, N'Male', CAST(0xFC1F0B00 AS Date), NULL, 2522, 25035681)
INSERT [dbo].[Player] ([PlayerID], [Name], [FederationID], [Sex], [Birthdate], [Image], [Rating], [FideID]) VALUES (6, N'Rajesh V A V', 25, N'Male', CAST(0xFC1F0B00 AS Date), NULL, 3542, 5029317)
INSERT [dbo].[Player] ([PlayerID], [Name], [FederationID], [Sex], [Birthdate], [Image], [Rating], [FideID]) VALUES (7, N'Vivekananda L', 25, N'Male', CAST(0xFC1F0B00 AS Date), NULL, 23453, 5054664)
INSERT [dbo].[Player] ([PlayerID], [Name], [FederationID], [Sex], [Birthdate], [Image], [Rating], [FideID]) VALUES (8, N'	Setumadhav Yellumahanthi', 25, N'Male', CAST(0xFC1F0B00 AS Date), NULL, 436, 25920669)
INSERT [dbo].[Player] ([PlayerID], [Name], [FederationID], [Sex], [Birthdate], [Image], [Rating], [FideID]) VALUES (9, N'Nichat Ajinkya', 25, N'Female', CAST(0xFC1F0B00 AS Date), NULL, 4245, 35056883)
INSERT [dbo].[Player] ([PlayerID], [Name], [FederationID], [Sex], [Birthdate], [Image], [Rating], [FideID]) VALUES (10, N'Arjun Sidharth S', 25, N'Female', CAST(0xFC1F0B00 AS Date), NULL, 123, 35055054)
INSERT [dbo].[Player] ([PlayerID], [Name], [FederationID], [Sex], [Birthdate], [Image], [Rating], [FideID]) VALUES (11, N'Srivastav J.P', 25, N'Female', CAST(0xFC1F0B00 AS Date), NULL, 1243, 5027683)
INSERT [dbo].[Player] ([PlayerID], [Name], [FederationID], [Sex], [Birthdate], [Image], [Rating], [FideID]) VALUES (12, N'Srinivasa Rao G.V.', 25, N'Female', CAST(0xFC1F0B00 AS Date), NULL, 4256, 5000602)
INSERT [dbo].[Player] ([PlayerID], [Name], [FederationID], [Sex], [Birthdate], [Image], [Rating], [FideID]) VALUES (13, N'Vivekananda L', 25, N'Female', CAST(0xFC1F0B00 AS Date), NULL, 3462, 5054664)
INSERT [dbo].[Player] ([PlayerID], [Name], [FederationID], [Sex], [Birthdate], [Image], [Rating], [FideID]) VALUES (14, N'	Bharathakoti Sneha', 25, N'Female', CAST(0xFC1F0B00 AS Date), NULL, 54735, 25626132)
INSERT [dbo].[Player] ([PlayerID], [Name], [FederationID], [Sex], [Birthdate], [Image], [Rating], [FideID]) VALUES (15, N'Thirupatha Chary Pusala', 25, N'Female', CAST(0x671F0B00 AS Date), NULL, 32534, 25747258)
INSERT [dbo].[Player] ([PlayerID], [Name], [FederationID], [Sex], [Birthdate], [Image], [Rating], [FideID]) VALUES (16, N'Nguyễn Mạnh Hùng', 3, N'Male', NULL, NULL, 23452345, NULL)
INSERT [dbo].[Player] ([PlayerID], [Name], [FederationID], [Sex], [Birthdate], [Image], [Rating], [FideID]) VALUES (17, N'Nguyễn Công Trung', 3, N'Male', NULL, NULL, 513, NULL)
INSERT [dbo].[Player] ([PlayerID], [Name], [FederationID], [Sex], [Birthdate], [Image], [Rating], [FideID]) VALUES (18, N'Trịnh Văn Thành', 3, N'Male', NULL, NULL, 43523452, NULL)
INSERT [dbo].[Player] ([PlayerID], [Name], [FederationID], [Sex], [Birthdate], [Image], [Rating], [FideID]) VALUES (19, N'Nguyễn Long Hải', 3, N'Male', NULL, NULL, 125, NULL)
INSERT [dbo].[Player] ([PlayerID], [Name], [FederationID], [Sex], [Birthdate], [Image], [Rating], [FideID]) VALUES (20, N'Nguyễn Văn Bon', 3, N'Male', NULL, NULL, 23452, NULL)
INSERT [dbo].[Player] ([PlayerID], [Name], [FederationID], [Sex], [Birthdate], [Image], [Rating], [FideID]) VALUES (21, N'Trần Quốc Việt', 3, N'Male', NULL, NULL, 213525, NULL)
INSERT [dbo].[Player] ([PlayerID], [Name], [FederationID], [Sex], [Birthdate], [Image], [Rating], [FideID]) VALUES (22, N'Lưu Quang Huy', 3, N'Male', NULL, NULL, 235, NULL)
INSERT [dbo].[Player] ([PlayerID], [Name], [FederationID], [Sex], [Birthdate], [Image], [Rating], [FideID]) VALUES (23, N'Vieira Antonio Avelhan', 2, N'Male', NULL, NULL, 235, NULL)
INSERT [dbo].[Player] ([PlayerID], [Name], [FederationID], [Sex], [Birthdate], [Image], [Rating], [FideID]) VALUES (24, N'Simao Davi Ribeiro', 2, N'Male', NULL, NULL, 25, NULL)
INSERT [dbo].[Player] ([PlayerID], [Name], [FederationID], [Sex], [Birthdate], [Image], [Rating], [FideID]) VALUES (25, N'Assuncao Ekaterina Vieira De', 2, N'Male', NULL, NULL, 5346, NULL)
INSERT [dbo].[Player] ([PlayerID], [Name], [FederationID], [Sex], [Birthdate], [Image], [Rating], [FideID]) VALUES (26, N'		Goncalves Luiz Henrique Silvestre', 2, N'Male', NULL, NULL, 235, NULL)
INSERT [dbo].[Player] ([PlayerID], [Name], [FederationID], [Sex], [Birthdate], [Image], [Rating], [FideID]) VALUES (27, N'		Casalaspro Mathias Andrev', 2, N'Male', NULL, NULL, 123543, NULL)
/****** Object:  StoredProcedure [dbo].[FederationManagement_UpdateFederation]    Script Date: 09/20/2019 16:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FederationManagement_UpdateFederation]
	@ID				INT					= 0,
	@Name			VARCHAR(100)		= NULL,
	@Flag			VARCHAR(255)		= NULL,
	@Acronym		VARCHAR(50)			= NULL
AS
BEGIN
	UPDATE  		Federation
	SET				Name			= @Name,
					Flag			= @Flag,
					Acronym			= @Acronym
	WHERE			FederationID	= @ID
END
GO
/****** Object:  StoredProcedure [dbo].[RoleManagement_GetAllRole]    Script Date: 09/20/2019 16:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[RoleManagement_GetAllRole]
AS
BEGIN
	SET			NOCOUNT ON
	SELECT		[Role].ID,
				[Role].Name
	FROM		[Role]
				
END
GO
/****** Object:  Table [dbo].[User]    Script Date: 09/20/2019 16:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[User](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [varchar](250) NULL,
	[Password] [varchar](250) NULL,
	[RoleID] [int] NOT NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[User] ON
INSERT [dbo].[User] ([ID], [UserName], [Password], [RoleID]) VALUES (1, N'vikute', N'123', 1)
INSERT [dbo].[User] ([ID], [UserName], [Password], [RoleID]) VALUES (2, N'cutthui', N'123', 2)
INSERT [dbo].[User] ([ID], [UserName], [Password], [RoleID]) VALUES (3, N'havi', N'12345', 1)
INSERT [dbo].[User] ([ID], [UserName], [Password], [RoleID]) VALUES (4, N'mamthui', N'123456', 2)
INSERT [dbo].[User] ([ID], [UserName], [Password], [RoleID]) VALUES (5, N'cutsieuthui', N'123456', 2)
INSERT [dbo].[User] ([ID], [UserName], [Password], [RoleID]) VALUES (6, N'mamtom', N'123456', 2)
INSERT [dbo].[User] ([ID], [UserName], [Password], [RoleID]) VALUES (7, N'admin', N'admin', 2)
INSERT [dbo].[User] ([ID], [UserName], [Password], [RoleID]) VALUES (8, N'kiekie', N'kiekie', 2)
INSERT [dbo].[User] ([ID], [UserName], [Password], [RoleID]) VALUES (9, N'kie11', N'KIE11', 2)
SET IDENTITY_INSERT [dbo].[User] OFF
/****** Object:  StoredProcedure [dbo].[UserManagement_FindUserName]    Script Date: 09/20/2019 16:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UserManagement_FindUserName]
	@UserName		NVARCHAR(250)		= NULL
AS
BEGIN
	SET NOCOUNT ON;
	SELECT			[User].UserName
	FROM			[User]
	WHERE			[User].UserName = @UserName
END
GO
/****** Object:  StoredProcedure [dbo].[UserManagement_CreateUser]    Script Date: 09/20/2019 16:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UserManagement_CreateUser]
	@UserName		VARCHAR(250)	 = NULL,
	@Password		VARCHAR(250)	 = NULL,
	@RoleID			INT				 = 0
AS
BEGIN
	INSERT	INTO	[User]
					([User].UserName,
					[User].Password,
					[User].RoleID )
			VALUES (@UserName,
					@Password,
					@RoleID)	
END
GO
/****** Object:  StoredProcedure [dbo].[UserManagement_CheckUser]    Script Date: 09/20/2019 16:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UserManagement_CheckUser]
	@UserName		VARCHAR(250)		= NULL,
	@Password		VARCHAR(250)		= NULL
AS
BEGIN
	SELECT			[User].ID,
					[User].UserName,
					[User].Password,
					[Role].Name
	FROM			[User]
		  LEFT JOIN Role 
			   ON	[User].RoleID = Role.ID
	WHERE			[User].UserName = @UserName
				AND [User].Password = @Password
				
END
GO
/****** Object:  StoredProcedure [dbo].[RoleManagerment_GetRoleOfUser]    Script Date: 09/20/2019 16:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[RoleManagerment_GetRoleOfUser] 
	@UserID			INT			= 0
AS
BEGIN
	SELECT			Role.Name
	FROM			Role 
		RIGHT JOIN	[User]
			ON		Role.ID = [User].RoleID
	WHERE			[User].ID = @UserID
END
GO
/****** Object:  Table [dbo].[TourRound]    Script Date: 09/20/2019 16:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TourRound](
	[TourID] [int] NOT NULL,
	[RoundID] [int] NOT NULL,
 CONSTRAINT [PK_TourRound] PRIMARY KEY CLUSTERED 
(
	[TourID] ASC,
	[RoundID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[TourRound] ([TourID], [RoundID]) VALUES (1, 1)
INSERT [dbo].[TourRound] ([TourID], [RoundID]) VALUES (1, 2)
INSERT [dbo].[TourRound] ([TourID], [RoundID]) VALUES (3, 1)
INSERT [dbo].[TourRound] ([TourID], [RoundID]) VALUES (3, 2)
INSERT [dbo].[TourRound] ([TourID], [RoundID]) VALUES (15, 1)
INSERT [dbo].[TourRound] ([TourID], [RoundID]) VALUES (15, 2)
INSERT [dbo].[TourRound] ([TourID], [RoundID]) VALUES (15, 3)
INSERT [dbo].[TourRound] ([TourID], [RoundID]) VALUES (15, 4)
INSERT [dbo].[TourRound] ([TourID], [RoundID]) VALUES (16, 1)
INSERT [dbo].[TourRound] ([TourID], [RoundID]) VALUES (16, 2)
INSERT [dbo].[TourRound] ([TourID], [RoundID]) VALUES (17, 1)
INSERT [dbo].[TourRound] ([TourID], [RoundID]) VALUES (17, 2)
INSERT [dbo].[TourRound] ([TourID], [RoundID]) VALUES (17, 3)
INSERT [dbo].[TourRound] ([TourID], [RoundID]) VALUES (18, 1)
INSERT [dbo].[TourRound] ([TourID], [RoundID]) VALUES (42, 1)
INSERT [dbo].[TourRound] ([TourID], [RoundID]) VALUES (42, 2)
INSERT [dbo].[TourRound] ([TourID], [RoundID]) VALUES (42, 3)
INSERT [dbo].[TourRound] ([TourID], [RoundID]) VALUES (42, 4)
INSERT [dbo].[TourRound] ([TourID], [RoundID]) VALUES (44, 1)
INSERT [dbo].[TourRound] ([TourID], [RoundID]) VALUES (44, 2)
/****** Object:  StoredProcedure [dbo].[TournamentManagement_UpdateTournament]    Script Date: 09/20/2019 16:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[TournamentManagement_UpdateTournament]
	@TourID			INT					= 0,
	@Name			NVARCHAR(250)		= NULL,
	@FederationID	INT					= 0,
	@StartDate		DATETIME			= NULL,
	@EndDate		DATETIME			= NULL,
	@Organizer		NVARCHAR(250)		= NULL,
	@Location		NVARCHAR(500)		= NULL,
	@Director		NVARCHAR(250)		= NULL,
	@Description	NVARCHAR(MAX)		= NULL,
	@ParentTourID	INT					= NULL,
	@Status			BIT					= 1
AS
BEGIN
	UPDATE			Tournament 
	SET				Name			= @Name, 
					FederationID	= @FederationID, 
					StartDate		= @StartDate, 
					EndDate			= @EndDate, 
					Organizer		= @Organizer, 
					Location		= @Location,
					Director		= @Director, 
					[Description]	= @Description, 
					ParentTourID	= @ParentTourID, 
					[Status]		= @Status, 
					UpdateDate		= GETDATE()
	WHERE			TournamentID	= @TourID
END
GO
/****** Object:  StoredProcedure [dbo].[TournamentManagement_GetTournamentNotHaveChild]    Script Date: 09/20/2019 16:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[TournamentManagement_GetTournamentNotHaveChild]
	
AS
BEGIN
	   SET NOCOUNT ON;

	   SELECT	Tournament.TournamentID,
				Tournament.Name,
				Tournament.Organizer,
				Tournament.Director,
				Tournament.Location,
				Tournament.StartDate,
				Tournament.EndDate,
				Tournament.ParentTourID
		FROM	Tournament
		WHERE	Tournament.ParentTourID IS NULL
END
GO
/****** Object:  StoredProcedure [dbo].[TournamentManagement_GetTournamentInProgressByFederation]    Script Date: 09/20/2019 16:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[TournamentManagement_GetTournamentInProgressByFederation]
	@FederationId		INT			=0
AS
BEGIN
	SELECT	Tournament.TournamentID,
			Tournament.Name,
			Tournament.Organizer,
			Tournament.Director,
			Tournament.Location,
			Tournament.StartDate,
			Tournament.EndDate,
			Tournament.UpdateDate,
			Federation.FederationID, 
			Federation.Name, 
			Federation.Acronym, 
			Federation.Flag
	FROM	Tournament 
			LEFT JOIN Federation 
				ON Tournament.FederationID = Federation.FederationID
	WHERE	Tournament.EndDate >= CAST(GETDATE() AS DATE)
				AND Tournament.StartDate <= CAST(GETDATE() AS DATE)
				AND Tournament.FederationID = @FederationId;
END
GO
/****** Object:  StoredProcedure [dbo].[TournamentManagement_GetTournamentInProgress]    Script Date: 09/20/2019 16:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[TournamentManagement_GetTournamentInProgress]
	
AS
BEGIN
	SELECT	Tournament.TournamentID,
			Tournament.Name,
			Tournament.Organizer,
			Tournament.Director,
			Tournament.Location,
			Tournament.StartDate,
			Tournament.EndDate,
			Tournament.UpdateDate,
			Federation.FederationID, 
			Federation.Name, 
			Federation.Acronym, 
			Federation.Flag
	FROM Tournament 
		LEFT JOIN Federation 
		ON Tournament.FederationID = Federation.FederationID
	WHERE Tournament.EndDate >= CAST(GETDATE() AS DATE)
		AND Tournament.StartDate <= CAST(GETDATE() AS DATE)
END
GO
/****** Object:  StoredProcedure [dbo].[TournamentManagement_GetTournamentByID]    Script Date: 09/20/2019 16:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[TournamentManagement_GetTournamentByID]
	@Id             INT           = 0
AS
BEGIN
	SELECT	Tournament.TournamentID,
			Tournament.Name,
			Tournament.Organizer,
			Tournament.Director,
			Tournament.Location,
			Tournament.StartDate,
			Tournament.EndDate,
			Tournament.UpdateDate,
			Tournament.FederationID,
			Federation.FederationID, 
			Federation.Name, 
			Federation.Acronym, 
			Federation.Flag
	FROM	Tournament
			LEFT JOIN Federation 
				ON Tournament.FederationID = Federation.FederationID 
	WHERE	Tournament.TournamentID = @Id
END
GO
/****** Object:  StoredProcedure [dbo].[TournamentManagement_GetTournamentByFederation]    Script Date: 09/20/2019 16:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[TournamentManagement_GetTournamentByFederation]
	@FederationID		INT		= 0
AS
BEGIN
	SELECT	Tournament.TournamentID,
			Tournament.Name,
			Tournament.Organizer,
			Tournament.Director,
			Tournament.Location,
			Tournament.StartDate,
			Tournament.EndDate,
			Tournament.UpdateDate,
			Federation.FederationID, 
			Federation.Name, 
			Federation.Acronym, 
			Federation.Flag	
	FROM Tournament
			LEFT JOIN Federation 
				ON Tournament.FederationID = Federation.FederationID
				AND Tournament.FederationID = @FederationID;
END
GO
/****** Object:  StoredProcedure [dbo].[TournamentManagement_GetAllTournaments]    Script Date: 09/20/2019 16:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[TournamentManagement_GetAllTournaments]

AS
BEGIN
	SELECT	Tournament.TournamentID,
			Tournament.Name,
			Tournament.Organizer,
			Tournament.Director,
			Tournament.Location,
			Tournament.StartDate,
			Tournament.EndDate,
			Tournament.UpdateDate,
			Federation.FederationID, 
			Federation.Name, 
			Federation.Acronym, 
			Federation.Flag	
	FROM Tournament
			LEFT JOIN Federation 
				ON Tournament.FederationID = Federation.FederationID;
END
GO
/****** Object:  StoredProcedure [dbo].[TournamentManagement_GetAllTournamentChildOfTournament]    Script Date: 09/20/2019 16:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[TournamentManagement_GetAllTournamentChildOfTournament] 
	@TourID			INT			= 0
AS
BEGIN
	SET				NOCOUNT ON
	SELECT			[Form].Name,
					Tournament.TournamentID,
					Tournament.Name,
					Tournament.Organizer,
					Tournament.Director,
					Tournament.Location,
					Tournament.StartDate,
					Tournament.EndDate,
					Tournament.UpdateDate
	FROM			Tournament
	LEFT JOIN		[Form] 
			ON		Tournament.FormID = [Form].ID
	WHERE			Tournament.ParentTourID = @TourID	
END
GO
/****** Object:  StoredProcedure [dbo].[TournamentManagement_DeleteTournament]    Script Date: 09/20/2019 16:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[TournamentManagement_DeleteTournament]
	@TourID			INT			= 0
AS
BEGIN
	DELETE FROM		Tournament
		   WHERE	TournamentID = @TourID
	
END
GO
/****** Object:  StoredProcedure [dbo].[TournamentManagement_CreateTournament]    Script Date: 09/20/2019 16:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[TournamentManagement_CreateTournament]
	@Name			NVARCHAR(250)		= NULL,
	@FederationID	INT					= 0,
	@StartDate		DATETIME			= NULL,
	@EndDate		DATETIME			= NULL,
	@Location		NVARCHAR(250)		= NULL,
	@Organizer		NVARCHAR(250)		= NULL,
	@Director		NVARCHAR(250)		= NULL,
	@Description	NVARCHAR(MAX)		= NULL,
	@ParentTourID	INT					= NULL,
	@Status			BIT					= 1
AS
BEGIN
IF(@ParentTourID = 0)
	BEGIN
		INSERT INTO			Tournament 
							(Name, 
							FederationID, 
							StartDate, 
							EndDate, 
							Location,
							Organizer, 
							Director, 
							[Description],
							[Status], 
							CreatedDate)
				   VALUES	(@Name, 
							 @FederationID, 
							 @StartDate, 
							 @EndDate, 
							 @Location,
							 @Organizer, 
							 @Director, 
							 @Description,
							 @Status, 
							 GETDATE())
	END
ELSE 
	BEGIN
		INSERT INTO			Tournament 
							(Name, 
							FederationID, 
							StartDate, 
							EndDate, 
							Location,
							Organizer, 
							Director, 
							[Description], 
							ParentTourID, 
							[Status], 
							CreatedDate)
				   VALUES	(@Name, 
							 @FederationID, 
							 @StartDate, 
							 @EndDate, 
							 @Location,
							 @Organizer, 
							 @Director, 
							 @Description, 
							 @ParentTourID, 
							 @Status, 
							 GETDATE())
	END
	
END
GO
/****** Object:  StoredProcedure [dbo].[PlayerManagement_GetPlayerByID]    Script Date: 09/20/2019 16:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PlayerManagement_GetPlayerByID]
	@ID			INT			= 0
AS
BEGIN
	SELECT	Player.PlayerID,
			Player.Name,
			Player.Birthdate,
			Player.Image,
			Player.Rating,
			Player.Sex,
			Player.FideID,
			Federation.FederationID,
			Federation.Name,
			Federation.Flag
	FROM	Player
			LEFT JOIN Federation 
				ON Player.FederationID = Federation.FederationID 
	WHERE	Player.PlayerID = @ID
END
GO
/****** Object:  StoredProcedure [dbo].[PlayerManagement_DeletePlayer]    Script Date: 09/20/2019 16:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PlayerManagement_DeletePlayer]
	@ID			INT			= 0
AS
BEGIN
	DELETE FROM		Player
		   WHERE	PlayerID = @ID
END
GO
/****** Object:  StoredProcedure [dbo].[PlayerManagement_CreatePlayer]    Script Date: 09/20/2019 16:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PlayerManagement_CreatePlayer] 
	@Id             INT           = 0,
	@Name           VARCHAR(250)  = NULL,
	@FederationID   INT			  = NULL,
	@Sex            VARCHAR(50)   = NULL,
	@Birthdate      DATE		  = NULL,
	@Image          VARCHAR(250)  = NULL,
	@Rating         INT		      = NULL
	
AS
BEGIN
	INSERT INTO Player (PlayerID,
						Name,
						FederationID,
						Sex,
						Birthdate,
						Image,
						Rating )
				VALUES (@Id,
						@Name, 
						@FederationID, 
						@Sex, 
						@Birthdate, 
						@Image, 
						@Rating) 
END
GO
/****** Object:  Table [dbo].[TourGroup]    Script Date: 09/20/2019 16:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TourGroup](
	[TournamentID] [int] NOT NULL,
	[GroupID] [int] NOT NULL,
	[StartTime] [datetime] NULL,
 CONSTRAINT [PK_TourGroup] PRIMARY KEY CLUSTERED 
(
	[TournamentID] ASC,
	[GroupID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TourForm]    Script Date: 09/20/2019 16:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TourForm](
	[TourID] [int] NOT NULL,
	[FormID] [int] NOT NULL,
 CONSTRAINT [PK_TourForm] PRIMARY KEY CLUSTERED 
(
	[TourID] ASC,
	[FormID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[TourForm] ([TourID], [FormID]) VALUES (15, 1)
INSERT [dbo].[TourForm] ([TourID], [FormID]) VALUES (16, 2)
INSERT [dbo].[TourForm] ([TourID], [FormID]) VALUES (17, 3)
INSERT [dbo].[TourForm] ([TourID], [FormID]) VALUES (18, 4)
/****** Object:  StoredProcedure [dbo].[FideProfileManagement_CreateFideProfile]    Script Date: 09/20/2019 16:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FideProfileManagement_CreateFideProfile] 
	@Id             INT           = 0,
	@Name           VARCHAR(250)  = NULL,
	@FederationID   INT			  = NULL,
	@Sex            VARCHAR(50)   = NULL,
	@Birthdate      DATE		  = NULL,
	@Image          VARCHAR(250)  = NULL,
	@Rating         int		      = NULL
	
AS
BEGIN
	INSERT INTO Player (ID,
						Name,
						FederationID,
						Sex,
						Birthdate,
						Image,
						Rating )
				VALUES (@Id,
						@Name, 
						@FederationID, 
						@Sex, 
						@Birthdate, 
						@Image, 
						@Rating) 
END
GO
/****** Object:  Table [dbo].[FederationParticipate]    Script Date: 09/20/2019 16:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FederationParticipate](
	[TourID] [int] NOT NULL,
	[FederationID] [int] NOT NULL,
 CONSTRAINT [PK_FederationParticipate] PRIMARY KEY CLUSTERED 
(
	[TourID] ASC,
	[FederationID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[FederationParticipate] ([TourID], [FederationID]) VALUES (1, 1)
INSERT [dbo].[FederationParticipate] ([TourID], [FederationID]) VALUES (1, 2)
INSERT [dbo].[FederationParticipate] ([TourID], [FederationID]) VALUES (1, 3)
INSERT [dbo].[FederationParticipate] ([TourID], [FederationID]) VALUES (1, 4)
INSERT [dbo].[FederationParticipate] ([TourID], [FederationID]) VALUES (2, 3)
INSERT [dbo].[FederationParticipate] ([TourID], [FederationID]) VALUES (2, 25)
INSERT [dbo].[FederationParticipate] ([TourID], [FederationID]) VALUES (3, 3)
INSERT [dbo].[FederationParticipate] ([TourID], [FederationID]) VALUES (14, 3)
INSERT [dbo].[FederationParticipate] ([TourID], [FederationID]) VALUES (14, 25)
/****** Object:  Table [dbo].[Pairing]    Script Date: 09/20/2019 16:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pairing](
	[PairingID] [int] NOT NULL,
	[RoundID] [int] NOT NULL,
	[TourID] [int] NOT NULL,
	[StartTime] [datetime] NULL,
	[EndTime] [datetime] NULL,
 CONSTRAINT [PK_Pairing_1] PRIMARY KEY CLUSTERED 
(
	[PairingID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Pairing] ([PairingID], [RoundID], [TourID], [StartTime], [EndTime]) VALUES (1, 1, 1, NULL, NULL)
INSERT [dbo].[Pairing] ([PairingID], [RoundID], [TourID], [StartTime], [EndTime]) VALUES (2, 1, 1, NULL, NULL)
INSERT [dbo].[Pairing] ([PairingID], [RoundID], [TourID], [StartTime], [EndTime]) VALUES (3, 1, 1, NULL, NULL)
INSERT [dbo].[Pairing] ([PairingID], [RoundID], [TourID], [StartTime], [EndTime]) VALUES (4, 2, 1, NULL, NULL)
INSERT [dbo].[Pairing] ([PairingID], [RoundID], [TourID], [StartTime], [EndTime]) VALUES (5, 2, 1, NULL, NULL)
INSERT [dbo].[Pairing] ([PairingID], [RoundID], [TourID], [StartTime], [EndTime]) VALUES (6, 1, 42, NULL, NULL)
INSERT [dbo].[Pairing] ([PairingID], [RoundID], [TourID], [StartTime], [EndTime]) VALUES (7, 1, 42, NULL, NULL)
INSERT [dbo].[Pairing] ([PairingID], [RoundID], [TourID], [StartTime], [EndTime]) VALUES (8, 1, 42, NULL, NULL)
INSERT [dbo].[Pairing] ([PairingID], [RoundID], [TourID], [StartTime], [EndTime]) VALUES (9, 1, 42, NULL, NULL)
INSERT [dbo].[Pairing] ([PairingID], [RoundID], [TourID], [StartTime], [EndTime]) VALUES (10, 2, 42, NULL, NULL)
INSERT [dbo].[Pairing] ([PairingID], [RoundID], [TourID], [StartTime], [EndTime]) VALUES (11, 2, 42, NULL, NULL)
INSERT [dbo].[Pairing] ([PairingID], [RoundID], [TourID], [StartTime], [EndTime]) VALUES (12, 3, 42, NULL, NULL)
INSERT [dbo].[Pairing] ([PairingID], [RoundID], [TourID], [StartTime], [EndTime]) VALUES (13, 4, 42, NULL, NULL)
INSERT [dbo].[Pairing] ([PairingID], [RoundID], [TourID], [StartTime], [EndTime]) VALUES (14, 4, 42, NULL, NULL)
INSERT [dbo].[Pairing] ([PairingID], [RoundID], [TourID], [StartTime], [EndTime]) VALUES (15, 1, 42, NULL, NULL)
INSERT [dbo].[Pairing] ([PairingID], [RoundID], [TourID], [StartTime], [EndTime]) VALUES (16, 1, 3, NULL, NULL)
INSERT [dbo].[Pairing] ([PairingID], [RoundID], [TourID], [StartTime], [EndTime]) VALUES (17, 2, 3, NULL, NULL)
INSERT [dbo].[Pairing] ([PairingID], [RoundID], [TourID], [StartTime], [EndTime]) VALUES (18, 1, 15, CAST(0x0000AAD000D63BC0 AS DateTime), CAST(0x0000AAD000E6B680 AS DateTime))
INSERT [dbo].[Pairing] ([PairingID], [RoundID], [TourID], [StartTime], [EndTime]) VALUES (19, 1, 15, CAST(0x0000AAD000F73140 AS DateTime), CAST(0x0000AAD00107AC00 AS DateTime))
INSERT [dbo].[Pairing] ([PairingID], [RoundID], [TourID], [StartTime], [EndTime]) VALUES (20, 1, 15, CAST(0x0000AAD100D63BC0 AS DateTime), CAST(0x0000AAD100EEF3E0 AS DateTime))
INSERT [dbo].[Pairing] ([PairingID], [RoundID], [TourID], [StartTime], [EndTime]) VALUES (21, 1, 15, CAST(0x0000AAD100EAD530 AS DateTime), CAST(0x0000AAD1011C4570 AS DateTime))
INSERT [dbo].[Pairing] ([PairingID], [RoundID], [TourID], [StartTime], [EndTime]) VALUES (22, 1, 15, NULL, NULL)
INSERT [dbo].[Pairing] ([PairingID], [RoundID], [TourID], [StartTime], [EndTime]) VALUES (23, 2, 15, NULL, NULL)
INSERT [dbo].[Pairing] ([PairingID], [RoundID], [TourID], [StartTime], [EndTime]) VALUES (24, 2, 15, NULL, NULL)
INSERT [dbo].[Pairing] ([PairingID], [RoundID], [TourID], [StartTime], [EndTime]) VALUES (25, 2, 15, NULL, NULL)
INSERT [dbo].[Pairing] ([PairingID], [RoundID], [TourID], [StartTime], [EndTime]) VALUES (26, 3, 15, NULL, NULL)
INSERT [dbo].[Pairing] ([PairingID], [RoundID], [TourID], [StartTime], [EndTime]) VALUES (27, 3, 15, NULL, NULL)
INSERT [dbo].[Pairing] ([PairingID], [RoundID], [TourID], [StartTime], [EndTime]) VALUES (28, 4, 15, NULL, NULL)
INSERT [dbo].[Pairing] ([PairingID], [RoundID], [TourID], [StartTime], [EndTime]) VALUES (29, 1, 16, NULL, NULL)
INSERT [dbo].[Pairing] ([PairingID], [RoundID], [TourID], [StartTime], [EndTime]) VALUES (30, 1, 16, NULL, NULL)
INSERT [dbo].[Pairing] ([PairingID], [RoundID], [TourID], [StartTime], [EndTime]) VALUES (31, 2, 16, NULL, NULL)
INSERT [dbo].[Pairing] ([PairingID], [RoundID], [TourID], [StartTime], [EndTime]) VALUES (32, 1, 44, CAST(0x0000AAE400D63BC0 AS DateTime), CAST(0x0000AAE400E6B680 AS DateTime))
INSERT [dbo].[Pairing] ([PairingID], [RoundID], [TourID], [StartTime], [EndTime]) VALUES (33, 1, 44, CAST(0x0000AAE400F73140 AS DateTime), CAST(0x0000AAE40107AC00 AS DateTime))
INSERT [dbo].[Pairing] ([PairingID], [RoundID], [TourID], [StartTime], [EndTime]) VALUES (34, 2, 44, CAST(0x0000AAE4011826C0 AS DateTime), CAST(0x0000AAE40128A180 AS DateTime))
INSERT [dbo].[Pairing] ([PairingID], [RoundID], [TourID], [StartTime], [EndTime]) VALUES (35, 2, 44, CAST(0x0000AB0300F73140 AS DateTime), CAST(0x0000AAE30107AC00 AS DateTime))
INSERT [dbo].[Pairing] ([PairingID], [RoundID], [TourID], [StartTime], [EndTime]) VALUES (36, 2, 44, CAST(0x0000AB040107AC00 AS DateTime), CAST(0x0000AB040128A180 AS DateTime))
INSERT [dbo].[Pairing] ([PairingID], [RoundID], [TourID], [StartTime], [EndTime]) VALUES (37, 1, 42, CAST(0x0000AB0600C5C100 AS DateTime), CAST(0x0000AB0600E6B680 AS DateTime))
INSERT [dbo].[Pairing] ([PairingID], [RoundID], [TourID], [StartTime], [EndTime]) VALUES (38, 1, 42, CAST(0x0000AB0700D63BC0 AS DateTime), CAST(0x0000AB0700F73140 AS DateTime))
INSERT [dbo].[Pairing] ([PairingID], [RoundID], [TourID], [StartTime], [EndTime]) VALUES (39, 2, 42, CAST(0x0000AAE400C5C100 AS DateTime), CAST(0x0000AAE400CDFE60 AS DateTime))
INSERT [dbo].[Pairing] ([PairingID], [RoundID], [TourID], [StartTime], [EndTime]) VALUES (40, 2, 42, CAST(0x0000AAEC00E6B680 AS DateTime), CAST(0x0000AAEC00F1B300 AS DateTime))
INSERT [dbo].[Pairing] ([PairingID], [RoundID], [TourID], [StartTime], [EndTime]) VALUES (41, 2, 42, CAST(0x0000AB1000E6B680 AS DateTime), CAST(0x0000AB10011826C0 AS DateTime))
INSERT [dbo].[Pairing] ([PairingID], [RoundID], [TourID], [StartTime], [EndTime]) VALUES (42, 1, 44, CAST(0x0000AB1000F73140 AS DateTime), CAST(0x0000AB100128A180 AS DateTime))
INSERT [dbo].[Pairing] ([PairingID], [RoundID], [TourID], [StartTime], [EndTime]) VALUES (43, 1, 44, CAST(0x0000AB1500735B40 AS DateTime), CAST(0x0000AB15009450C0 AS DateTime))
/****** Object:  StoredProcedure [dbo].[RoundManagement_GetListRoundByTournament]    Script Date: 09/20/2019 16:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[RoundManagement_GetListRoundByTournament]
	@TourID		INT		= 0
AS
BEGIN
	SELECT  Round.ID,
			Round.Name
	FROM	TourRound INNER JOIN Round
				ON TourRound.RoundID = Round.ID
	WHERE	TourRound.TourID = @TourID
END
GO
/****** Object:  StoredProcedure [dbo].[FederationManagement_GetFederationParticipate]    Script Date: 09/20/2019 16:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FederationManagement_GetFederationParticipate] 
	@TourId		INT		= 0
AS
BEGIN
	SET		NOCOUNT ON
	SELECT	Federation.FederationID, 
			Federation.Name, 
			Federation.Acronym, 
			Federation.Flag
	FROM	Federation 
			INNER JOIN FederationParticipate 
				ON Federation.FederationID = FederationParticipate.FederationID 
	WHERE	FederationParticipate.TourID = @TourId;
END
GO
/****** Object:  Table [dbo].[PlayerInPair]    Script Date: 09/20/2019 16:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PlayerInPair](
	[PairingID] [int] NOT NULL,
	[PlayerID] [int] NOT NULL,
	[IsWhite] [bit] NULL,
	[Mark] [float] NULL,
 CONSTRAINT [PK_PlayerInPair] PRIMARY KEY CLUSTERED 
(
	[PairingID] ASC,
	[PlayerID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[PlayerInPair] ([PairingID], [PlayerID], [IsWhite], [Mark]) VALUES (1, 2, 0, 0)
INSERT [dbo].[PlayerInPair] ([PairingID], [PlayerID], [IsWhite], [Mark]) VALUES (1, 15, 1, 1)
INSERT [dbo].[PlayerInPair] ([PairingID], [PlayerID], [IsWhite], [Mark]) VALUES (2, 3, 1, 0)
INSERT [dbo].[PlayerInPair] ([PairingID], [PlayerID], [IsWhite], [Mark]) VALUES (2, 4, 0, 0)
INSERT [dbo].[PlayerInPair] ([PairingID], [PlayerID], [IsWhite], [Mark]) VALUES (3, 3, 1, 0.5)
INSERT [dbo].[PlayerInPair] ([PairingID], [PlayerID], [IsWhite], [Mark]) VALUES (3, 8, 0, 0.5)
INSERT [dbo].[PlayerInPair] ([PairingID], [PlayerID], [IsWhite], [Mark]) VALUES (4, 5, 1, 2)
INSERT [dbo].[PlayerInPair] ([PairingID], [PlayerID], [IsWhite], [Mark]) VALUES (4, 15, 0, 2)
INSERT [dbo].[PlayerInPair] ([PairingID], [PlayerID], [IsWhite], [Mark]) VALUES (5, 6, 1, 1)
INSERT [dbo].[PlayerInPair] ([PairingID], [PlayerID], [IsWhite], [Mark]) VALUES (5, 7, 0, 0)
INSERT [dbo].[PlayerInPair] ([PairingID], [PlayerID], [IsWhite], [Mark]) VALUES (6, 11, 0, 1.5)
INSERT [dbo].[PlayerInPair] ([PairingID], [PlayerID], [IsWhite], [Mark]) VALUES (6, 12, 1, 2)
INSERT [dbo].[PlayerInPair] ([PairingID], [PlayerID], [IsWhite], [Mark]) VALUES (7, 5, 0, 0.5)
INSERT [dbo].[PlayerInPair] ([PairingID], [PlayerID], [IsWhite], [Mark]) VALUES (7, 8, 1, 0)
INSERT [dbo].[PlayerInPair] ([PairingID], [PlayerID], [IsWhite], [Mark]) VALUES (8, 9, 0, 0)
INSERT [dbo].[PlayerInPair] ([PairingID], [PlayerID], [IsWhite], [Mark]) VALUES (8, 14, 1, 1)
INSERT [dbo].[PlayerInPair] ([PairingID], [PlayerID], [IsWhite], [Mark]) VALUES (9, 4, 0, 0)
INSERT [dbo].[PlayerInPair] ([PairingID], [PlayerID], [IsWhite], [Mark]) VALUES (9, 11, 1, 0)
INSERT [dbo].[PlayerInPair] ([PairingID], [PlayerID], [IsWhite], [Mark]) VALUES (10, 6, 1, 0.5)
INSERT [dbo].[PlayerInPair] ([PairingID], [PlayerID], [IsWhite], [Mark]) VALUES (10, 8, 0, 0.5)
INSERT [dbo].[PlayerInPair] ([PairingID], [PlayerID], [IsWhite], [Mark]) VALUES (11, 7, 0, 0)
INSERT [dbo].[PlayerInPair] ([PairingID], [PlayerID], [IsWhite], [Mark]) VALUES (11, 9, 1, 1)
INSERT [dbo].[PlayerInPair] ([PairingID], [PlayerID], [IsWhite], [Mark]) VALUES (12, 4, 0, 1)
INSERT [dbo].[PlayerInPair] ([PairingID], [PlayerID], [IsWhite], [Mark]) VALUES (12, 5, 1, 2)
INSERT [dbo].[PlayerInPair] ([PairingID], [PlayerID], [IsWhite], [Mark]) VALUES (13, 12, 0, 0)
INSERT [dbo].[PlayerInPair] ([PairingID], [PlayerID], [IsWhite], [Mark]) VALUES (13, 13, 1, 0)
INSERT [dbo].[PlayerInPair] ([PairingID], [PlayerID], [IsWhite], [Mark]) VALUES (14, 9, 0, 1)
INSERT [dbo].[PlayerInPair] ([PairingID], [PlayerID], [IsWhite], [Mark]) VALUES (14, 10, 1, 0.5)
INSERT [dbo].[PlayerInPair] ([PairingID], [PlayerID], [IsWhite], [Mark]) VALUES (15, 16, 1, 0)
INSERT [dbo].[PlayerInPair] ([PairingID], [PlayerID], [IsWhite], [Mark]) VALUES (15, 18, 0, 2)
INSERT [dbo].[PlayerInPair] ([PairingID], [PlayerID], [IsWhite], [Mark]) VALUES (16, 17, 1, 0)
INSERT [dbo].[PlayerInPair] ([PairingID], [PlayerID], [IsWhite], [Mark]) VALUES (16, 19, 0, 0)
INSERT [dbo].[PlayerInPair] ([PairingID], [PlayerID], [IsWhite], [Mark]) VALUES (17, 17, 0, 1)
INSERT [dbo].[PlayerInPair] ([PairingID], [PlayerID], [IsWhite], [Mark]) VALUES (17, 20, 1, 0.5)
INSERT [dbo].[PlayerInPair] ([PairingID], [PlayerID], [IsWhite], [Mark]) VALUES (18, 15, 1, 1)
INSERT [dbo].[PlayerInPair] ([PairingID], [PlayerID], [IsWhite], [Mark]) VALUES (18, 16, NULL, 2)
INSERT [dbo].[PlayerInPair] ([PairingID], [PlayerID], [IsWhite], [Mark]) VALUES (19, 3, NULL, 0)
INSERT [dbo].[PlayerInPair] ([PairingID], [PlayerID], [IsWhite], [Mark]) VALUES (19, 6, NULL, 2)
INSERT [dbo].[PlayerInPair] ([PairingID], [PlayerID], [IsWhite], [Mark]) VALUES (20, 7, NULL, 0.5)
INSERT [dbo].[PlayerInPair] ([PairingID], [PlayerID], [IsWhite], [Mark]) VALUES (20, 8, NULL, 0.5)
INSERT [dbo].[PlayerInPair] ([PairingID], [PlayerID], [IsWhite], [Mark]) VALUES (21, 11, NULL, 0)
INSERT [dbo].[PlayerInPair] ([PairingID], [PlayerID], [IsWhite], [Mark]) VALUES (21, 12, NULL, 0)
INSERT [dbo].[PlayerInPair] ([PairingID], [PlayerID], [IsWhite], [Mark]) VALUES (22, 10, NULL, 0)
INSERT [dbo].[PlayerInPair] ([PairingID], [PlayerID], [IsWhite], [Mark]) VALUES (22, 15, NULL, 0)
INSERT [dbo].[PlayerInPair] ([PairingID], [PlayerID], [IsWhite], [Mark]) VALUES (23, 14, NULL, 0)
INSERT [dbo].[PlayerInPair] ([PairingID], [PlayerID], [IsWhite], [Mark]) VALUES (23, 16, NULL, 0)
INSERT [dbo].[PlayerInPair] ([PairingID], [PlayerID], [IsWhite], [Mark]) VALUES (24, 10, NULL, 0.6)
INSERT [dbo].[PlayerInPair] ([PairingID], [PlayerID], [IsWhite], [Mark]) VALUES (24, 21, NULL, 0)
INSERT [dbo].[PlayerInPair] ([PairingID], [PlayerID], [IsWhite], [Mark]) VALUES (25, 17, NULL, 1)
INSERT [dbo].[PlayerInPair] ([PairingID], [PlayerID], [IsWhite], [Mark]) VALUES (25, 19, NULL, 0.5)
INSERT [dbo].[PlayerInPair] ([PairingID], [PlayerID], [IsWhite], [Mark]) VALUES (26, 17, NULL, 2)
INSERT [dbo].[PlayerInPair] ([PairingID], [PlayerID], [IsWhite], [Mark]) VALUES (26, 23, NULL, 0)
INSERT [dbo].[PlayerInPair] ([PairingID], [PlayerID], [IsWhite], [Mark]) VALUES (27, 4, NULL, 1)
INSERT [dbo].[PlayerInPair] ([PairingID], [PlayerID], [IsWhite], [Mark]) VALUES (27, 17, NULL, 2)
INSERT [dbo].[PlayerInPair] ([PairingID], [PlayerID], [IsWhite], [Mark]) VALUES (28, 9, NULL, 0)
INSERT [dbo].[PlayerInPair] ([PairingID], [PlayerID], [IsWhite], [Mark]) VALUES (28, 11, NULL, 0.5)
INSERT [dbo].[PlayerInPair] ([PairingID], [PlayerID], [IsWhite], [Mark]) VALUES (29, 15, NULL, 0.5)
INSERT [dbo].[PlayerInPair] ([PairingID], [PlayerID], [IsWhite], [Mark]) VALUES (29, 22, NULL, 0)
INSERT [dbo].[PlayerInPair] ([PairingID], [PlayerID], [IsWhite], [Mark]) VALUES (30, 13, NULL, 0)
INSERT [dbo].[PlayerInPair] ([PairingID], [PlayerID], [IsWhite], [Mark]) VALUES (30, 14, NULL, 0)
INSERT [dbo].[PlayerInPair] ([PairingID], [PlayerID], [IsWhite], [Mark]) VALUES (31, 4, NULL, 0.5)
INSERT [dbo].[PlayerInPair] ([PairingID], [PlayerID], [IsWhite], [Mark]) VALUES (31, 16, NULL, 0)
INSERT [dbo].[PlayerInPair] ([PairingID], [PlayerID], [IsWhite], [Mark]) VALUES (32, 14, NULL, 0)
INSERT [dbo].[PlayerInPair] ([PairingID], [PlayerID], [IsWhite], [Mark]) VALUES (32, 15, NULL, 0.5)
INSERT [dbo].[PlayerInPair] ([PairingID], [PlayerID], [IsWhite], [Mark]) VALUES (33, 11, NULL, 0)
INSERT [dbo].[PlayerInPair] ([PairingID], [PlayerID], [IsWhite], [Mark]) VALUES (33, 14, NULL, 1)
INSERT [dbo].[PlayerInPair] ([PairingID], [PlayerID], [IsWhite], [Mark]) VALUES (34, 9, NULL, 0)
INSERT [dbo].[PlayerInPair] ([PairingID], [PlayerID], [IsWhite], [Mark]) VALUES (34, 16, NULL, 0.5)
INSERT [dbo].[PlayerInPair] ([PairingID], [PlayerID], [IsWhite], [Mark]) VALUES (35, 13, NULL, 1)
INSERT [dbo].[PlayerInPair] ([PairingID], [PlayerID], [IsWhite], [Mark]) VALUES (35, 19, NULL, 0)
INSERT [dbo].[PlayerInPair] ([PairingID], [PlayerID], [IsWhite], [Mark]) VALUES (36, 17, NULL, 1)
INSERT [dbo].[PlayerInPair] ([PairingID], [PlayerID], [IsWhite], [Mark]) VALUES (36, 19, NULL, 0)
INSERT [dbo].[PlayerInPair] ([PairingID], [PlayerID], [IsWhite], [Mark]) VALUES (37, 14, NULL, NULL)
INSERT [dbo].[PlayerInPair] ([PairingID], [PlayerID], [IsWhite], [Mark]) VALUES (37, 15, NULL, NULL)
INSERT [dbo].[PlayerInPair] ([PairingID], [PlayerID], [IsWhite], [Mark]) VALUES (38, 11, NULL, NULL)
INSERT [dbo].[PlayerInPair] ([PairingID], [PlayerID], [IsWhite], [Mark]) VALUES (38, 12, NULL, NULL)
INSERT [dbo].[PlayerInPair] ([PairingID], [PlayerID], [IsWhite], [Mark]) VALUES (39, 9, NULL, NULL)
INSERT [dbo].[PlayerInPair] ([PairingID], [PlayerID], [IsWhite], [Mark]) VALUES (39, 11, NULL, NULL)
INSERT [dbo].[PlayerInPair] ([PairingID], [PlayerID], [IsWhite], [Mark]) VALUES (40, 15, NULL, NULL)
INSERT [dbo].[PlayerInPair] ([PairingID], [PlayerID], [IsWhite], [Mark]) VALUES (40, 18, NULL, NULL)
INSERT [dbo].[PlayerInPair] ([PairingID], [PlayerID], [IsWhite], [Mark]) VALUES (41, 20, NULL, NULL)
INSERT [dbo].[PlayerInPair] ([PairingID], [PlayerID], [IsWhite], [Mark]) VALUES (41, 21, NULL, NULL)
INSERT [dbo].[PlayerInPair] ([PairingID], [PlayerID], [IsWhite], [Mark]) VALUES (42, 16, NULL, NULL)
INSERT [dbo].[PlayerInPair] ([PairingID], [PlayerID], [IsWhite], [Mark]) VALUES (42, 22, NULL, NULL)
INSERT [dbo].[PlayerInPair] ([PairingID], [PlayerID], [IsWhite], [Mark]) VALUES (43, 16, NULL, NULL)
INSERT [dbo].[PlayerInPair] ([PairingID], [PlayerID], [IsWhite], [Mark]) VALUES (43, 18, NULL, NULL)
/****** Object:  StoredProcedure [dbo].[PairingManagement_GetListPairingInTourRound]    Script Date: 09/20/2019 16:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PairingManagement_GetListPairingInTourRound]
	@RoundID		INT			= 0,
	@TourID			INT			= 0
AS
BEGIN
	SET			NOCOUNT ON
	SELECT      Pairing.PairingID,
				Pairing.StartTime,
				Pairing.EndTime
	FROM        Pairing 
	WHERE		Pairing.RoundID = @RoundID
				AND Pairing.TourID = @TourID
END
GO
/****** Object:  StoredProcedure [dbo].[PlayerManagement_GetListPlayerHigherMarkInTournament]    Script Date: 09/20/2019 16:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PlayerManagement_GetListPlayerHigherMarkInTournament]
	@TourID			INT			= 0
AS
BEGIN
	SELECT			TOP(5)
					Player.PlayerID,
					Player.Name,
					Player.FIDEId,
					Federation.FederationID,
					Federation.Name,
					Federation.Flag,
					Tournament.TournamentID,
					Tournament.Name,
					SUM(dbo.PlayerInPair.Mark) AS TotalMark		
	FROM			Player 
					INNER JOIN Federation
						ON Player.FederationID = Federation.FederationID
							INNER JOIN PlayerInPair 
								ON Player.PlayerID = dbo.PlayerInPair.PlayerID 
								INNER JOIN dbo.Pairing 
									ON PlayerInPair.PairingID = Pairing.PairingID
									INNER JOIN Tournament
										ON	Tournament.TournamentID = Pairing.TourID
	WHERE			Pairing.TourID = @TourID
	GROUP BY		Player.PlayerID, 
					Player.Name, 
					Player.FIDEId,
					Pairing.TourID, 
					Federation.FederationID, 
					Federation.Name, 
					Federation.Flag,
					Tournament.TournamentID,
					Tournament.Name
	ORDER BY		TotalMark DESC
END
GO
/****** Object:  StoredProcedure [dbo].[PlayerManagement_GetPlayersInTournamentByFederation]    Script Date: 09/20/2019 16:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PlayerManagement_GetPlayersInTournamentByFederation]
	@TourID				INT				= 0,
	@FederationID		INT				= 0
AS
BEGIN
	SET NOCOUNT ON
	SELECT					Player.PlayerID,
							Player.Name,
							Player.Birthdate,
							Player.Image,
							Player.Rating,
							Player.Sex,
							Player.FideID,
							Federation.FederationID,
							Federation.Name,
							Federation.Flag
	FROM					Federation 
	INNER JOIN				Player 
		ON					Federation.FederationID = Player.FederationID 
		INNER JOIN			PlayerInPair 
			ON				Player.PlayerID = PlayerInPair.PlayerID 
			INNER JOIN		Pairing 
				ON			PlayerInPair.PairingID = Pairing.PairingID
				INNER JOIN	Tournament
					ON		Pairing.TourID = Tournament.TournamentID
	WHERE					(Tournament.ParentTourID = @TourID
		OR					Tournament.TournamentID = @TourID)
		AND					Player.FederationID = @FederationID
END
GO
/****** Object:  StoredProcedure [dbo].[PlayerInPairManagement_GetPlayerInPairByPairingID]    Script Date: 09/20/2019 16:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PlayerInPairManagement_GetPlayerInPairByPairingID]
	@PairingID		INT			= 0
AS
BEGIN
	SET			NOCOUNT ON
	SELECT		PlayerInPair.PairingID,
				PlayerInPair.Mark,
				Player.Name,
				Federation.Flag,
				Federation.Name
	FROM        PlayerInPair 
	INNER JOIN	Player 
			ON PlayerInPair.PlayerID = Player.PlayerID
			INNER JOIN Federation
				ON Player.FederationID = Federation.FederationID
	WHERE		PlayerInPair.PairingID = @PairingID
				
END
GO
/****** Object:  StoredProcedure [dbo].[PairingManagement_GetListPairingInTourRoundOfFederation]    Script Date: 09/20/2019 16:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PairingManagement_GetListPairingInTourRoundOfFederation]
	@RoundID					INT				= 0,
	@TourID						INT				= 0,
	@FederationID				INT				= 0
AS
BEGIN
	SET							NOCOUNT ON
	SELECT						Pairing.PairingID,
								Pairing.StartTime,
								Pairing.EndTime
	FROM						Player 
		INNER JOIN				PlayerInPair 
			ON					Player.PlayerID = PlayerInPair.PlayerID 
			INNER JOIN			Pairing 
				ON				PlayerInPair.PairingID = Pairing.PairingID 
				INNER JOIN		TourRound 
					ON			Pairing.TourID = TourRound.TourID 
					AND			Pairing.RoundID = TourRound.RoundID 
					INNER JOIN	Tournament 
					ON			TourRound.TourID =	Tournament.TournamentID
	WHERE						Tournament.ParentTourID = @TourID
		AND						Pairing.RoundID = @RoundID
		AND						Player.FederationID = @FederationID
		AND						Pairing.StartTime >= GETDATE()
	ORDER BY					Pairing.StartTime ASC
END
GO
/****** Object:  ForeignKey [FK_Tournament_Form]    Script Date: 09/20/2019 16:37:34 ******/
ALTER TABLE [dbo].[Tournament]  WITH CHECK ADD  CONSTRAINT [FK_Tournament_Form] FOREIGN KEY([FormID])
REFERENCES [dbo].[Form] ([ID])
GO
ALTER TABLE [dbo].[Tournament] CHECK CONSTRAINT [FK_Tournament_Form]
GO
/****** Object:  ForeignKey [FK_Tournament_National]    Script Date: 09/20/2019 16:37:34 ******/
ALTER TABLE [dbo].[Tournament]  WITH CHECK ADD  CONSTRAINT [FK_Tournament_National] FOREIGN KEY([FederationID])
REFERENCES [dbo].[Federation] ([FederationID])
GO
ALTER TABLE [dbo].[Tournament] CHECK CONSTRAINT [FK_Tournament_National]
GO
/****** Object:  ForeignKey [FK_Tournament_Tournament]    Script Date: 09/20/2019 16:37:34 ******/
ALTER TABLE [dbo].[Tournament]  WITH CHECK ADD  CONSTRAINT [FK_Tournament_Tournament] FOREIGN KEY([ParentTourID])
REFERENCES [dbo].[Tournament] ([TournamentID])
GO
ALTER TABLE [dbo].[Tournament] CHECK CONSTRAINT [FK_Tournament_Tournament]
GO
/****** Object:  ForeignKey [FK_Player_Federation]    Script Date: 09/20/2019 16:37:34 ******/
ALTER TABLE [dbo].[Player]  WITH CHECK ADD  CONSTRAINT [FK_Player_Federation] FOREIGN KEY([FederationID])
REFERENCES [dbo].[Federation] ([FederationID])
GO
ALTER TABLE [dbo].[Player] CHECK CONSTRAINT [FK_Player_Federation]
GO
/****** Object:  ForeignKey [FK_User_Role]    Script Date: 09/20/2019 16:37:34 ******/
ALTER TABLE [dbo].[User]  WITH CHECK ADD  CONSTRAINT [FK_User_Role] FOREIGN KEY([RoleID])
REFERENCES [dbo].[Role] ([ID])
GO
ALTER TABLE [dbo].[User] CHECK CONSTRAINT [FK_User_Role]
GO
/****** Object:  ForeignKey [FK_TourRound_Round]    Script Date: 09/20/2019 16:37:34 ******/
ALTER TABLE [dbo].[TourRound]  WITH CHECK ADD  CONSTRAINT [FK_TourRound_Round] FOREIGN KEY([RoundID])
REFERENCES [dbo].[Round] ([ID])
GO
ALTER TABLE [dbo].[TourRound] CHECK CONSTRAINT [FK_TourRound_Round]
GO
/****** Object:  ForeignKey [FK_TourRound_Tournament]    Script Date: 09/20/2019 16:37:34 ******/
ALTER TABLE [dbo].[TourRound]  WITH CHECK ADD  CONSTRAINT [FK_TourRound_Tournament] FOREIGN KEY([TourID])
REFERENCES [dbo].[Tournament] ([TournamentID])
GO
ALTER TABLE [dbo].[TourRound] CHECK CONSTRAINT [FK_TourRound_Tournament]
GO
/****** Object:  ForeignKey [FK_TourGroup_Group]    Script Date: 09/20/2019 16:37:34 ******/
ALTER TABLE [dbo].[TourGroup]  WITH CHECK ADD  CONSTRAINT [FK_TourGroup_Group] FOREIGN KEY([GroupID])
REFERENCES [dbo].[Group] ([ID])
GO
ALTER TABLE [dbo].[TourGroup] CHECK CONSTRAINT [FK_TourGroup_Group]
GO
/****** Object:  ForeignKey [FK_TourGroup_Tournament]    Script Date: 09/20/2019 16:37:34 ******/
ALTER TABLE [dbo].[TourGroup]  WITH CHECK ADD  CONSTRAINT [FK_TourGroup_Tournament] FOREIGN KEY([TournamentID])
REFERENCES [dbo].[Tournament] ([TournamentID])
GO
ALTER TABLE [dbo].[TourGroup] CHECK CONSTRAINT [FK_TourGroup_Tournament]
GO
/****** Object:  ForeignKey [FK_TourForm_Form]    Script Date: 09/20/2019 16:37:34 ******/
ALTER TABLE [dbo].[TourForm]  WITH CHECK ADD  CONSTRAINT [FK_TourForm_Form] FOREIGN KEY([FormID])
REFERENCES [dbo].[Form] ([ID])
GO
ALTER TABLE [dbo].[TourForm] CHECK CONSTRAINT [FK_TourForm_Form]
GO
/****** Object:  ForeignKey [FK_TourForm_Tournament]    Script Date: 09/20/2019 16:37:34 ******/
ALTER TABLE [dbo].[TourForm]  WITH CHECK ADD  CONSTRAINT [FK_TourForm_Tournament] FOREIGN KEY([TourID])
REFERENCES [dbo].[Tournament] ([TournamentID])
GO
ALTER TABLE [dbo].[TourForm] CHECK CONSTRAINT [FK_TourForm_Tournament]
GO
/****** Object:  ForeignKey [FK_FederationParticipate_Federation]    Script Date: 09/20/2019 16:37:34 ******/
ALTER TABLE [dbo].[FederationParticipate]  WITH CHECK ADD  CONSTRAINT [FK_FederationParticipate_Federation] FOREIGN KEY([FederationID])
REFERENCES [dbo].[Federation] ([FederationID])
GO
ALTER TABLE [dbo].[FederationParticipate] CHECK CONSTRAINT [FK_FederationParticipate_Federation]
GO
/****** Object:  ForeignKey [FK_FederationParticipate_Tournament]    Script Date: 09/20/2019 16:37:34 ******/
ALTER TABLE [dbo].[FederationParticipate]  WITH CHECK ADD  CONSTRAINT [FK_FederationParticipate_Tournament] FOREIGN KEY([TourID])
REFERENCES [dbo].[Tournament] ([TournamentID])
GO
ALTER TABLE [dbo].[FederationParticipate] CHECK CONSTRAINT [FK_FederationParticipate_Tournament]
GO
/****** Object:  ForeignKey [FK_Pairing_TourRound2]    Script Date: 09/20/2019 16:37:34 ******/
ALTER TABLE [dbo].[Pairing]  WITH CHECK ADD  CONSTRAINT [FK_Pairing_TourRound2] FOREIGN KEY([TourID], [RoundID])
REFERENCES [dbo].[TourRound] ([TourID], [RoundID])
GO
ALTER TABLE [dbo].[Pairing] CHECK CONSTRAINT [FK_Pairing_TourRound2]
GO
/****** Object:  ForeignKey [FK_PlayerInPair_Pairing]    Script Date: 09/20/2019 16:37:34 ******/
ALTER TABLE [dbo].[PlayerInPair]  WITH CHECK ADD  CONSTRAINT [FK_PlayerInPair_Pairing] FOREIGN KEY([PairingID])
REFERENCES [dbo].[Pairing] ([PairingID])
GO
ALTER TABLE [dbo].[PlayerInPair] CHECK CONSTRAINT [FK_PlayerInPair_Pairing]
GO
/****** Object:  ForeignKey [FK_PlayerInPair_Player]    Script Date: 09/20/2019 16:37:34 ******/
ALTER TABLE [dbo].[PlayerInPair]  WITH CHECK ADD  CONSTRAINT [FK_PlayerInPair_Player] FOREIGN KEY([PlayerID])
REFERENCES [dbo].[Player] ([PlayerID])
GO
ALTER TABLE [dbo].[PlayerInPair] CHECK CONSTRAINT [FK_PlayerInPair_Player]
GO
