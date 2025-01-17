/****** Object:  Table [dbo].[Gauges]    Script Date: 10/27/2020 11:32:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Gauges](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[GUID] [nvarchar](max) NULL,
	[Application] [nvarchar](50) NULL,
	[Name] [nvarchar](50) NULL,
	[Description] [nvarchar](50) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[DateCreated] [datetime2](7) NULL,
	[Status] [nvarchar](50) NULL,
 CONSTRAINT [PK_Gauges] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GaugesConfig]    Script Date: 10/27/2020 11:32:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GaugesConfig](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[GUID] [nvarchar](max) NULL,
	[LabelFontColor] [nvarchar](50) NULL,
	[Label] [nvarchar](50) NULL,
	[humanfriendly] [nvarchar](50) NULL,
	[gaugeWidthScale] [nvarchar](50) NULL,
	[shadowOpacity] [nvarchar](50) NULL,
	[shadowSize] [nvarchar](50) NULL,
	[shadowVerticalOffset] [nvarchar](50) NULL,
	[startAnimationTime] [nvarchar](50) NULL,
	[startAnimationType] [nvarchar](50) NULL,
	[pointer] [nvarchar](50) NULL,
	[counter] [nvarchar](50) NULL,
	[donut] [nvarchar](50) NULL,
	[reverse] [nvarchar](50) NULL,
	[pointertoplength] [nvarchar](50) NULL,
	[pointerbottomlength] [nvarchar](50) NULL,
	[pointerbottomwidth] [nvarchar](50) NULL,
	[pointercolor] [nvarchar](50) NULL,
	[width] [nvarchar](50) NULL,
	[height] [nvarchar](50) NULL,
	[valuefontcolor] [nvarchar](50) NULL,
	[titlefontcolor] [nvarchar](50) NULL,
 CONSTRAINT [PK_GaugesConfig] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GaugesLevelColors]    Script Date: 10/27/2020 11:32:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GaugesLevelColors](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Position] [int] NULL,
	[Guid] [nvarchar](max) NULL,
	[Color] [nvarchar](50) NULL,
 CONSTRAINT [PK_GaugesLevelColors] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[GaugesCreate]    Script Date: 10/27/2020 11:32:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      <Author, , Name>
-- Create Date: <Create Date, , >
-- Description: <Description, , >
-- =============================================
CREATE PROCEDURE [dbo].[GaugesCreate] @application nvarchar(50), @name nvarchar(50), @description nvarchar(50), @createdby nvarchar(50), @Guid nvarchar(max)=NULL OUTPUT

AS
BEGIN

    SET NOCOUNT ON

	Declare @Date datetime
	Set @date = getdate()

	Set @Guid = 'k2' + (select replace(newid(), '-', ''))


INSERT INTO [dbo].[Gauges]
           ([GUID]
           ,[Application]
           ,[Name]
           ,[Description]
           ,[CreatedBy]
           ,[DateCreated]
           ,[Status])
     VALUES
           (@Guid, @application, @name, @description, @createdby, @date, 'Active')

INSERT INTO [dbo].[GaugesConfig]
           ([GUID]
           ,[LabelFontColor]
           ,[Label]
           ,[humanfriendly]
           ,[gaugeWidthScale]
           ,[shadowOpacity]
           ,[shadowSize]
           ,[shadowVerticalOffset]
           ,[startAnimationTime]
           ,[startAnimationType]
           ,[pointer]
           ,[counter]
           ,[donut]
           ,[reverse]
           ,[pointertoplength]
           ,[pointerbottomlength]
           ,[pointerbottomwidth]
           ,[pointercolor]
           ,[width]
           ,[height]
           ,[valuefontcolor]
           ,[titlefontcolor])
     VALUES
           (@Guid, '#000000', 'a', 'true', '0.2', '0.2', '0', '0', '2000', 'bounce', 'true', 'false', 'false', 'false', '10', '30', '12', '#942193', '300', '220', '#0096ff', '#424242' )

		  INSERT INTO [dbo].[GaugesLevelColors]
           ([Position]
           ,[Guid]
           ,[Color])
     VALUES
           ('1', @guid, '#00f900' )
		      
		   SELECT @Guid

END
GO
/****** Object:  StoredProcedure [dbo].[GaugesCSS]    Script Date: 10/27/2020 11:32:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      <Author, , Name>
-- Create Date: <Create Date, , >
-- Description: <Description, , >
-- =============================================
CREATE PROCEDURE [dbo].[GaugesCSS] @Guid nvarchar(max), @html nvarchar(max)=NULL Output

AS
BEGIN

    SET NOCOUNT ON



DECLARE @CSSgaugestemp table (Temp NVARCHAR(max) )

INSERT INTO @CSSgaugestemp
SELECT  
'
<style>
     

      #'+ @guid +'  {
        width:'+(SELECT width from [dbo].[GaugesConfig] where GUID = @Guid)+'px ; height:'+(SELECT height from [dbo].[GaugesConfig] where GUID = @Guid)+'px; }


    </style>


'
 as Temp

SET @html = (SELECT * FROM @CSSgaugestemp)
SELECT @html


END
GO
/****** Object:  StoredProcedure [dbo].[GaugesHTML]    Script Date: 10/27/2020 11:32:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      <Author, , Name>
-- Create Date: <Create Date, , >
-- Description: <Description, , >
-- =============================================
CREATE PROCEDURE [dbo].[GaugesHTML] @Guid nvarchar(max), @html nvarchar(max)=NULL Output

AS
BEGIN

    SET NOCOUNT ON



DECLARE @htmlgaugestemp table (Temp NVARCHAR(max) )

INSERT INTO @htmlgaugestemp
SELECT  
'  <div id="'+ @GUID +'"></div> <script src="https://tsdemos.blob.core.windows.net/pockit/Gauges/Scripts/raphael-2.1.4.min.js"></script><script src="https://tsdemos.blob.core.windows.net/pockit/Gauges/Scripts/justgage.js"></script>'
 as Temp

SET @html = (SELECT * FROM @htmlgaugestemp)
SELECT @html


END
GO
/****** Object:  StoredProcedure [dbo].[GaugesJS]    Script Date: 10/27/2020 11:32:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      <Author, , Name>
-- Create Date: <Create Date, , >
-- Description: <Description, , >
-- =============================================
CREATE PROCEDURE [dbo].[GaugesJS] @Guid nvarchar(max), @html nvarchar(max)=NULL Output, @Value nvarchar(50), @min nvarchar(50), @max nvarchar(50), @Title nvarchar(50), @Label nvarchar(50)

AS
BEGIN

    SET NOCOUNT ON



DECLARE @JSgaugestemp table (Temp NVARCHAR(max) )
  DECLARE @Colors VARCHAR(MAX) 
SELECT @Colors = COALESCE(@Colors + ', ','') + (select '"' + Color + '"')
  FROM [dbo].[GaugesLevelColors]
WHERE GUID = @Guid



INSERT INTO @JSgaugestemp
SELECT  
'<script>
    document.addEventListener("DOMContentLoaded", function(event) {
      var '+ @GUID +'; 
      var '+ @GUID +' = new JustGage({
        id: "' + @GUID +'",
        value:' + @value +',
        min:' + @Min +',
        max:' + @max +',
        title: "'+ @title +'",
        label: "'+ @label +'",
        labelFontColor: '''+ (SELECT LabelFontColor FROM GaugesConfig WHERE [GUID] = @GUID) +''',
        humanfriendly: '+ (SELECT HumanFriendly FROM GaugesConfig WHERE [GUID] = @GUID) +',
        gaugeWidthScale:'+(SELECT gaugeWidthScale FROM GaugesConfig WHERE [GUID] = @GUID)+',
        shadowOpacity: '+(SELECT shadowOpacity FROM GaugesConfig WHERE [GUID] = @GUID)+',
        shadowSize: '+(SELECT shadowSize FROM GaugesConfig WHERE [GUID] = @GUID)+',
        shadowVerticalOffset: '+(SELECT shadowVerticalOffset FROM GaugesConfig WHERE [GUID] = @GUID)+',
         levelColors: ['+ @Colors +'
		 ],
                 startAnimationTime: '+(SELECT startAnimationTime FROM GaugesConfig WHERE [GUID] = @GUID)+',
        startAnimationType: "'+(SELECT startAnimationType FROM GaugesConfig WHERE [GUID] = @GUID)+'",
        refreshAnimationTime: 1000,
        refreshAnimationType: "<>",
		valueFontColor: "'+ (SELECT valueFontColor FROM GaugesConfig WHERE [GUID] = @GUID) +'",
		titleFontColor: '''+ (SELECT titleFontColor FROM GaugesConfig WHERE [GUID] = @GUID) +''',
        pointer: '+(SELECT pointer FROM GaugesConfig WHERE [GUID] = @GUID)+',
        counter: '+(SELECT counter FROM GaugesConfig WHERE [GUID] = @GUID)+',
        donut: '+(SELECT donut FROM GaugesConfig WHERE [GUID] = @GUID)+',
        reverse: '+(SELECT reverse FROM GaugesConfig WHERE [GUID] = @GUID)+',
         pointerOptions: {
          toplength: '+(SELECT pointertoplength FROM GaugesConfig WHERE [GUID] = @GUID)+',
          bottomlength: '+(SELECT pointerbottomlength FROM GaugesConfig WHERE [GUID] = @GUID)+',
          bottomwidth: '+(SELECT pointerbottomwidth FROM GaugesConfig WHERE [GUID] = @GUID)+',
          color: '''+(SELECT pointercolor FROM GaugesConfig WHERE [GUID] = @GUID)+'''
        },
      });

     

    });
    </script>
'
 as Temp



SET @html = (SELECT * FROM @JSgaugestemp)
SELECT @html


END
GO
