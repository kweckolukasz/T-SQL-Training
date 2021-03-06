/*
This script has 3 parts:

1. Create database
2. Load tables
3. Sample queries

You can run this entire script at one time to create and populate the database.

*/
--1. Create database

USE [master]
GO
/****** Object:  Database [QewbiJoins]    Script Date: 9/16/2018 11:55:33 PM ******/
CREATE DATABASE [QewbiJoins]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'QewbiJoins', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.LOCALDB\MSSQL\DATA\QewbiJoins.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'QewbiJoins_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.LOCALDB\MSSQL\DATA\QewbiJoins_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [QewbiJoins] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [QewbiJoins].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [QewbiJoins] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [QewbiJoins] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [QewbiJoins] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [QewbiJoins] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [QewbiJoins] SET ARITHABORT OFF 
GO
ALTER DATABASE [QewbiJoins] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [QewbiJoins] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [QewbiJoins] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [QewbiJoins] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [QewbiJoins] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [QewbiJoins] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [QewbiJoins] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [QewbiJoins] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [QewbiJoins] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [QewbiJoins] SET  DISABLE_BROKER 
GO
ALTER DATABASE [QewbiJoins] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [QewbiJoins] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [QewbiJoins] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [QewbiJoins] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [QewbiJoins] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [QewbiJoins] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [QewbiJoins] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [QewbiJoins] SET RECOVERY FULL 
GO
ALTER DATABASE [QewbiJoins] SET  MULTI_USER 
GO
ALTER DATABASE [QewbiJoins] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [QewbiJoins] SET DB_CHAINING OFF 
GO
ALTER DATABASE [QewbiJoins] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [QewbiJoins] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [QewbiJoins] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'QewbiJoins', N'ON'
GO
ALTER DATABASE [QewbiJoins] SET QUERY_STORE = OFF
GO
USE [QewbiJoins]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
USE [QewbiJoins]
GO
/****** Object:  Table [dbo].[Customer]    Script Date: 9/16/2018 11:55:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer](
	[CustomerId] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](50) NULL,
	[LastName] [nvarchar](50) NULL,
 CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED 
(
	[CustomerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Product]    Script Date: 9/16/2018 11:55:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[ProductId] [int] IDENTITY(1,1) NOT NULL,
	[ProductName] [nvarchar](50) NULL,
	[ProductPrice] [money] NULL,
 CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED 
(
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Sale]    Script Date: 9/16/2018 11:55:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sale](
	[SaleId] [int] IDENTITY(1,1) NOT NULL,
	[CustomerId] [int] NULL,
	[OrderDate] [date] NULL,
 CONSTRAINT [PK_Sale] PRIMARY KEY CLUSTERED 
(
	[SaleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SaleDetail]    Script Date: 9/16/2018 11:55:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SaleDetail](
	[SaleDetailId] [int] NULL,
	[SaleId] [int] NULL,
	[ProductId] [int] NULL,
	[Quantity] [int] NULL
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Customer] ON 


-- 2. Populate tables

INSERT [dbo].[Customer] ([CustomerId], [FirstName], [LastName]) VALUES (1, N'Rachel', N'Starr')
INSERT [dbo].[Customer] ([CustomerId], [FirstName], [LastName]) VALUES (2, N'David', N'Miller')
INSERT [dbo].[Customer] ([CustomerId], [FirstName], [LastName]) VALUES (3, N'Todd', N'Woodman')
INSERT [dbo].[Customer] ([CustomerId], [FirstName], [LastName]) VALUES (4, N'Cynthia', N'Martin')
SET IDENTITY_INSERT [dbo].[Customer] OFF
SET IDENTITY_INSERT [dbo].[Product] ON 

INSERT [dbo].[Product] ([ProductId], [ProductName], [ProductPrice]) VALUES (1, N'Milk', 1.9500)
INSERT [dbo].[Product] ([ProductId], [ProductName], [ProductPrice]) VALUES (2, N'Eggs', 2.2000)
INSERT [dbo].[Product] ([ProductId], [ProductName], [ProductPrice]) VALUES (3, N'Orange Juice', 3.8900)
INSERT [dbo].[Product] ([ProductId], [ProductName], [ProductPrice]) VALUES (4, N'Bread', 2.6500)
INSERT [dbo].[Product] ([ProductId], [ProductName], [ProductPrice]) VALUES (5, N'Frozen Pizza', 4.5500)
SET IDENTITY_INSERT [dbo].[Product] OFF
SET IDENTITY_INSERT [dbo].[Sale] ON 

INSERT [dbo].[Sale] ([SaleId], [CustomerId], [OrderDate]) VALUES (1, 2, CAST(N'2013-02-14' AS Date))
INSERT [dbo].[Sale] ([SaleId], [CustomerId], [OrderDate]) VALUES (2, 4, CAST(N'2013-02-15' AS Date))
INSERT [dbo].[Sale] ([SaleId], [CustomerId], [OrderDate]) VALUES (3, 1, CAST(N'2013-02-25' AS Date))
INSERT [dbo].[Sale] ([SaleId], [CustomerId], [OrderDate]) VALUES (4, 2, CAST(N'2013-03-09' AS Date))
INSERT [dbo].[Sale] ([SaleId], [CustomerId], [OrderDate]) VALUES (5, 4, CAST(N'2013-03-14' AS Date))
INSERT [dbo].[Sale] ([SaleId], [CustomerId], [OrderDate]) VALUES (6, 1, CAST(N'2013-03-14' AS Date))
INSERT [dbo].[Sale] ([SaleId], [CustomerId], [OrderDate]) VALUES (7, 4, CAST(N'2013-03-26' AS Date))
INSERT [dbo].[Sale] ([SaleId], [CustomerId], [OrderDate]) VALUES (8, 2, CAST(N'2013-04-08' AS Date))
INSERT [dbo].[Sale] ([SaleId], [CustomerId], [OrderDate]) VALUES (9, 4, CAST(N'2013-04-17' AS Date))
SET IDENTITY_INSERT [dbo].[Sale] OFF
INSERT [dbo].[SaleDetail] ([SaleDetailId], [SaleId], [ProductId], [Quantity]) VALUES (NULL, 1, 2, 4)
INSERT [dbo].[SaleDetail] ([SaleDetailId], [SaleId], [ProductId], [Quantity]) VALUES (NULL, 1, 1, 2)
INSERT [dbo].[SaleDetail] ([SaleDetailId], [SaleId], [ProductId], [Quantity]) VALUES (NULL, 2, 5, 1)
INSERT [dbo].[SaleDetail] ([SaleDetailId], [SaleId], [ProductId], [Quantity]) VALUES (NULL, 3, 1, 3)
INSERT [dbo].[SaleDetail] ([SaleDetailId], [SaleId], [ProductId], [Quantity]) VALUES (NULL, 3, 3, 1)
INSERT [dbo].[SaleDetail] ([SaleDetailId], [SaleId], [ProductId], [Quantity]) VALUES (NULL, 3, 2, 2)
INSERT [dbo].[SaleDetail] ([SaleDetailId], [SaleId], [ProductId], [Quantity]) VALUES (NULL, 4, 5, 1)
INSERT [dbo].[SaleDetail] ([SaleDetailId], [SaleId], [ProductId], [Quantity]) VALUES (NULL, 4, 3, 2)
INSERT [dbo].[SaleDetail] ([SaleDetailId], [SaleId], [ProductId], [Quantity]) VALUES (NULL, 5, 4, 4)
INSERT [dbo].[SaleDetail] ([SaleDetailId], [SaleId], [ProductId], [Quantity]) VALUES (NULL, 6, 3, 2)
INSERT [dbo].[SaleDetail] ([SaleDetailId], [SaleId], [ProductId], [Quantity]) VALUES (NULL, 6, 2, 1)
INSERT [dbo].[SaleDetail] ([SaleDetailId], [SaleId], [ProductId], [Quantity]) VALUES (NULL, 7, 5, 3)
INSERT [dbo].[SaleDetail] ([SaleDetailId], [SaleId], [ProductId], [Quantity]) VALUES (NULL, 8, 2, 1)
INSERT [dbo].[SaleDetail] ([SaleDetailId], [SaleId], [ProductId], [Quantity]) VALUES (NULL, 9, 4, 1)
INSERT [dbo].[SaleDetail] ([SaleDetailId], [SaleId], [ProductId], [Quantity]) VALUES (NULL, 9, 2, 1)
ALTER TABLE [dbo].[Sale]  WITH CHECK ADD  CONSTRAINT [FK_Sale_Customer] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customer] ([CustomerId])
GO
ALTER TABLE [dbo].[Sale] CHECK CONSTRAINT [FK_Sale_Customer]
GO
ALTER TABLE [dbo].[SaleDetail]  WITH CHECK ADD  CONSTRAINT [FK_SaleDetail_Product] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Product] ([ProductId])
GO
ALTER TABLE [dbo].[SaleDetail] CHECK CONSTRAINT [FK_SaleDetail_Product]
GO
ALTER TABLE [dbo].[SaleDetail]  WITH CHECK ADD  CONSTRAINT [FK_SaleDetail_Sale] FOREIGN KEY([SaleId])
REFERENCES [dbo].[Sale] ([SaleId])
GO
ALTER TABLE [dbo].[SaleDetail] CHECK CONSTRAINT [FK_SaleDetail_Sale]
GO
USE [master]
GO
ALTER DATABASE [QewbiJoins] SET  READ_WRITE 
GO


-- 3. Sample Queries

SELECT * FROM Customer;
SELECT * FROM Product;
SELECT * FROM Sale;
SELECT * FROM SaleDetail;


-- Query 1
SELECT Customer.CustomerId	FROM Customer
INNER JOIN Sale on
Customer.CustomerId = Sale.CustomerId
 

-- Query 2
SELECT DISTINCT Customer.CustomerId	FROM Customer
INNER JOIN Sale on
Customer.CustomerId = Sale.CustomerId
WHERE Sale.OrderDate BETWEEN '3/1/2013' AND '3/31/2013'

-- Query 3
SELECT DISTINCT Customer.CustomerId	FROM Customer
INNER JOIN Sale on
Customer.CustomerId = Sale.CustomerId
WHERE Sale.OrderDate BETWEEN '3/1/2013' AND '3/31/2013'

-- Query 4
SELECT DISTINCT c.CustomerId FROM Customer c
INNER JOIN Sale s on
c.CustomerId = s.CustomerId
WHERE s.OrderDate BETWEEN '3/1/2013' AND '3/31/2013'

-- Query 5
SELECT DISTINCT c.CustomerId FROM Customer c
INNER JOIN Sale s on
c.CustomerId = s.CustomerId
JOIN SaleDetail sd ON -- Note that the keyword "INNER" is optional for INNER JOINS
s.SaleId = sd.SaleId
WHERE s.OrderDate BETWEEN '3/1/2013' AND '3/31/2013'

-- Query 6
SELECT c.FirstName, c.LastName, s.OrderDate, sd.ProductId FROM Customer c
INNER JOIN Sale s on
c.CustomerId = s.CustomerId
JOIN SaleDetail sd ON -- Note that the keyword "INNER" is optional for INNER JOINS
s.SaleId = sd.SaleId
WHERE s.OrderDate BETWEEN '3/1/2013' AND '3/31/2013'

-- Query 7
SELECT c.FirstName, c.LastName, s.OrderDate, p.ProductName, sd.Quantity, sd.Quantity * p.ProductPrice AS TotalPrice  FROM Customer c
INNER JOIN Sale s on
c.CustomerId = s.CustomerId
JOIN SaleDetail sd ON -- Note that the keyword "INNER" is optional for INNER JOINS
s.SaleId = sd.SaleId
JOIN Product p
on sd.ProductId = p.ProductId
WHERE s.OrderDate BETWEEN '3/1/2013' AND '3/31/2013'

-- Query 8
SELECT c.FirstName, c.LastName, p.ProductName,  SUM(sd.Quantity * p.ProductPrice) AS TotalPrice  FROM Customer c
INNER JOIN Sale s on
c.CustomerId = s.CustomerId
JOIN SaleDetail sd ON -- Note that the keyword "INNER" is optional for INNER JOINS
s.SaleId = sd.SaleId
JOIN Product p
on sd.ProductId = p.ProductId
WHERE s.OrderDate BETWEEN '3/1/2013' AND '3/31/2013'
GROUP BY c.FirstName, c.LastName, p.ProductName

