USE [master]
GO
/****** Object:  Database [DBTeam]    Script Date: 28/1/2025 04:40:52 PM ******/
CREATE DATABASE [DBTeam]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'DBTeam', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\DBTeam.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'DBTeam_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\DBTeam_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [DBTeam] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [DBTeam].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [DBTeam] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [DBTeam] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [DBTeam] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [DBTeam] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [DBTeam] SET ARITHABORT OFF 
GO
ALTER DATABASE [DBTeam] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [DBTeam] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [DBTeam] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [DBTeam] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [DBTeam] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [DBTeam] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [DBTeam] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [DBTeam] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [DBTeam] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [DBTeam] SET  ENABLE_BROKER 
GO
ALTER DATABASE [DBTeam] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [DBTeam] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [DBTeam] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [DBTeam] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [DBTeam] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [DBTeam] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [DBTeam] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [DBTeam] SET RECOVERY FULL 
GO
ALTER DATABASE [DBTeam] SET  MULTI_USER 
GO
ALTER DATABASE [DBTeam] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [DBTeam] SET DB_CHAINING OFF 
GO
ALTER DATABASE [DBTeam] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [DBTeam] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [DBTeam] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [DBTeam] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'DBTeam', N'ON'
GO
ALTER DATABASE [DBTeam] SET QUERY_STORE = OFF
GO
USE [DBTeam]
GO
/****** Object:  Table [dbo].[clientes]    Script Date: 28/1/2025 04:40:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[clientes](
	[codigo] [varchar](5) NULL,
	[nombre] [varchar](50) NULL,
	[edad] [int] NULL,
	[telefono] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[sp_buscar_clientes]    Script Date: 28/1/2025 04:40:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create proc [dbo].[sp_buscar_clientes]
@nombre varchar(50)
as
select codigo,nombre,edad,telefono from clientes where nombre like @nombre + '%'
GO
/****** Object:  StoredProcedure [dbo].[sp_listar_clientes]    Script Date: 28/1/2025 04:40:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create proc [dbo].[sp_listar_clientes]
as
select * from clientes order by codigo
GO
/****** Object:  StoredProcedure [dbo].[sp_mantenimiento_clientes]    Script Date: 28/1/2025 04:40:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create proc [dbo].[sp_mantenimiento_clientes]
@codigo varchar(5),
@nombre varchar(50),
@edad int,
@telefono int,
@accion varchar(50) output
as
if (@accion='1')
begin
declare @codnuevo varchar(5), @codmax varchar(5)
set @codmax = (select max(codigo) from clientes)
set @codmax = isnull(@codmax,'A0000')
set @codnuevo = 'A'+RIGHT(RIGHT(@codmax,4)+10001,4)
insert into clientes(codigo,nombre,edad,telefono)
values(@codnuevo,@nombre,@edad,@telefono)
set @accion='se genero el codigo; ' +@codnuevo
end
else if (@accion='2')
begin
update clientes set nombre=nombre, edad=@edad, telefono=@telefono where codigo=@codigo
set @accion='se modifico el codigo; ' +@codigo
end
else if (@accion='3')
begin
delete from clientes where codigo=@codigo
set @accion='se borro el codigo; ' +@codigo
end
GO
USE [master]
GO
ALTER DATABASE [DBTeam] SET  READ_WRITE 
GO
