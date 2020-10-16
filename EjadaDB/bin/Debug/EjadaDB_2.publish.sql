﻿/*
Deployment script for EjadaDB

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "EjadaDB"
:setvar DefaultFilePrefix "EjadaDB"
:setvar DefaultDataPath "C:\Users\andre\AppData\Local\Microsoft\Microsoft SQL Server Local DB\Instances\MSSQLLocalDB\"
:setvar DefaultLogPath "C:\Users\andre\AppData\Local\Microsoft\Microsoft SQL Server Local DB\Instances\MSSQLLocalDB\"

GO
:on error exit
GO
/*
Detect SQLCMD mode and disable script execution if SQLCMD mode is not supported.
To re-enable the script after enabling SQLCMD mode, execute the following:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'SQLCMD mode must be enabled to successfully execute this script.';
        SET NOEXEC ON;
    END


GO
USE [master];


GO

IF (DB_ID(N'$(DatabaseName)') IS NOT NULL) 
BEGIN
    ALTER DATABASE [$(DatabaseName)]
    SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE [$(DatabaseName)];
END

GO
PRINT N'Creating $(DatabaseName)...'
GO
CREATE DATABASE [$(DatabaseName)]
    ON 
    PRIMARY(NAME = [$(DatabaseName)], FILENAME = N'$(DefaultDataPath)$(DefaultFilePrefix)_Primary.mdf')
    LOG ON (NAME = [$(DatabaseName)_log], FILENAME = N'$(DefaultLogPath)$(DefaultFilePrefix)_Primary.ldf') COLLATE SQL_Latin1_General_CP1_CI_AS
GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CLOSE OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
USE [$(DatabaseName)];


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ANSI_NULLS ON,
                ANSI_PADDING ON,
                ANSI_WARNINGS ON,
                ARITHABORT ON,
                CONCAT_NULL_YIELDS_NULL ON,
                NUMERIC_ROUNDABORT OFF,
                QUOTED_IDENTIFIER ON,
                ANSI_NULL_DEFAULT ON,
                CURSOR_DEFAULT LOCAL,
                CURSOR_CLOSE_ON_COMMIT OFF,
                AUTO_CREATE_STATISTICS ON,
                AUTO_SHRINK OFF,
                AUTO_UPDATE_STATISTICS ON,
                RECURSIVE_TRIGGERS OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ALLOW_SNAPSHOT_ISOLATION OFF;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET READ_COMMITTED_SNAPSHOT OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_UPDATE_STATISTICS_ASYNC OFF,
                PAGE_VERIFY NONE,
                DATE_CORRELATION_OPTIMIZATION OFF,
                DISABLE_BROKER,
                PARAMETERIZATION SIMPLE,
                SUPPLEMENTAL_LOGGING OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET TRUSTWORTHY OFF,
        DB_CHAINING OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'The database settings cannot be modified. You must be a SysAdmin to apply these settings.';
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET HONOR_BROKER_PRIORITY OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'The database settings cannot be modified. You must be a SysAdmin to apply these settings.';
    END


GO
ALTER DATABASE [$(DatabaseName)]
    SET TARGET_RECOVERY_TIME = 0 SECONDS 
    WITH ROLLBACK IMMEDIATE;


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET FILESTREAM(NON_TRANSACTED_ACCESS = OFF),
                CONTAINMENT = NONE 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CREATE_STATISTICS ON(INCREMENTAL = OFF),
                MEMORY_OPTIMIZED_ELEVATE_TO_SNAPSHOT = OFF,
                DELAYED_DURABILITY = DISABLED 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE (QUERY_CAPTURE_MODE = ALL, DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_PLANS_PER_QUERY = 200, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 367), MAX_STORAGE_SIZE_MB = 100) 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE = OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
    END


GO
IF fulltextserviceproperty(N'IsFulltextInstalled') = 1
    EXECUTE sp_fulltext_database 'enable';


GO
PRINT N'Creating [DataLibrary]...';


GO
CREATE ASSEMBLY [DataLibrary]
    AUTHORIZATION [dbo]
    FROM 0x4D5A90000300000004000000FFFF0000B800000000000000400000000000000000000000000000000000000000000000000000000000000000000000800000000E1FBA0E00B409CD21B8014CCD21546869732070726F6772616D2063616E6E6F742062652072756E20696E20444F53206D6F64652E0D0D0A2400000000000000504500004C010300737CA3E40000000000000000E00022200B013000002000000006000000000000A63E0000002000000040000000000010002000000002000004000000000000000600000000000000008000000002000000000000030060850000100000100000000010000010000000000000100000000000000000000000533E00004F000000004000008803000000000000000000000000000000000000006000000C000000C03D0000380000000000000000000000000000000000000000000000000000000000000000000000000000000000000000200000080000000000000000000000082000004800000000000000000000002E74657874000000AC1E0000002000000020000000020000000000000000000000000000200000602E7273726300000088030000004000000004000000220000000000000000000000000000400000402E72656C6F6300000C0000000060000000020000002600000000000000000000000000004000004200000000000000000000000000000000873E0000000000004800000002000500282400009819000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001E027B010000042A2202037D010000042A1E027B020000042A2202037D020000042A1E027B030000042A2202037D030000042A2202281100000A002A1E027B040000042A2202037D040000042A1E027B050000042A2202037D050000042A1E027B060000042A2202037D060000042A1E027B070000042A2202037D070000042A1E027B080000042A2202037D080000042A1E027B090000042A2202037D090000042A2202281100000A002A1E027B0A0000042A2202037D0A0000042A1E027B0B0000042A2202037D0B0000042A1E027B0C0000042A2202037D0C0000042A1E027B0D0000042A2202037D0D0000042A2202281100000A002A13300200160000000100001100281200000A026F1300000A6F1400000A0A2B00062A00001B3007004300000002000011007201000070281E000006731500000A0A0006021414171201FE150100001B071202FE150200001B08280100002B280200002B0DDE0B062C07066F1800000A00DC092A0001100000020011002536000B000000001B3006004200000003000011007201000070281E000006731500000A0A000602038C0300001B141201FE150100001B071202FE150200001B08281900000A0DDE0B062C07066F1800000A00DC092A000001100000020011002435000B0000000013300300290000000400001100730700000625026F040000060025036F06000006000A72110000700B0706280300002B0C2B00082A0000001330010012000000050000110072EE0000700A06280400002B0B2B00072A000013300300420000000600001100731400000625026F0B0000060025036F0D0000060025046F0F0000060025056F1100000600250E046F13000006000A728D0100700B0706280500002B0C2B00082A00001330010012000000050000110072E60200700A06280400002B0B2B00072A0000133005008B0000000700001100731A00000A1F108D23000001250A6F1B00000A00040620A0860100731C00000A0B071F146F1D00000A0C1F248D230000010D061609161F10281E00000A000816091F101F14281E00000A0009281F00000A1304731D00000625026F180000060025036F1A000006002511046F1C00000600130572BB030070130611061105280600002B13072B0011072A00133005008E000000080000110072BC040070027220050070282000000A0A06280700002B166F2100000A0B07282200000A0C1F108D230000010D081609161F10281E00000A00030920A0860100731C00000A130411041F146F1D00000A13051613062B220811061F1058911105110691FE0116FE01130711072C051613082B1711061758130611061F14FE04130911092DD21713082B0011082A000042534A4201000100000000000C00000076342E302E33303331390000000005006C000000F0080000237E00005C0900006408000023537472696E677300000000C01100002805000023555300E8160000100000002347554944000000F8160000A002000023426C6F620000000000000002000001571DA209090C000000FA0133001600000100000028000000080000000D000000260000001D00000022000000010000004200000008000000030000000D0000001A0000000400000001000000050000000200000007000000000031050100000000000600E603CE0606005304CE060600FF029C060F00EE0600000600420379050600C90379050600AA03790506003A04790506000604790506001F04790506005903790506002E03AF060600F102AF0606008D0379050600740384040600CD074E050600D602CE060600BF029C06060013039C0606001A0086000A00AE054000060001004E050A009F02400006000B072D080E001B0655050E008B0555050E003D0755050A00BC05D40712003706300606000C0086000A006A05400016003002F60506003B024E05060002062D08060079044E05060080062D08060012072D08060027084E05060018084E050600E0044E05000000002100000000000100010001001000FF04560741000100010000001000E704560741000400080001001000F504560741000A001500810110007F07690741000E001E00810110006C066C0041000E002100810110004C066C0041000E002300810110005E066C0041000E0025000100C9005D010100130160010100770160010100C9005D010100290160010100B2005D010100940160010100FB005D010100B1015D010100C9005D0101004201600101005C0160010100DD0060015020000000008608A100630101005820000000008608A80001000100612000000000860847022F00020069200000000086085002100002007220000000008608CA052F0003007A20000000008608DA051000030083200000000086189606060004008C20000000008608A100630104009420000000008608A800010004009D2000000000860868022F000500A520000000008608740210000500AE200000000086082A0063010600B620000000008608340001000600BF200000000086088D072F000700C7200000000086089D0710000700D020000000008608160263010800D820000000008608210201000800E120000000008608FB0763010900E920000000008608070801000900F220000000008618960606000A00FB20000000008608A10063010A000321000000008608A80001000A000C2100000000860880022F000B0014210000000086088D0210000B001D210000000086080F052F000C0025210000000086081D0510000C002E21000000008608CA012F000D003621000000008608DB0110000D003F21000000008618960606000E004821000000009600D30467010E006C210000000096004C006C010F00CC210000000096005500770110002C22000000009600EA077F0112006422000000009600B60785011400842200000000960007028E011400D422000000009600FD0685011900F4220000000096004106970119008C23000000009600EC019E011C00000001007E04000001007E04000001007E04000001007E04000001007E04000001007E04000001007E04000001007E04000001007E04000001007E04000001007E04000001007E04000001007E04101001005902000001004105000001004105000002005E00000001009A0200000200EA05000001009A0200000200AF0000000300AD07000004002C02000005001308000001009A02000002002B0500000300FE01000001002B0500000200FE01090096060100110096060600190096060A00290096061000310096061000390096061000410096061000490096061000510096061000590096061000610096061500690096061000710096061000790096061000890096060600990096061A00810096060600C90027072400D10045052900D900BE042F00E10096061000E9005B0856000101200877000901B7020600E90071049B0011019606060021011E07E200C1009606E80029011E07F00031014A08F6003901AF0403014101C6071F0124004505300139019E0436010E0039004E0120007B00910221007B0091022100830096022E000B00AC012E001300B5012E001B00D4012E002300DD012E002B00EE012E003300EE012E003B00EE012E004300DD012E004B00F4012E005300EE012E005B00EE012E0063000C022E006B0036022E007300430240007B00910241007B00910241008300960260007B00910261007B00910261008300960280007B00910281007B009102810083009602A0007B009102A1007B009102A10083009602C0007B009102C1007B009102C10083009602E1007B009102E1008300960200017B00910201017B00910201018300960220017B00910221017B00910221018300960240017B00910241017B00910241018300960260017B00910261017B00910261018300960280017B00910281017B009102810183009602A0017B009102A1017B009102A10183009602C0017B009102E0017B00910200027B00910220027B00910240027B00910260027B009102A0027B009102C0027B009102E0027B00910200037B00910220037B00910240037B00910260037B00910280037B009102200033008700B000BC00C600D2000E01020001000300040004000A000000AC00A40100009502A8010000DE05A8010000AC00A40100007802A80100003800A4010000A107A80100002502A40100000B08A4010000AC00A40100009102A80100002105A8010000F101A80102000100030001000200030002000300050001000400050002000500070001000600070002000800090001000900090002000A000B0001000B000B0002000C000D0001000D000D0002000E000F0001000F000F0002001000110001001100110002001200130001001300130002001500150001001600150002001700170001001800170002001900190001001A00190002001B001B0001001C001B0049004F0098002A010480000001000000000000000000000000004F0800000400000000000000000000003C016300000000000400000000000000000000003C01400000000000040000000000000000000000450155050000000002000000000000000000000000003006000000000400000000000000000000003C01AB0200000000000000003F003E000000000041003E002D0072002F0072004000B7003E00B7004000CD00400009013E00260100000000004E756C6C61626C6560310049456E756D657261626C656031004C6973746031003C4D6F64756C653E006765745F456D704944007365745F456D70494400540053797374656D2E44617461004C6F6164446174610053617665446174610064617461006D73636F726C696200446174614C6962726172792E427573696E6573734C6F6769630053797374656D2E436F6C6C656374696F6E732E47656E65726963006765745F4964007365745F4964006964003C456D7049443E6B5F5F4261636B696E674669656C64003C49643E6B5F5F4261636B696E674669656C64003C5573657250617373776F72643E6B5F5F4261636B696E674669656C64003C456D704167653E6B5F5F4261636B696E674669656C64003C4E616D653E6B5F5F4261636B696E674669656C64003C456D704E616D653E6B5F5F4261636B696E674669656C64003C557365724E616D653E6B5F5F4261636B696E674669656C64003C55736572456D61696C3E6B5F5F4261636B696E674669656C64003C4465736372697074696F6E3E6B5F5F4261636B696E674669656C64003C456D70436F6E74616374733E6B5F5F4261636B696E674669656C64003C456D70446570743E6B5F5F4261636B696E674669656C64006765745F5573657250617373776F7264007365745F5573657250617373776F726400436865636B5573657250617373776F72640070617373776F726400437265617465456D706C6F796565006765745F456D70416765007365745F456D704167650061676500456E756D657261626C650049446973706F7361626C65006765745F4E616D65007365745F4E616D6500636F6E6E656374696F6E4E616D65006765745F456D704E616D65007365745F456D704E616D65006765745F557365724E616D65007365745F557365724E616D65006E616D6500436F6D6D616E64547970650053797374656D2E436F726500446973706F736500446562756767657242726F777361626C65537461746500436F6D70696C657247656E65726174656441747472696275746500477569644174747269627574650044656275676761626C6541747472696275746500446562756767657242726F777361626C6541747472696275746500436F6D56697369626C6541747472696275746500417373656D626C795469746C6541747472696275746500417373656D626C7954726164656D61726B417474726962757465005461726765744672616D65776F726B41747472696275746500417373656D626C7946696C6556657273696F6E41747472696275746500417373656D626C79436F6E66696775726174696F6E41747472696275746500417373656D626C794465736372697074696F6E41747472696275746500436F6D70696C6174696F6E52656C61786174696F6E7341747472696275746500417373656D626C7950726F6475637441747472696275746500417373656D626C79436F7079726967687441747472696275746500417373656D626C79436F6D70616E794174747269627574650052756E74696D65436F6D7061746962696C697479417474726962757465004578656375746500427974650076616C75650053797374656D2E52756E74696D652E56657273696F6E696E670046726F6D426173653634537472696E6700546F426173653634537472696E67006765745F436F6E6E656374696F6E537472696E6700476574436F6E6E656374696F6E537472696E6700456D706C6F7965654D6F64656C00557365724D6F64656C004465706172746D656E744D6F64656C006765745F55736572456D61696C007365745F55736572456D61696C00656D61696C00446174614C6962726172792E646C6C0073716C006765745F4974656D0053797374656D0053797374656D2E436F6E66696775726174696F6E004944625472616E73616374696F6E0053797374656D2E5265666C656374696F6E00436F6E6E656374696F6E537472696E6753657474696E6773436F6C6C656374696F6E00494462436F6E6E656374696F6E0053716C436F6E6E656374696F6E006765745F4465736372697074696F6E007365745F4465736372697074696F6E006465736372697074696F6E0053797374656D2E4C696E7100524E4743727970746F5365727669636550726F766964657200436F6E66696775726174696F6E4D616E61676572004461707065720053716C4D6170706572004372656174655573657200456D706C6F79656550726F636573736F72005573657250726F636573736F72004465706172746D656E7450726F636573736F720052616E646F6D4E756D62657247656E657261746F72002E63746F720053797374656D2E446961676E6F73746963730053797374656D2E52756E74696D652E496E7465726F7053657276696365730053797374656D2E52756E74696D652E436F6D70696C6572536572766963657300446562756767696E674D6F646573004C6F6164456D706C6F7965657300526663323839384465726976654279746573004765744279746573006765745F436F6E6E656374696F6E537472696E677300436F6E6E656374696F6E537472696E6753657474696E677300446174614C6962726172792E4D6F64656C7300446174614C6962726172792E4461746141636573730053716C44617461416363657373006765745F456D70436F6E7461637473007365745F456D70436F6E746163747300636F6E7461637473004C6F61644465706172746D656E747300436F6E636174004F626A6563740053797374656D2E446174612E53716C436C69656E74004372656174654465706172746D656E74006765745F456D7044657074007365745F456D7044657074006465707400436F6E7665727400546F4C6973740041727261790053797374656D2E53656375726974792E43727970746F67726170687900436F707900446174614C69627261727900517565727900000000000F45006A00610064006100440042000080DB69006E007300650072007400200069006E0074006F002000640062006F002E005B00440065007000610074006D0065006E0074005D00200028005B004E0061006D0065005D002C0020005B004400650073006300720069007000740069006F006E005D0029000D000A00200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000760061006C007500650073002000280040004E0061006D0065002C00200040004400650073006300720069007000740069006F006E0029003B0000809D730065006C006500630074002000490064002C0020004E0061006D0065002C0020004400650073006300720069007000740069006F006E000D000A00200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000660072006F006D002000640062006F002E005B00440065007000610074006D0065006E0074005D003B0000815769006E007300650072007400200069006E0074006F002000640062006F002E005B0045006D0070006C006F007900650065005D00200028005B0045006D0070004E0061006D0065005D002C0020005B0045006D007000490044005D002C0020005B0045006D00700043006F006E00740061006300740073005D002C0020005B0045006D0070004100670065005D002C0020005B0045006D00700044006500700074005D0029000D000A00200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000760061006C0075006500730020002800400045006D0070004E0061006D0065002C002000400045006D007000490044002C002000400045006D00700043006F006E00740061006300740073002C002000400045006D0070004100670065002C002000400045006D007000440065007000740029003B000080D3730065006C006500630074002000490064002C00200045006D0070004E0061006D0065002C00200045006D007000490044002C00200045006D00700043006F006E00740061006300740073002C00200045006D0070004100670065002C00200045006D00700044006500700074000D000A00200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000660072006F006D002000640062006F002E005B00440065007000610074006D0065006E0074005D003B000080FF69006E007300650072007400200069006E0074006F002000640062006F002E005B0055007300650072005D00200028005B004E0061006D0065005D002C0020005B0045006D00610069006C005D002C0020005B00500061007300730077006F00720064005D0029000D000A00200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000760061006C0075006500730020002800400055007300650072004E0061006D0065002C0020004000550073006500720045006D00610069006C002C00200040005500730065007200500061007300730077006F007200640029003B000063730065006C0065006300740020005B00500061007300730077006F00720064005D002000660072006F006D002000640062006F002E005B0055007300650072005D00200077006800650072006500200045006D00610069006C0020003D0020002700010527003B0001000084FD7854354D51498953FDEC28ABC51D00042001010803200001052001011111042001010E04200101020520010111490307010E0400001269052001126D0E0320000E1507041255151159010815115901115D151251011E000515115901080615115901115D1B100107151279011E0012550E1C127D02151159010815115901115D040A011E000F100101151251011E00151279011E001007041255151159010815115901115D08021E001400060812550E1C127D151159010815115901115D06070312080E08040A0112080907020E151251011208060703120C0E08040A01120C0F07081D0512611D051D050E12100E08052001011D05072003010E1D05080520011D05080C0005011280990812809908080500010E1D05040A01121010070A0E0E1D051D0512611D05080202020600030E0E0E0E030A010E05151251010E0520011300080500011D050E08B77A5C561934E08908B03F5F7F11D50A3A0E45006A006100640061004400420002060802060E032000080400010E0E0A100101151251011E000E07100102080E1E00050002080E0E080000151251011208080005080E080E0808060003080E0E0E050002020E0E032800080328000E0801000800000000001E01000100540216577261704E6F6E457863657074696F6E5468726F7773010801000701000000001001000B446174614C696272617279000005010000000017010012436F7079726967687420C2A920203230323000002901002434646530643266362D373735312D343661382D386166372D31613632666435386661616100000C010007312E302E302E3000004D01001C2E4E45544672616D65776F726B2C56657273696F6E3D76342E372E320100540E144672616D65776F726B446973706C61794E616D65142E4E4554204672616D65776F726B20342E372E3204010000000801000000000000000000000000C357049B00000000020000005B000000F83D0000F81F000000000000000000000000000010000000000000000000000000000000525344539B3E8DDE4296734B8FD10CC0006A745301000000433A5C55736572735C616E6472655C4465736B746F705C456A6164615C446174614C6962726172795C6F626A5C44656275675C446174614C6962726172792E706462007B3E00000000000000000000953E0000002000000000000000000000000000000000000000000000873E0000000000000000000000005F436F72446C6C4D61696E006D73636F7265652E646C6C000000000000FF250020001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001001000000018000080000000000000000000000000000001000100000030000080000000000000000000000000000001000000000048000000584000002C03000000000000000000002C0334000000560053005F00560045005200530049004F004E005F0049004E0046004F0000000000BD04EFFE00000100000001000000000000000100000000003F000000000000000400000002000000000000000000000000000000440000000100560061007200460069006C00650049006E0066006F00000000002400040000005400720061006E0073006C006100740069006F006E00000000000000B0048C020000010053007400720069006E006700460069006C00650049006E0066006F0000006802000001003000300030003000300034006200300000001A000100010043006F006D006D0065006E007400730000000000000022000100010043006F006D00700061006E0079004E0061006D006500000000000000000040000C000100460069006C0065004400650073006300720069007000740069006F006E000000000044006100740061004C006900620072006100720079000000300008000100460069006C006500560065007200730069006F006E000000000031002E0030002E0030002E003000000040001000010049006E007400650072006E0061006C004E0061006D006500000044006100740061004C006900620072006100720079002E0064006C006C0000004800120001004C006500670061006C0043006F007000790072006900670068007400000043006F0070007900720069006700680074002000A90020002000320030003200300000002A00010001004C006500670061006C00540072006100640065006D00610072006B00730000000000000000004800100001004F0072006900670069006E0061006C00460069006C0065006E0061006D006500000044006100740061004C006900620072006100720079002E0064006C006C00000038000C000100500072006F0064007500630074004E0061006D0065000000000044006100740061004C006900620072006100720079000000340008000100500072006F006400750063007400560065007200730069006F006E00000031002E0030002E0030002E003000000038000800010041007300730065006D0062006C0079002000560065007200730069006F006E00000031002E0030002E0030002E003000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000003000000C000000A83E00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000;


GO
PRINT N'Creating [dbo].[Department]...';


GO
CREATE TABLE [dbo].[Department] (
    [Id]          INT            IDENTITY (1, 1) NOT NULL,
    [Name]        NVARCHAR (50)  NOT NULL,
    [Description] NVARCHAR (MAX) NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [dbo].[DepartmentManager]...';


GO
CREATE TABLE [dbo].[DepartmentManager] (
    [DepId] INT NOT NULL,
    [EmpId] INT NOT NULL,
    PRIMARY KEY CLUSTERED ([DepId] ASC)
);


GO
PRINT N'Creating [dbo].[Employee]...';


GO
CREATE TABLE [dbo].[Employee] (
    [Id]          INT           NOT NULL,
    [EmpName]     NVARCHAR (50) NOT NULL,
    [EmpID]       INT           NOT NULL,
    [EmpContacts] NVARCHAR (50) NOT NULL,
    [EmpAge]      INT           NOT NULL,
    [EmpDept]     INT           NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [dbo].[User]...';


GO
CREATE TABLE [dbo].[User] (
    [Id]       INT            IDENTITY (1, 1) NOT NULL,
    [Name]     NVARCHAR (50)  NOT NULL,
    [Email]    NVARCHAR (100) NOT NULL,
    [Password] NVARCHAR (MAX) NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating unnamed constraint on [dbo].[DepartmentManager]...';


GO
ALTER TABLE [dbo].[DepartmentManager]
    ADD FOREIGN KEY ([DepId]) REFERENCES [dbo].[Department] ([Id]);


GO
PRINT N'Creating unnamed constraint on [dbo].[DepartmentManager]...';


GO
ALTER TABLE [dbo].[DepartmentManager]
    ADD FOREIGN KEY ([EmpId]) REFERENCES [dbo].[Employee] ([Id]);


GO
PRINT N'Creating unnamed constraint on [dbo].[Employee]...';


GO
ALTER TABLE [dbo].[Employee]
    ADD FOREIGN KEY ([EmpDept]) REFERENCES [dbo].[Department] ([Id]);


GO
-- Refactoring step to update target server with deployed transaction logs

IF OBJECT_ID(N'dbo.__RefactorLog') IS NULL
BEGIN
    CREATE TABLE [dbo].[__RefactorLog] (OperationKey UNIQUEIDENTIFIER NOT NULL PRIMARY KEY)
    EXEC sp_addextendedproperty N'microsoft_database_tools_support', N'refactoring log', N'schema', N'dbo', N'table', N'__RefactorLog'
END
GO
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '5ddfa6df-7d65-4962-a8aa-30d45f59afcc')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('5ddfa6df-7d65-4962-a8aa-30d45f59afcc')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'd7f639bc-d0e5-4457-accf-bb7dbb59fe84')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('d7f639bc-d0e5-4457-accf-bb7dbb59fe84')

GO

GO
DECLARE @VarDecimalSupported AS BIT;

SELECT @VarDecimalSupported = 0;

IF ((ServerProperty(N'EngineEdition') = 3)
    AND (((@@microsoftversion / power(2, 24) = 9)
          AND (@@microsoftversion & 0xffff >= 3024))
         OR ((@@microsoftversion / power(2, 24) = 10)
             AND (@@microsoftversion & 0xffff >= 1600))))
    SELECT @VarDecimalSupported = 1;

IF (@VarDecimalSupported > 0)
    BEGIN
        EXECUTE sp_db_vardecimal_storage_format N'$(DatabaseName)', 'ON';
    END


GO
PRINT N'Update complete.';


GO
