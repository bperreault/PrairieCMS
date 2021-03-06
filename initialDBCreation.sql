/*NOTE After this script is ran, you will also need to add membership structures for .NET,
aspnet_regsql.exe -S DBServerName -U DBLogin -P DBPassword -A all -d DBName
*/
USE [master]
GO
/****** Object:  Database [PrairieCMS]    Script Date: 04/30/2013 14:07:20 ******/
CREATE DATABASE [PrairieCMS] ON  PRIMARY 
( NAME = N'PrairieCMS', FILENAME = N'C:\ASUS\_data\PrairieCMS.mdf' , SIZE = 2048KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'PrairieCMS_log', FILENAME = N'C:\ASUS\_data\PrairieCMS_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [PrairieCMS] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [PrairieCMS].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [PrairieCMS] SET ANSI_NULL_DEFAULT OFF
GO
ALTER DATABASE [PrairieCMS] SET ANSI_NULLS OFF
GO
ALTER DATABASE [PrairieCMS] SET ANSI_PADDING OFF
GO
ALTER DATABASE [PrairieCMS] SET ANSI_WARNINGS OFF
GO
ALTER DATABASE [PrairieCMS] SET ARITHABORT OFF
GO
ALTER DATABASE [PrairieCMS] SET AUTO_CLOSE OFF
GO
ALTER DATABASE [PrairieCMS] SET AUTO_CREATE_STATISTICS ON
GO
ALTER DATABASE [PrairieCMS] SET AUTO_SHRINK OFF
GO
ALTER DATABASE [PrairieCMS] SET AUTO_UPDATE_STATISTICS ON
GO
ALTER DATABASE [PrairieCMS] SET CURSOR_CLOSE_ON_COMMIT OFF
GO
ALTER DATABASE [PrairieCMS] SET CURSOR_DEFAULT  GLOBAL
GO
ALTER DATABASE [PrairieCMS] SET CONCAT_NULL_YIELDS_NULL OFF
GO
ALTER DATABASE [PrairieCMS] SET NUMERIC_ROUNDABORT OFF
GO
ALTER DATABASE [PrairieCMS] SET QUOTED_IDENTIFIER OFF
GO
ALTER DATABASE [PrairieCMS] SET RECURSIVE_TRIGGERS OFF
GO
ALTER DATABASE [PrairieCMS] SET  DISABLE_BROKER
GO
ALTER DATABASE [PrairieCMS] SET AUTO_UPDATE_STATISTICS_ASYNC OFF
GO
ALTER DATABASE [PrairieCMS] SET DATE_CORRELATION_OPTIMIZATION OFF
GO
ALTER DATABASE [PrairieCMS] SET TRUSTWORTHY OFF
GO
ALTER DATABASE [PrairieCMS] SET ALLOW_SNAPSHOT_ISOLATION OFF
GO
ALTER DATABASE [PrairieCMS] SET PARAMETERIZATION SIMPLE
GO
ALTER DATABASE [PrairieCMS] SET READ_COMMITTED_SNAPSHOT OFF
GO
ALTER DATABASE [PrairieCMS] SET HONOR_BROKER_PRIORITY OFF
GO
ALTER DATABASE [PrairieCMS] SET  READ_WRITE
GO
ALTER DATABASE [PrairieCMS] SET RECOVERY SIMPLE
GO
ALTER DATABASE [PrairieCMS] SET  MULTI_USER
GO
ALTER DATABASE [PrairieCMS] SET PAGE_VERIFY CHECKSUM
GO
ALTER DATABASE [PrairieCMS] SET DB_CHAINING OFF
GO
USE [PrairieCMS]
GO
/****** Object:  Table [dbo].[webpages_Roles]    Script Date: 04/30/2013 14:07:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[webpages_Roles](
	[RoleId] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [nvarchar](256) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RoleId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[RoleName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[webpages_Roles] ON
INSERT [dbo].[webpages_Roles] ([RoleId], [RoleName]) VALUES (1, N'Admin')
SET IDENTITY_INSERT [dbo].[webpages_Roles] OFF
/****** Object:  Table [dbo].[webpages_OAuthMembership]    Script Date: 04/30/2013 14:07:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[webpages_OAuthMembership](
	[Provider] [nvarchar](30) NOT NULL,
	[ProviderUserId] [nvarchar](100) NOT NULL,
	[UserId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Provider] ASC,
	[ProviderUserId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[webpages_Membership]    Script Date: 04/30/2013 14:07:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[webpages_Membership](
	[UserId] [int] NOT NULL,
	[CreateDate] [datetime] NULL,
	[ConfirmationToken] [nvarchar](128) NULL,
	[IsConfirmed] [bit] NULL,
	[LastPasswordFailureDate] [datetime] NULL,
	[PasswordFailuresSinceLastSuccess] [int] NOT NULL,
	[Password] [nvarchar](128) NOT NULL,
	[PasswordChangedDate] [datetime] NULL,
	[PasswordSalt] [nvarchar](128) NOT NULL,
	[PasswordVerificationToken] [nvarchar](128) NULL,
	[PasswordVerificationTokenExpirationDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (1, CAST(0x0000A15F017F822C AS DateTime), NULL, 1, CAST(0x0000A19A00AE99C5 AS DateTime), 0, N'AGaJlnOP7DTWtvj11jyfkY/xvu5B8YAL1tZGFaHih5epkerdF8W/cPgJH+LtJ2QPCA==', CAST(0x0000A15F017F822C AS DateTime), N'', NULL, NULL)
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (2, CAST(0x0000A16B00F404BF AS DateTime), NULL, 1, NULL, 0, N'AAJoF+4KILm3d/R3JRhOkOEeRY/dHLoYMIVnrIzjKDD48vr9XZj41O1o0vt8MF1LNg==', CAST(0x0000A16B00F404BF AS DateTime), N'', NULL, NULL)
/****** Object:  Table [dbo].[Users]    Script Date: 04/30/2013 14:07:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[Username] [nvarchar](56) NOT NULL,
	[Firstname] [nvarchar](50) NULL,
	[Lastname] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Username] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Users] ON
INSERT [dbo].[Users] ([UserId], [Username], [Firstname], [Lastname]) VALUES (1, N'bobbi', NULL, NULL)
INSERT [dbo].[Users] ([UserId], [Username], [Firstname], [Lastname]) VALUES (2, N'admin', NULL, NULL)
SET IDENTITY_INSERT [dbo].[Users] OFF
/****** Object:  Table [dbo].[Master_Template]    Script Date: 04/30/2013 14:07:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Master_Template](
	[pkMasterID] [int] IDENTITY(1,1) NOT NULL,
	[themeName] [nvarchar](150) NOT NULL,
	[html] [text] NULL,
	[createdOn] [datetime] NOT NULL,
	[createdBy] [nvarchar](50) NOT NULL,
	[modifiedOn] [datetime] NOT NULL,
	[modifiedBy] [nvarchar](50) NOT NULL,
	[markDown] [text] NULL,
 CONSTRAINT [PK_CMRC_Master_Content] PRIMARY KEY CLUSTERED 
(
	[pkMasterID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Master_Template] ON
INSERT [dbo].[Master_Template] ([pkMasterID], [themeName], [html], [createdOn], [createdBy], [modifiedOn], [modifiedBy], [markDown]) VALUES (1, N'Master Page', N'<!DOCTYPE html>
<html lang="en">
<head>
    <link href=''http://fonts.googleapis.com/css?family=Muli:400,400italic'' rel=''stylesheet''
        type=''text/css''>
    <title>Shalom Baptist Next Steps</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta content="text/html; charset=UTF-8" http-equiv="Content-Type">
    <link rel="stylesheet" href="Content/bootstrap.min.css">
    <link rel="stylesheet" href="Content/bootstrap-responsive.min.css">
    <link rel="stylesheet" href="Content/site.less.css" rel="stylesheet" type="text/css">
</head>
<body>
    <div class="container">
<div class="row">
<div class="span12">
{menu_component}
</div>
</div><form enctype=''multipart/form-data'' method=''post''>
   {content_template}
    </form></div>
    <script src="Scripts/libs/jquery/jquery-min.js"></script>
    <script src="Scripts/libs/bootstrap/bootstrap.min.js"></script>
    <script>
        $(document).ready(function () {
            $(''.carousel'').carousel({
                interval: 5000
            });
        });
    </script>
</body>
</html>
', CAST(0x0000A1660085DEF8 AS DateTime), N'bobbi', CAST(0x0000A1AF01170856 AS DateTime), N'cms', NULL)
SET IDENTITY_INSERT [dbo].[Master_Template] OFF
/****** Object:  Table [dbo].[Log]    Script Date: 04/30/2013 14:07:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Log](
	[pkId] [int] IDENTITY(1,1) NOT NULL,
	[Category] [varchar](250) NULL,
	[Info] [varchar](max) NULL,
	[Date_Entered] [datetime] NULL,
 CONSTRAINT [PK_Log] PRIMARY KEY CLUSTERED 
(
	[pkId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[cmsSiteMapItems]    Script Date: 04/30/2013 14:07:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsSiteMapItems](
	[pkSiteMapItemID] [int] IDENTITY(1,1) NOT NULL,
	[SiteMapItemName] [nvarchar](64) NOT NULL,
	[fkSiteMapParentId] [int] NOT NULL,
	[relativeUrl] [nvarchar](200) NULL,
	[itemOrder] [int] NULL,
 CONSTRAINT [PK_SiteMap] PRIMARY KEY CLUSTERED 
(
	[pkSiteMapItemID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[cmsSiteMapItems] ON
INSERT [dbo].[cmsSiteMapItems] ([pkSiteMapItemID], [SiteMapItemName], [fkSiteMapParentId], [relativeUrl], [itemOrder]) VALUES (1, N'Home', -1, N'home', 1)
INSERT [dbo].[cmsSiteMapItems] ([pkSiteMapItemID], [SiteMapItemName], [fkSiteMapParentId], [relativeUrl], [itemOrder]) VALUES (3, N'About Us', -1, N'about', 3)
INSERT [dbo].[cmsSiteMapItems] ([pkSiteMapItemID], [SiteMapItemName], [fkSiteMapParentId], [relativeUrl], [itemOrder]) VALUES (4, N'Ministries', -1, N'ministries', 4)
INSERT [dbo].[cmsSiteMapItems] ([pkSiteMapItemID], [SiteMapItemName], [fkSiteMapParentId], [relativeUrl], [itemOrder]) VALUES (5, N'Messages', -1, N'messages', 5)
INSERT [dbo].[cmsSiteMapItems] ([pkSiteMapItemID], [SiteMapItemName], [fkSiteMapParentId], [relativeUrl], [itemOrder]) VALUES (6, N'Calendar', -1, N'calendar', 6)
INSERT [dbo].[cmsSiteMapItems] ([pkSiteMapItemID], [SiteMapItemName], [fkSiteMapParentId], [relativeUrl], [itemOrder]) VALUES (14, N'New Here?', -1, N'newhere', 2)
INSERT [dbo].[cmsSiteMapItems] ([pkSiteMapItemID], [SiteMapItemName], [fkSiteMapParentId], [relativeUrl], [itemOrder]) VALUES (15, N'We Want Your Feedback', 14, N'feedback', 1)
INSERT [dbo].[cmsSiteMapItems] ([pkSiteMapItemID], [SiteMapItemName], [fkSiteMapParentId], [relativeUrl], [itemOrder]) VALUES (16, N'Second Time Guest', 14, N'SecondTime', 2)
INSERT [dbo].[cmsSiteMapItems] ([pkSiteMapItemID], [SiteMapItemName], [fkSiteMapParentId], [relativeUrl], [itemOrder]) VALUES (17, N'Contact Info', 3, N'ContactInfo', 1)
INSERT [dbo].[cmsSiteMapItems] ([pkSiteMapItemID], [SiteMapItemName], [fkSiteMapParentId], [relativeUrl], [itemOrder]) VALUES (18, N'Our Beliefs', 3, N'OurBeliefs', 2)
INSERT [dbo].[cmsSiteMapItems] ([pkSiteMapItemID], [SiteMapItemName], [fkSiteMapParentId], [relativeUrl], [itemOrder]) VALUES (19, N'Map & Directions', 3, N'LocationInfo', 3)
INSERT [dbo].[cmsSiteMapItems] ([pkSiteMapItemID], [SiteMapItemName], [fkSiteMapParentId], [relativeUrl], [itemOrder]) VALUES (20, N'Our Staff', 3, N'OurStaff', 4)
INSERT [dbo].[cmsSiteMapItems] ([pkSiteMapItemID], [SiteMapItemName], [fkSiteMapParentId], [relativeUrl], [itemOrder]) VALUES (21, N'Young at Heart', 4, N'YoungAtHeart', 1)
INSERT [dbo].[cmsSiteMapItems] ([pkSiteMapItemID], [SiteMapItemName], [fkSiteMapParentId], [relativeUrl], [itemOrder]) VALUES (22, N'Men''s Ministry', 4, N'MensMinistry', 2)
INSERT [dbo].[cmsSiteMapItems] ([pkSiteMapItemID], [SiteMapItemName], [fkSiteMapParentId], [relativeUrl], [itemOrder]) VALUES (23, N'Women''s Ministry', 4, N'WomensMinistry', 3)
INSERT [dbo].[cmsSiteMapItems] ([pkSiteMapItemID], [SiteMapItemName], [fkSiteMapParentId], [relativeUrl], [itemOrder]) VALUES (24, N'Student Ministries', 4, N'StudentMinistries', 4)
INSERT [dbo].[cmsSiteMapItems] ([pkSiteMapItemID], [SiteMapItemName], [fkSiteMapParentId], [relativeUrl], [itemOrder]) VALUES (25, N'Children''s Ministry', 4, N'ChildrensMinistry', 5)
INSERT [dbo].[cmsSiteMapItems] ([pkSiteMapItemID], [SiteMapItemName], [fkSiteMapParentId], [relativeUrl], [itemOrder]) VALUES (26, N'Worship Ministry', 4, N'WorshipMinistry', 6)
SET IDENTITY_INSERT [dbo].[cmsSiteMapItems] OFF
/****** Object:  Table [dbo].[cmsLevel_Mapping]    Script Date: 04/30/2013 14:07:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsLevel_Mapping](
	[pkLevelMappingId] [int] IDENTITY(1,1) NOT NULL,
	[pageLevelDescriptor] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Level_Mapping] PRIMARY KEY CLUSTERED 
(
	[pkLevelMappingId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[cmsLevel_Mapping] ON
INSERT [dbo].[cmsLevel_Mapping] ([pkLevelMappingId], [pageLevelDescriptor]) VALUES (1, N'Page')
INSERT [dbo].[cmsLevel_Mapping] ([pkLevelMappingId], [pageLevelDescriptor]) VALUES (2, N'Sub_Page')
INSERT [dbo].[cmsLevel_Mapping] ([pkLevelMappingId], [pageLevelDescriptor]) VALUES (3, N'Form')
INSERT [dbo].[cmsLevel_Mapping] ([pkLevelMappingId], [pageLevelDescriptor]) VALUES (4, N'Sub_Div')
INSERT [dbo].[cmsLevel_Mapping] ([pkLevelMappingId], [pageLevelDescriptor]) VALUES (5, N'Email')
SET IDENTITY_INSERT [dbo].[cmsLevel_Mapping] OFF
/****** Object:  Table [dbo].[Content_Template]    Script Date: 04/30/2013 14:07:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Content_Template](
	[pkContentID] [int] IDENTITY(1,1) NOT NULL,
	[contentName] [nvarchar](150) NOT NULL,
	[html] [text] NULL,
	[createdOn] [datetime] NOT NULL,
	[createdBy] [nvarchar](50) NOT NULL,
	[modifiedOn] [datetime] NOT NULL,
	[modifiedBy] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_CMRC_Content] PRIMARY KEY CLUSTERED 
(
	[pkContentID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Content_Template] ON
INSERT [dbo].[Content_Template] ([pkContentID], [contentName], [html], [createdOn], [createdBy], [modifiedOn], [modifiedBy]) VALUES (3, N'home', N'<ul class="dropdown-menu" role="menu"><li><a href="two link">two</a></li></ul><ul class="dropdown-menu" role="menu"><li><a href="http://prairiesoft.co">One Menu Item</a></li></ul><label class="label">this is the question text and it goes along here.</label><br /><table><thead><tr><th>Items</th><th>one</th><th>two</th><th>three </th></tr></thead><tbody><tr><td>this item is first</td><td><input id="this_item_is_first" name="this_item_is_first" type="radio" value="one" /></td><td><input id="this_item_is_first" name="this_item_is_first" type="radio" value="two" /></td><td><input id="this_item_is_first" name="this_item_is_first" type="radio" value="three_" /></td></tr><tr><td>this item follows</td><td><input id="this_item_follows" name="this_item_follows" type="radio" value="one" /></td><td><input id="this_item_follows" name="this_item_follows" type="radio" value="two" /></td><td><input id="this_item_follows" name="this_item_follows" type="radio" value="three_" /></td></tr></tbody></table><p><input id="sendAnswers" type="button" value="Send Answers" /></p><p></p><div class="row"><div class="span12"><div class="span4"><div class="carousel slide" id="this-carousel-id"><div class="carousel-inner"><div class="item active"><img alt="" src="/Content/images/carousel/firstbuilding.jpg" /><div class="carousel-caption"><p>Shalom''s origins trace back to a small group of believers eager for Christ.</p></div></div><div class="item"><img alt="" src="/Content/images/carousel/firstbuilding.jpg" /><div class="carousel-caption"><p>In 1882 they built their first facility.</p></div></div><div class="item"><img alt="" src="/Content/images/carousel/secondbuilding.jpg" /><div class="carousel-caption"><p>In 1958, they purchased this larger building.</p></div></div><div class="item"><img alt="" src="/Content/images/carousel/ShalomToday.jpg" /><div class="carousel-caption"><p>In 1980, this congregation had outgrown their facilities again, and once more, built
                                        a new facility.</p></div></div><div class="item"><img alt="" src="/Content/images/carousel/ShalomToday2.jpg" /><div class="carousel-caption"><p>The church is once again experiencing growing pains.</p></div></div><div class="item"><img alt="" src="/Content/images/carousel/ShalomToday3.jpg" /><div class="carousel-caption"><p>It time for "The Next Step".</p></div></div></div><a class="carousel-control left" data-slide="prev" href="#this-carousel-id">‹</a>
 <a class="carousel-control right" data-slide="next" href="#this-carousel-id">›</a>
 </div></div><div class="span7"><h1 class="logo">The Next Step
                    </h1></div></div></div><div class="row"><div class="span12"><div class="title"><p>Shalom Baptist Church, Hutchinson, MN</p></div><div class="span9 left-align b2"><p>Shalom is a church with origins tracing back to a small group of believers who longed
                        for something more than just going through the motions as they found their faith
                        in Christ.</p><p>In 1882 this group joined two other congregations to build the Christian Apostolic
                        Baptist Society. As the congregation outgrew their facility, they eventually purchased
                        a larger building in 1958.</p><p>In 1980, this congregation had outgrown their facilities again, and once more, built
                        a new facility, calling it Shalom Baptist Church. We have been in this building
                        ever since, remaining true to the gospel, and watching God work in immeasurable
                        ways.</p><p>The church is once again experiencing growing pains and we have seen that God is
                        on the move at Shalom and in this community. It''s time to close the gap between
                        where we have been the last 33 years and where God is taking us now. 75% of American
                        churches have plateaued or are decreasing in size for a variety of reasons, yet
                        Shalom has experienced recent growth.</p><p>We believe that God has given Shalom a specific vision, "to immerse the Hutchinson
                        area in the grace of Christ to break down barriers of cynicism and confusion in
                        people''s lives." Not much different than the group of believers who first started
                        this church over 125 years ago.</p><p>By staying status quo, there is a risk of losing that hunger, that growth. Jesus
                        gives us this Great Commission, "Therefore go and make disciples of all nations,
                        baptizing them in the name of the Father and of the Son and of the Holy Spirit,
                        and teaching them to obey everything I have commanded you"<small>(Matthew 28:19-20)</small>.
 </p><p>The time is now and the how by taking "The Next Step" towards ministry expansion.</p><div class="featured"><h3>Will you take the next step with Shalom?</h3><strong>Step 1</strong> 
                        <p>Begin praying for the expansion campaign</p><p><a class="btn btn-primary btn-large" href="mailto:dlmurphy@hutchtel.net?subject=I want to join the prayer team">Join The Next Step Prayer Team</a>
 </p><p>You will receive prayer requests weekly via email.
                    </p><div class="spacer"></div></div></div><div class="span3 left-align"><dl class="leftbar"><dt class="b1 first">Upcoming Events</dt><dd><table><tbody><tr><th>Event
 </th><th>Date
 </th></tr><tr><td>Prayer Drive
                                    </td><td>March&nbsp;9
 </td></tr><tr><td>Celebration Banquet
                                    </td><td>May 5
                                    </td></tr></tbody></table></dd><dt class="b4">My Next Step</dt><dd><div class="media"></div></dd><dt class="b3">FAQ''s</dt><dd>Did you know that Shalom has experienced growth in many ministry areas in 2012.
                            <a href="Content/docs/2012ShalomAnnualReportweb.pdf" target="_blank">Click here to download
                                Shalom''s 2012 Annual Report for more information. </a>
 </dd></dl><div class="bar">&nbsp;</div><div><div class="vcard"><p class="fn"><a class="url" href="http://shalombaptist.org" target="blank">Shalom Baptist Church</a>
 </p><p class="adr"><span class="street-address">1215 Robert''s Rd. SW</span><br /><span class="region">Hutchinson, MN</span><br /><span class="email">Email: <a href="mailto:shalom.sbc@gmail.com">shalom.sbc@gmail.com</a></span>
 </p><p class="tel">320.587.2668</p></div></div></div></div></div>', CAST(0x0000A16701390577 AS DateTime), N'bobbi', CAST(0x0000A1AF007E021B AS DateTime), N'bobbi')
INSERT [dbo].[Content_Template] ([pkContentID], [contentName], [html], [createdOn], [createdBy], [modifiedOn], [modifiedBy]) VALUES (4, N'/', N'<div class="row"><div class="span12"><div class="span4"><div class="carousel slide" id="this-carousel-id"><div class="carousel-inner"><div class="item active"><img alt="" src="/Content/images/carousel/firstbuilding.jpg" /><div class="carousel-caption"><p>Shalom''s origins trace back to a small group of believers eager for Christ.</p></div></div><div class="item"><img alt="" src="/Content/images/carousel/firstbuilding.jpg" /><div class="carousel-caption"><p>In 1882 they built their first facility.</p></div></div><div class="item"><img alt="" src="/Content/images/carousel/secondbuilding.jpg" /><div class="carousel-caption"><p>In 1958, they purchased this larger building.</p></div></div><div class="item"><img alt="" src="/Content/images/carousel/ShalomToday.jpg" /><div class="carousel-caption"><p>In 1980, this congregation had outgrown their facilities again, and once more, built
                                        a new facility.</p></div></div><div class="item"><img alt="" src="/Content/images/carousel/ShalomToday2.jpg" /><div class="carousel-caption"><p>The church is once again experiencing growing pains.</p></div></div><div class="item"><img alt="" src="/Content/images/carousel/ShalomToday3.jpg" /><div class="carousel-caption"><p>It time for "The Next Step".</p></div></div></div><a class="carousel-control left" data-slide="prev" href="#this-carousel-id">‹</a>
 <a class="carousel-control right" data-slide="next" href="#this-carousel-id">›</a>
 </div></div><div class="span7"><h1 class="logo">The Next Step
                    </h1></div></div></div><div class="row"><div class="span12"><div class="title"><p>Shalom Baptist Church, Hutchinson, MN</p></div><div class="span9 left-align b2"><p>Shalom is a church with origins tracing back to a small group of believers who longed
                        for something more than just going through the motions as they found their faith
                        in Christ.</p><p>In 1882 this group joined two other congregations to build the Christian Apostolic
                        Baptist Society. As the congregation outgrew their facility, they eventually purchased
                        a larger building in 1958.</p><p>In 1980, this congregation had outgrown their facilities again, and once more, built
                        a new facility, calling it Shalom Baptist Church. We have been in this building
                        ever since, remaining true to the gospel, and watching God work in immeasurable
                        ways.</p><p>The church is once again experiencing growing pains and we have seen that God is
                        on the move at Shalom and in this community. It''s time to close the gap between
                        where we have been the last 33 years and where God is taking us now. 75% of American
                        churches have plateaued or are decreasing in size for a variety of reasons, yet
                        Shalom has experienced recent growth.</p><p>We believe that God has given Shalom a specific vision, "to immerse the Hutchinson
                        area in the grace of Christ to break down barriers of cynicism and confusion in
                        people''s lives." Not much different than the group of believers who first started
                        this church over 125 years ago.</p><p>By staying status quo, there is a risk of losing that hunger, that growth. Jesus
                        gives us this Great Commission, "Therefore go and make disciples of all nations,
                        baptizing them in the name of the Father and of the Son and of the Holy Spirit,
                        and teaching them to obey everything I have commanded you"<small>(Matthew 28:19-20)</small>.
 </p><p>The time is now and the how by taking "The Next Step" towards ministry expansion.</p><div class="featured"><h3>Will you take the next step with Shalom?</h3><strong>Step 1</strong> 
                        <p>Begin praying for the expansion campaign</p><p><a class="btn btn-primary btn-large" href="mailto:dlmurphy@hutchtel.net?subject=I want to join the prayer team">
 Join The Next Step Prayer Team</a>
 </p><p>You will receive prayer requests weekly via email.
                    </p><div class="spacer"></div></div></div><div class="span3 left-align"><dl class="leftbar"><dt class="b1 first">Upcoming Events</dt><dd><table><tbody><tr><th>Event
 </th><th>Date
 </th></tr><tr><td>Prayer Drive
                                    </td><td>March&nbsp;9
 </td></tr><tr><td>Celebration Banquet
                                    </td><td>May 5
                                    </td></tr></tbody></table></dd><dt class="b4">My Next Step</dt><dd><div class="media"></div></dd><dt class="b3">FAQ''s</dt><dd>Did you know that Shalom has experienced growth in many ministry areas in 2012.
                            <a href="Content/docs/2012ShalomAnnualReportweb.pdf" target="_blank">Click here to download
                                Shalom''s 2012 Annual Report for more information. </a>
 </dd></dl><div class="bar">&nbsp;</div><div><div class="vcard"><p class="fn"><a class="url" href="http://shalombaptist.org" target="blank">Shalom Baptist Church</a>
 </p><p class="adr"><span class="street-address">1215 Robert''s Rd. SW</span><br /><span class="region">Hutchinson, MN</span><br /><span class="email">Email: <a href="mailto:shalom.sbc@gmail.com">shalom.sbc@gmail.com</a></span>
 </p><p class="tel">320.587.2668</p></div></div></div></div></div>', CAST(0x0000A1800144027D AS DateTime), N'bobbi', CAST(0x0000A18001440B27 AS DateTime), N'bobbi')
INSERT [dbo].[Content_Template] ([pkContentID], [contentName], [html], [createdOn], [createdBy], [modifiedOn], [modifiedBy]) VALUES (5, N'/', N'<div class="row"><div class="span12"><div class="span4"><div class="carousel slide" id="this-carousel-id"><div class="carousel-inner"><div class="item active"><img alt="" src="/Content/images/carousel/firstbuilding.jpg" /><div class="carousel-caption"><p>Shalom''s origins trace back to a small group of believers eager for Christ.</p></div></div><div class="item"><img alt="" src="/Content/images/carousel/firstbuilding.jpg" /><div class="carousel-caption"><p>In 1882 they built their first facility.</p></div></div><div class="item"><img alt="" src="/Content/images/carousel/secondbuilding.jpg" /><div class="carousel-caption"><p>In 1958, they purchased this larger building.</p></div></div><div class="item"><img alt="" src="/Content/images/carousel/ShalomToday.jpg" /><div class="carousel-caption"><p>In 1980, this congregation had outgrown their facilities again, and once more, built
                                        a new facility.</p></div></div><div class="item"><img alt="" src="/Content/images/carousel/ShalomToday2.jpg" /><div class="carousel-caption"><p>The church is once again experiencing growing pains.</p></div></div><div class="item"><img alt="" src="/Content/images/carousel/ShalomToday3.jpg" /><div class="carousel-caption"><p>It time for "The Next Step".</p></div></div></div><a class="carousel-control left" data-slide="prev" href="#this-carousel-id">‹</a>
 <a class="carousel-control right" data-slide="next" href="#this-carousel-id">›</a>
 </div></div><div class="span7"><h1 class="logo">The Next Step
                    </h1></div></div></div><div class="row"><div class="span12"><div class="title"><p>Shalom Baptist Church, Hutchinson, MN</p></div><div class="span9 left-align b2"><p>Shalom is a church with origins tracing back to a small group of believers who longed
                        for something more than just going through the motions as they found their faith
                        in Christ.</p><p>In 1882 this group joined two other congregations to build the Christian Apostolic
                        Baptist Society. As the congregation outgrew their facility, they eventually purchased
                        a larger building in 1958.</p><p>In 1980, this congregation had outgrown their facilities again, and once more, built
                        a new facility, calling it Shalom Baptist Church. We have been in this building
                        ever since, remaining true to the gospel, and watching God work in immeasurable
                        ways.</p><p>The church is once again experiencing growing pains and we have seen that God is
                        on the move at Shalom and in this community. It''s time to close the gap between
                        where we have been the last 33 years and where God is taking us now. 75% of American
                        churches have plateaued or are decreasing in size for a variety of reasons, yet
                        Shalom has experienced recent growth.</p><p>We believe that God has given Shalom a specific vision, "to immerse the Hutchinson
                        area in the grace of Christ to break down barriers of cynicism and confusion in
                        people''s lives." Not much different than the group of believers who first started
                        this church over 125 years ago.</p><p>By staying status quo, there is a risk of losing that hunger, that growth. Jesus
                        gives us this Great Commission, "Therefore go and make disciples of all nations,
                        baptizing them in the name of the Father and of the Son and of the Holy Spirit,
                        and teaching them to obey everything I have commanded you"<small>(Matthew 28:19-20)</small>.
 </p><p>The time is now and the how by taking "The Next Step" towards ministry expansion.</p><div class="featured"><h3>Will you take the next step with Shalom?</h3><strong>Step 1</strong> 
                        <p>Begin praying for the expansion campaign</p><p><a class="btn btn-primary btn-large" href="mailto:dlmurphy@hutchtel.net?subject=I want to join the prayer team">Join The Next Step Prayer Team</a>
 </p><p>You will receive prayer requests weekly via email.
                    </p><div class="spacer"></div></div></div><div class="span3 left-align"><dl class="leftbar"><dt class="b1 first">Upcoming Events</dt><dd><table><tbody><tr><th>Event
 </th><th>Date
 </th></tr><tr><td>Prayer Drive
                                    </td><td>March&nbsp;9
 </td></tr><tr><td>Celebration Banquet
                                    </td><td>May 5
                                    </td></tr></tbody></table></dd><dt class="b4">My Next Step</dt><dd><div class="media"></div></dd><dt class="b3">FAQ''s</dt><dd>Did you know that Shalom has experienced growth in many ministry areas in 2012.
                            <a href="Content/docs/2012ShalomAnnualReportweb.pdf" target="_blank">Click here to download
                                Shalom''s 2012 Annual Report for more information. </a>
 </dd></dl><div class="bar">&nbsp;</div><div><div class="vcard"><p class="fn"><a class="url" href="http://shalombaptist.org" target="blank">Shalom Baptist Church</a>
 </p><p class="adr"><span class="street-address">1215 Robert''s Rd. SW</span><br /><span class="region">Hutchinson, MN</span><br /><span class="email">Email: <a href="mailto:shalom.sbc@gmail.com">shalom.sbc@gmail.com</a></span>
 </p><p class="tel">320.587.2668</p></div></div></div></div></div>', CAST(0x0000A1810072C608 AS DateTime), N'bobbi', CAST(0x0000A1810072C60B AS DateTime), N'bobbi')
INSERT [dbo].[Content_Template] ([pkContentID], [contentName], [html], [createdOn], [createdBy], [modifiedOn], [modifiedBy]) VALUES (6, N'/', N'<div class="row"><div class="span12"><div class="span4"><div class="carousel slide" id="this-carousel-id"><div class="carousel-inner"><div class="item active"><img alt="" src="/Content/images/carousel/firstbuilding.jpg" /><div class="carousel-caption"><p>Shalom''s origins trace back to a small group of believers eager for Christ.</p></div></div><div class="item"><img alt="" src="/Content/images/carousel/firstbuilding.jpg" /><div class="carousel-caption"><p>In 1882 they built their first facility.</p></div></div><div class="item"><img alt="" src="/Content/images/carousel/secondbuilding.jpg" /><div class="carousel-caption"><p>In 1958, they purchased this larger building.</p></div></div><div class="item"><img alt="" src="/Content/images/carousel/ShalomToday.jpg" /><div class="carousel-caption"><p>In 1980, this congregation had outgrown their facilities again, and once more, built
                                        a new facility.</p></div></div><div class="item"><img alt="" src="/Content/images/carousel/ShalomToday2.jpg" /><div class="carousel-caption"><p>The church is once again experiencing growing pains.</p></div></div><div class="item"><img alt="" src="/Content/images/carousel/ShalomToday3.jpg" /><div class="carousel-caption"><p>It time for "The Next Step".</p></div></div></div><a class="carousel-control left" data-slide="prev" href="#this-carousel-id">‹</a>
 <a class="carousel-control right" data-slide="next" href="#this-carousel-id">›</a>
 </div></div><div class="span7"><h1 class="logo">The Next Step
                    </h1></div></div></div><div class="row"><div class="span12"><div class="title"><p>Shalom Baptist Church, Hutchinson, MN</p></div><div class="span9 left-align b2"><p>Shalom is a church with origins tracing back to a small group of believers who longed
                        for something more than just going through the motions as they found their faith
                        in Christ.</p><p>In 1882 this group joined two other congregations to build the Christian Apostolic
                        Baptist Society. As the congregation outgrew their facility, they eventually purchased
                        a larger building in 1958.</p><p>In 1980, this congregation had outgrown their facilities again, and once more, built
                        a new facility, calling it Shalom Baptist Church. We have been in this building
                        ever since, remaining true to the gospel, and watching God work in immeasurable
                        ways.</p><p>The church is once again experiencing growing pains and we have seen that God is
                        on the move at Shalom and in this community. It''s time to close the gap between
                        where we have been the last 33 years and where God is taking us now. 75% of American
                        churches have plateaued or are decreasing in size for a variety of reasons, yet
                        Shalom has experienced recent growth.</p><p>We believe that God has given Shalom a specific vision, "to immerse the Hutchinson
                        area in the grace of Christ to break down barriers of cynicism and confusion in
                        people''s lives." Not much different than the group of believers who first started
                        this church over 125 years ago.</p><p>By staying status quo, there is a risk of losing that hunger, that growth. Jesus
                        gives us this Great Commission, "Therefore go and make disciples of all nations,
                        baptizing them in the name of the Father and of the Son and of the Holy Spirit,
                        and teaching them to obey everything I have commanded you"<small>(Matthew 28:19-20)</small>.
 </p><p>The time is now and the how by taking "The Next Step" towards ministry expansion.</p><div class="featured"><h3>Will you take the next step with Shalom?</h3><strong>Step 1</strong> 
                        <p>Begin praying for the expansion campaign</p><p><a class="btn btn-primary btn-large" href="mailto:dlmurphy@hutchtel.net?subject=I want to join the prayer team">Join The Next Step Prayer Team</a>
 </p><p>You will receive prayer requests weekly via email.
                    </p><div class="spacer"></div></div></div><div class="span3 left-align"><dl class="leftbar"><dt class="b1 first">Upcoming Events</dt><dd><table><tbody><tr><th>Event
 </th><th>Date
 </th></tr><tr><td>Prayer Drive
                                    </td><td>March&nbsp;9
 </td></tr><tr><td>Celebration Banquet
                                    </td><td>May 5
                                    </td></tr></tbody></table></dd><dt class="b4">My Next Step</dt><dd><div class="media"></div></dd><dt class="b3">FAQ''s</dt><dd>Did you know that Shalom has experienced growth in many ministry areas in 2012.
                            <a href="Content/docs/2012ShalomAnnualReportweb.pdf" target="_blank">Click here to download
                                Shalom''s 2012 Annual Report for more information. </a>
 </dd></dl><div class="bar">&nbsp;</div><div><div class="vcard"><p class="fn"><a class="url" href="http://shalombaptist.org" target="blank">Shalom Baptist Church</a>
 </p><p class="adr"><span class="street-address">1215 Robert''s Rd. SW</span><br /><span class="region">Hutchinson, MN</span><br /><span class="email">Email: <a href="mailto:shalom.sbc@gmail.com">shalom.sbc@gmail.com</a></span>
 </p><p class="tel">320.587.2668</p></div></div></div></div></div>', CAST(0x0000A1810112294B AS DateTime), N'bobbi', CAST(0x0000A18101122955 AS DateTime), N'bobbi')
INSERT [dbo].[Content_Template] ([pkContentID], [contentName], [html], [createdOn], [createdBy], [modifiedOn], [modifiedBy]) VALUES (7, N'/', N'<div class="row"><div class="span12"><div class="span4"><div class="carousel slide" id="this-carousel-id"><div class="carousel-inner"><div class="item active"><img alt="" src="/Content/images/carousel/firstbuilding.jpg" /><div class="carousel-caption"><p>Shalom''s origins trace back to a small group of believers eager for Christ.</p></div></div><div class="item"><img alt="" src="/Content/images/carousel/firstbuilding.jpg" /><div class="carousel-caption"><p>In 1882 they built their first facility.</p></div></div><div class="item"><img alt="" src="/Content/images/carousel/secondbuilding.jpg" /><div class="carousel-caption"><p>In 1958, they purchased this larger building.</p></div></div><div class="item"><img alt="" src="/Content/images/carousel/ShalomToday.jpg" /><div class="carousel-caption"><p>In 1980, this congregation had outgrown their facilities again, and once more, built
                                        a new facility.</p></div></div><div class="item"><img alt="" src="/Content/images/carousel/ShalomToday2.jpg" /><div class="carousel-caption"><p>The church is once again experiencing growing pains.</p></div></div><div class="item"><img alt="" src="/Content/images/carousel/ShalomToday3.jpg" /><div class="carousel-caption"><p>It time for "The Next Step".</p></div></div></div><a class="carousel-control left" data-slide="prev" href="#this-carousel-id">‹</a>
 <a class="carousel-control right" data-slide="next" href="#this-carousel-id">›</a>
 </div></div><div class="span7"><h1 class="logo">The Next Step
                    </h1></div></div></div><div class="row"><div class="span12"><div class="title"><p>Shalom Baptist Church, Hutchinson, MN</p></div><div class="span9 left-align b2"><p>Shalom is a church with origins tracing back to a small group of believers who longed
                        for something more than just going through the motions as they found their faith
                        in Christ.</p><p>In 1882 this group joined two other congregations to build the Christian Apostolic
                        Baptist Society. As the congregation outgrew their facility, they eventually purchased
                        a larger building in 1958.</p><p>In 1980, this congregation had outgrown their facilities again, and once more, built
                        a new facility, calling it Shalom Baptist Church. We have been in this building
                        ever since, remaining true to the gospel, and watching God work in immeasurable
                        ways.</p><p>The church is once again experiencing growing pains and we have seen that God is
                        on the move at Shalom and in this community. It''s time to close the gap between
                        where we have been the last 33 years and where God is taking us now. 75% of American
                        churches have plateaued or are decreasing in size for a variety of reasons, yet
                        Shalom has experienced recent growth.</p><p>We believe that God has given Shalom a specific vision, "to immerse the Hutchinson
                        area in the grace of Christ to break down barriers of cynicism and confusion in
                        people''s lives." Not much different than the group of believers who first started
                        this church over 125 years ago.</p><p>By staying status quo, there is a risk of losing that hunger, that growth. Jesus
                        gives us this Great Commission, "Therefore go and make disciples of all nations,
                        baptizing them in the name of the Father and of the Son and of the Holy Spirit,
                        and teaching them to obey everything I have commanded you"<small>(Matthew 28:19-20)</small>.
 </p><p>The time is now and the how by taking "The Next Step" towards ministry expansion.</p><div class="featured"><h3>Will you take the next step with Shalom?</h3><strong>Step 1</strong> 
                        <p>Begin praying for the expansion campaign</p><p><a class="btn btn-primary btn-large" href="mailto:dlmurphy@hutchtel.net?subject=I want to join the prayer team">Join The Next Step Prayer Team</a>
 </p><p>You will receive prayer requests weekly via email.
                    </p><div class="spacer"></div></div></div><div class="span3 left-align"><dl class="leftbar"><dt class="b1 first">Upcoming Events</dt><dd><table><tbody><tr><th>Event
 </th><th>Date
 </th></tr><tr><td>Prayer Drive
                                    </td><td>March&nbsp;9
 </td></tr><tr><td>Celebration Banquet
                                    </td><td>May 5
                                    </td></tr></tbody></table></dd><dt class="b4">My Next Step</dt><dd><div class="media"></div></dd><dt class="b3">FAQ''s</dt><dd>Did you know that Shalom has experienced growth in many ministry areas in 2012.
                            <a href="Content/docs/2012ShalomAnnualReportweb.pdf" target="_blank">Click here to download
                                Shalom''s 2012 Annual Report for more information. </a>
 </dd></dl><div class="bar">&nbsp;</div><div><div class="vcard"><p class="fn"><a class="url" href="http://shalombaptist.org" target="blank">Shalom Baptist Church</a>
 </p><p class="adr"><span class="street-address">1215 Robert''s Rd. SW</span><br /><span class="region">Hutchinson, MN</span><br /><span class="email">Email: <a href="mailto:shalom.sbc@gmail.com">shalom.sbc@gmail.com</a></span>
 </p><p class="tel">320.587.2668</p></div></div></div></div></div>', CAST(0x0000A181013ED77E AS DateTime), N'bobbi', CAST(0x0000A181013ED783 AS DateTime), N'bobbi')
INSERT [dbo].[Content_Template] ([pkContentID], [contentName], [html], [createdOn], [createdBy], [modifiedOn], [modifiedBy]) VALUES (8, N'/', N'<div class="row"><div class="span12"><div class="span4"><div class="carousel slide" id="this-carousel-id"><div class="carousel-inner"><div class="item active"><img alt="" src="/Content/images/carousel/firstbuilding.jpg" /><div class="carousel-caption"><p>Shalom''s origins trace back to a small group of believers eager for Christ.</p></div></div><div class="item"><img alt="" src="/Content/images/carousel/firstbuilding.jpg" /><div class="carousel-caption"><p>In 1882 they built their first facility.</p></div></div><div class="item"><img alt="" src="/Content/images/carousel/secondbuilding.jpg" /><div class="carousel-caption"><p>In 1958, they purchased this larger building.</p></div></div><div class="item"><img alt="" src="/Content/images/carousel/ShalomToday.jpg" /><div class="carousel-caption"><p>In 1980, this congregation had outgrown their facilities again, and once more, built
                                        a new facility.</p></div></div><div class="item"><img alt="" src="/Content/images/carousel/ShalomToday2.jpg" /><div class="carousel-caption"><p>The church is once again experiencing growing pains.</p></div></div><div class="item"><img alt="" src="/Content/images/carousel/ShalomToday3.jpg" /><div class="carousel-caption"><p>It time for "The Next Step".</p></div></div></div><a class="carousel-control left" data-slide="prev" href="#this-carousel-id">‹</a>
 <a class="carousel-control right" data-slide="next" href="#this-carousel-id">›</a>
 </div></div><div class="span7"><h1 class="logo">The Next Step
                    </h1></div></div></div><div class="row"><div class="span12"><div class="title"><p>Shalom Baptist Church, Hutchinson, MN</p></div><div class="span9 left-align b2"><p>Shalom is a church with origins tracing back to a small group of believers who longed
                        for something more than just going through the motions as they found their faith
                        in Christ.</p><p>In 1882 this group joined two other congregations to build the Christian Apostolic
                        Baptist Society. As the congregation outgrew their facility, they eventually purchased
                        a larger building in 1958.</p><p>In 1980, this congregation had outgrown their facilities again, and once more, built
                        a new facility, calling it Shalom Baptist Church. We have been in this building
                        ever since, remaining true to the gospel, and watching God work in immeasurable
                        ways.</p><p>The church is once again experiencing growing pains and we have seen that God is
                        on the move at Shalom and in this community. It''s time to close the gap between
                        where we have been the last 33 years and where God is taking us now. 75% of American
                        churches have plateaued or are decreasing in size for a variety of reasons, yet
                        Shalom has experienced recent growth.</p><p>We believe that God has given Shalom a specific vision, "to immerse the Hutchinson
                        area in the grace of Christ to break down barriers of cynicism and confusion in
                        people''s lives." Not much different than the group of believers who first started
                        this church over 125 years ago.</p><p>By staying status quo, there is a risk of losing that hunger, that growth. Jesus
                        gives us this Great Commission, "Therefore go and make disciples of all nations,
                        baptizing them in the name of the Father and of the Son and of the Holy Spirit,
                        and teaching them to obey everything I have commanded you"<small>(Matthew 28:19-20)</small>.
 </p><p>The time is now and the how by taking "The Next Step" towards ministry expansion.</p><div class="featured"><h3>Will you take the next step with Shalom?</h3><strong>Step 1</strong> 
                        <p>Begin praying for the expansion campaign</p><p><a class="btn btn-primary btn-large" href="mailto:dlmurphy@hutchtel.net?subject=I want to join the prayer team">Join The Next Step Prayer Team</a>
 </p><p>You will receive prayer requests weekly via email.
                    </p><div class="spacer"></div></div></div><div class="span3 left-align"><dl class="leftbar"><dt class="b1 first">Upcoming Events</dt><dd><table><tbody><tr><th>Event
 </th><th>Date
 </th></tr><tr><td>Prayer Drive
                                    </td><td>March&nbsp;9
 </td></tr><tr><td>Celebration Banquet
                                    </td><td>May 5
                                    </td></tr></tbody></table></dd><dt class="b4">My Next Step</dt><dd><div class="media"></div></dd><dt class="b3">FAQ''s</dt><dd>Did you know that Shalom has experienced growth in many ministry areas in 2012.
                            <a href="Content/docs/2012ShalomAnnualReportweb.pdf" target="_blank">Click here to download
                                Shalom''s 2012 Annual Report for more information. </a>
 </dd></dl><div class="bar">&nbsp;</div><div><div class="vcard"><p class="fn"><a class="url" href="http://shalombaptist.org" target="blank">Shalom Baptist Church</a>
 </p><p class="adr"><span class="street-address">1215 Robert''s Rd. SW</span><br /><span class="region">Hutchinson, MN</span><br /><span class="email">Email: <a href="mailto:shalom.sbc@gmail.com">shalom.sbc@gmail.com</a></span>
 </p><p class="tel">320.587.2668</p></div></div></div></div></div>', CAST(0x0000A18101483FAB AS DateTime), N'bobbi', CAST(0x0000A18101483FAF AS DateTime), N'bobbi')
INSERT [dbo].[Content_Template] ([pkContentID], [contentName], [html], [createdOn], [createdBy], [modifiedOn], [modifiedBy]) VALUES (9, N'/', N'<div class="row"><div class="span12"><div class="span4"><div class="carousel slide" id="this-carousel-id"><div class="carousel-inner"><div class="item active"><img alt="" src="/Content/images/carousel/firstbuilding.jpg" /><div class="carousel-caption"><p>Shalom''s origins trace back to a small group of believers eager for Christ.</p></div></div><div class="item"><img alt="" src="/Content/images/carousel/firstbuilding.jpg" /><div class="carousel-caption"><p>In 1882 they built their first facility.</p></div></div><div class="item"><img alt="" src="/Content/images/carousel/secondbuilding.jpg" /><div class="carousel-caption"><p>In 1958, they purchased this larger building.</p></div></div><div class="item"><img alt="" src="/Content/images/carousel/ShalomToday.jpg" /><div class="carousel-caption"><p>In 1980, this congregation had outgrown their facilities again, and once more, built
                                        a new facility.</p></div></div><div class="item"><img alt="" src="/Content/images/carousel/ShalomToday2.jpg" /><div class="carousel-caption"><p>The church is once again experiencing growing pains.</p></div></div><div class="item"><img alt="" src="/Content/images/carousel/ShalomToday3.jpg" /><div class="carousel-caption"><p>It time for "The Next Step".</p></div></div></div><a class="carousel-control left" data-slide="prev" href="#this-carousel-id">‹</a>
 <a class="carousel-control right" data-slide="next" href="#this-carousel-id">›</a>
 </div></div><div class="span7"><h1 class="logo">The Next Step
                    </h1></div></div></div><div class="row"><div class="span12"><div class="title"><p>Shalom Baptist Church, Hutchinson, MN</p></div><div class="span9 left-align b2"><p>Shalom is a church with origins tracing back to a small group of believers who longed
                        for something more than just going through the motions as they found their faith
                        in Christ.</p><p>In 1882 this group joined two other congregations to build the Christian Apostolic
                        Baptist Society. As the congregation outgrew their facility, they eventually purchased
                        a larger building in 1958.</p><p>In 1980, this congregation had outgrown their facilities again, and once more, built
                        a new facility, calling it Shalom Baptist Church. We have been in this building
                        ever since, remaining true to the gospel, and watching God work in immeasurable
                        ways.</p><p>The church is once again experiencing growing pains and we have seen that God is
                        on the move at Shalom and in this community. It''s time to close the gap between
                        where we have been the last 33 years and where God is taking us now. 75% of American
                        churches have plateaued or are decreasing in size for a variety of reasons, yet
                        Shalom has experienced recent growth.</p><p>We believe that God has given Shalom a specific vision, "to immerse the Hutchinson
                        area in the grace of Christ to break down barriers of cynicism and confusion in
                        people''s lives." Not much different than the group of believers who first started
                        this church over 125 years ago.</p><p>By staying status quo, there is a risk of losing that hunger, that growth. Jesus
                        gives us this Great Commission, "Therefore go and make disciples of all nations,
                        baptizing them in the name of the Father and of the Son and of the Holy Spirit,
                        and teaching them to obey everything I have commanded you"<small>(Matthew 28:19-20)</small>.
 </p><p>The time is now and the how by taking "The Next Step" towards ministry expansion.</p><div class="featured"><h3>Will you take the next step with Shalom?</h3><strong>Step 1</strong> 
                        <p>Begin praying for the expansion campaign</p><p><a class="btn btn-primary btn-large" href="mailto:dlmurphy@hutchtel.net?subject=I want to join the prayer team">Join The Next Step Prayer Team</a>
 </p><p>You will receive prayer requests weekly via email.
                    </p><div class="spacer"></div></div></div><div class="span3 left-align"><dl class="leftbar"><dt class="b1 first">Upcoming Events</dt><dd><table><tbody><tr><th>Event
 </th><th>Date
 </th></tr><tr><td>Prayer Drive
                                    </td><td>March&nbsp;9
 </td></tr><tr><td>Celebration Banquet
                                    </td><td>May 5
                                    </td></tr></tbody></table></dd><dt class="b4">My Next Step</dt><dd><div class="media"></div></dd><dt class="b3">FAQ''s</dt><dd>Did you know that Shalom has experienced growth in many ministry areas in 2012.
                            <a href="Content/docs/2012ShalomAnnualReportweb.pdf" target="_blank">Click here to download
                                Shalom''s 2012 Annual Report for more information. </a>
 </dd></dl><div class="bar">&nbsp;</div><div><div class="vcard"><p class="fn"><a class="url" href="http://shalombaptist.org" target="blank">Shalom Baptist Church</a>
 </p><p class="adr"><span class="street-address">1215 Robert''s Rd. SW</span><br /><span class="region">Hutchinson, MN</span><br /><span class="email">Email: <a href="mailto:shalom.sbc@gmail.com">shalom.sbc@gmail.com</a></span>
 </p><p class="tel">320.587.2668</p></div></div></div></div></div>', CAST(0x0000A1810149D736 AS DateTime), N'bobbi', CAST(0x0000A181014A655D AS DateTime), N'bobbi')
INSERT [dbo].[Content_Template] ([pkContentID], [contentName], [html], [createdOn], [createdBy], [modifiedOn], [modifiedBy]) VALUES (10, N'/', N'<div class="row"><div class="span12"><div class="span4"><div class="carousel slide" id="this-carousel-id"><div class="carousel-inner"><div class="item active"><img alt="" src="/Content/images/carousel/firstbuilding.jpg" /><div class="carousel-caption"><p>Shalom''s origins trace back to a small group of believers eager for Christ.</p></div></div><div class="item"><img alt="" src="/Content/images/carousel/firstbuilding.jpg" /><div class="carousel-caption"><p>In 1882 they built their first facility.</p></div></div><div class="item"><img alt="" src="/Content/images/carousel/secondbuilding.jpg" /><div class="carousel-caption"><p>In 1958, they purchased this larger building.</p></div></div><div class="item"><img alt="" src="/Content/images/carousel/ShalomToday.jpg" /><div class="carousel-caption"><p>In 1980, this congregation had outgrown their facilities again, and once more, built
                                        a new facility.</p></div></div><div class="item"><img alt="" src="/Content/images/carousel/ShalomToday2.jpg" /><div class="carousel-caption"><p>The church is once again experiencing growing pains.</p></div></div><div class="item"><img alt="" src="/Content/images/carousel/ShalomToday3.jpg" /><div class="carousel-caption"><p>It time for "The Next Step".</p></div></div></div><a class="carousel-control left" data-slide="prev" href="#this-carousel-id">‹</a>
 <a class="carousel-control right" data-slide="next" href="#this-carousel-id">›</a>
 </div></div><div class="span7"><h1 class="logo">The Next Step
                    </h1></div></div></div><div class="row"><div class="span12"><div class="title"><p>Shalom Baptist Church, Hutchinson, MN</p></div><div class="span9 left-align b2"><p>Shalom is a church with origins tracing back to a small group of believers who longed
                        for something more than just going through the motions as they found their faith
                        in Christ.</p><p>In 1882 this group joined two other congregations to build the Christian Apostolic
                        Baptist Society. As the congregation outgrew their facility, they eventually purchased
                        a larger building in 1958.</p><p>In 1980, this congregation had outgrown their facilities again, and once more, built
                        a new facility, calling it Shalom Baptist Church. We have been in this building
                        ever since, remaining true to the gospel, and watching God work in immeasurable
                        ways.</p><p>The church is once again experiencing growing pains and we have seen that God is
                        on the move at Shalom and in this community. It''s time to close the gap between
                        where we have been the last 33 years and where God is taking us now. 75% of American
                        churches have plateaued or are decreasing in size for a variety of reasons, yet
                        Shalom has experienced recent growth.</p><p>We believe that God has given Shalom a specific vision, "to immerse the Hutchinson
                        area in the grace of Christ to break down barriers of cynicism and confusion in
                        people''s lives." Not much different than the group of believers who first started
                        this church over 125 years ago.</p><p>By staying status quo, there is a risk of losing that hunger, that growth. Jesus
                        gives us this Great Commission, "Therefore go and make disciples of all nations,
                        baptizing them in the name of the Father and of the Son and of the Holy Spirit,
                        and teaching them to obey everything I have commanded you"<small>(Matthew 28:19-20)</small>.
 </p><p>The time is now and the how by taking "The Next Step" towards ministry expansion.</p><div class="featured"><h3>Will you take the next step with Shalom?</h3><strong>Step 1</strong> 
                        <p>Begin praying for the expansion campaign</p><p><a class="btn btn-primary btn-large" href="mailto:dlmurphy@hutchtel.net?subject=I want to join the prayer team">Join The Next Step Prayer Team</a>
 </p><p>You will receive prayer requests weekly via email.
                    </p><div class="spacer"></div></div></div><div class="span3 left-align"><dl class="leftbar"><dt class="b1 first">Upcoming Events</dt><dd><table><tbody><tr><th>Event
 </th><th>Date
 </th></tr><tr><td>Prayer Drive
                                    </td><td>March&nbsp;9
 </td></tr><tr><td>Celebration Banquet
                                    </td><td>May 5
                                    </td></tr></tbody></table></dd><dt class="b4">My Next Step</dt><dd><div class="media"></div></dd><dt class="b3">FAQ''s</dt><dd>Did you know that Shalom has experienced growth in many ministry areas in 2012.
                            <a href="Content/docs/2012ShalomAnnualReportweb.pdf" target="_blank">Click here to download
                                Shalom''s 2012 Annual Report for more information. </a>
 </dd></dl><div class="bar">&nbsp;</div><div><div class="vcard"><p class="fn"><a class="url" href="http://shalombaptist.org" target="blank">Shalom Baptist Church</a>
 </p><p class="adr"><span class="street-address">1215 Robert''s Rd. SW</span><br /><span class="region">Hutchinson, MN</span><br /><span class="email">Email: <a href="mailto:shalom.sbc@gmail.com">shalom.sbc@gmail.com</a></span>
 </p><p class="tel">320.587.2668</p></div></div></div></div></div>', CAST(0x0000A1810157A426 AS DateTime), N'bobbi', CAST(0x0000A1810157A426 AS DateTime), N'bobbi')
INSERT [dbo].[Content_Template] ([pkContentID], [contentName], [html], [createdOn], [createdBy], [modifiedOn], [modifiedBy]) VALUES (11, N'page2', N'<p>This is a paragraph</p><p>this is another paragraph</p><p>this is a third paragraph</p><p>bye bye</p>', CAST(0x0000A182009E3C98 AS DateTime), N'bobbi', CAST(0x0000A182009E3FA5 AS DateTime), N'bobbi')
INSERT [dbo].[Content_Template] ([pkContentID], [contentName], [html], [createdOn], [createdBy], [modifiedOn], [modifiedBy]) VALUES (12, N'test input form', N'<div class="hero-unit"><h1 class="Heading">a new heading</h1><p class="Tagline">a new tagline too</p><p><a class="btn btn-primary btn-large LearnMore" href="http://prairiesoft.co">you can learn more here</a> </p></div>', CAST(0x0000A1AC007123EE AS DateTime), N'bobbi', CAST(0x0000A1AC007123F1 AS DateTime), N'bobbi')
SET IDENTITY_INSERT [dbo].[Content_Template] OFF
/****** Object:  Table [dbo].[webpages_UsersInRoles]    Script Date: 04/30/2013 14:07:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[webpages_UsersInRoles](
	[UserId] [int] NOT NULL,
	[RoleId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[webpages_UsersInRoles] ([UserId], [RoleId]) VALUES (1, 1)
INSERT [dbo].[webpages_UsersInRoles] ([UserId], [RoleId]) VALUES (2, 1)
/****** Object:  Table [dbo].[cmsSiteSetup]    Script Date: 04/30/2013 14:07:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsSiteSetup](
	[pkSiteSetupId] [int] NOT NULL,
	[fkMaster_Template] [int] NOT NULL,
	[fkFooterContentId] [int] NOT NULL,
	[dateCreated] [datetime] NOT NULL,
	[createdBy] [nvarchar](50) NOT NULL,
	[dateModified] [datetime] NOT NULL,
	[modifiedBy] [nchar](10) NOT NULL,
 CONSTRAINT [PK_SiteSetup] PRIMARY KEY CLUSTERED 
(
	[pkSiteSetupId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[cmsContent_Type]    Script Date: 04/30/2013 14:07:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsContent_Type](
	[pkContentTypeId] [int] IDENTITY(1,1) NOT NULL,
	[contentName] [nvarchar](100) NOT NULL,
	[fkLevelMappingId] [int] NULL,
	[templateHtml] [nvarchar](500) NULL,
	[inputForm] [nvarchar](max) NULL,
 CONSTRAINT [PK_Content_Type] PRIMARY KEY CLUSTERED 
(
	[pkContentTypeId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[cmsContent_Type] ON
INSERT [dbo].[cmsContent_Type] ([pkContentTypeId], [contentName], [fkLevelMappingId], [templateHtml], [inputForm]) VALUES (1, N'Page', 1, N'{content}', NULL)
INSERT [dbo].[cmsContent_Type] ([pkContentTypeId], [contentName], [fkLevelMappingId], [templateHtml], [inputForm]) VALUES (2, N'HeroBar', 2, N'<div class="hero-unit">          <h1 class="Heading">[Heading]</h1>          <p class="Tagline">[Tagline]</p>          <p>            <a class="btn btn-primary btn-large LearnMore">      [LearnMore]    </a>           </p>        </div>', N'<div class="formcontrol">      <h2>HeroBar</h2>      <div class="herobarForm">        <label>Heading:</label>        <input type="text" id="Heading" class="input-medium">        <br>        <label>Tagline:</label>        <input type="text" id="Tagline" class="input-medium">        <br>        <label>Learn More:</label>        <input type="text" id="LearnMore" class="input-medium">     
 <br>        <label>Link in Learn More:</label>        <input type="text" id="LearnMoreLink" class="input-medium">     
   </div>      <div class="Html">              </div>  </div> ')
INSERT [dbo].[cmsContent_Type] ([pkContentTypeId], [contentName], [fkLevelMappingId], [templateHtml], [inputForm]) VALUES (3, N'Ad', 2, N' <section class="ad"><p class="content">[content]</p></section>      ', N'<div class="formcontrol">     
 <h2>Ad</h2>      <div class="AdForm">       
  <label>Ad Text:</label>       
   <textarea type="text" id="content" class="input-medium"></textarea>      </div>      <div class="Html">
             </div>    </div>         ')
INSERT [dbo].[cmsContent_Type] ([pkContentTypeId], [contentName], [fkLevelMappingId], [templateHtml], [inputForm]) VALUES (4, N'ContentArea', 2, N' <section><p class="content">[content]</p></section>      ', N'       <div class="formcontrol">         <h2>ContentArea</h2>      <div class="ContentAreaForm">        <label>Content Text:</label>        <textarea type="text" id="content" class="input-medium"></textarea>       </div>      <div class="Html">              </div>    </div>                ')
INSERT [dbo].[cmsContent_Type] ([pkContentTypeId], [contentName], [fkLevelMappingId], [templateHtml], [inputForm]) VALUES (5, N'Notices', 2, N' <section class="notices"><p class="content">[content]</p></section>      ', N'
     <div class="formcontrol">
       <h2>Notices</h2>
    <div class="NoticeForm">
      <label>Notice Text:</label>
      <input type="text" id="content" class="input-medium"> 
    </div>
    <div class="Html">
      
    </div>
 
</div>
     ')
INSERT [dbo].[cmsContent_Type] ([pkContentTypeId], [contentName], [fkLevelMappingId], [templateHtml], [inputForm]) VALUES (6, N'button', 3, N'<input type="button" id="sendAnswers" value="Send Answers">
', N'         <div class="formcontrol">                 <h2>button</h2>      <div class="buttonForm">                 <label>Button Text:</label>                 <input type="text" id="label" class="input-medium" value="Send Answers">      </div> 
 </div>                        <div class="Html">                </div>     </div>       ')
INSERT [dbo].[cmsContent_Type] ([pkContentTypeId], [contentName], [fkLevelMappingId], [templateHtml], [inputForm]) VALUES (7, N'checkbox', 3, N'
<label class="label">[questiontext]</label><br />
     <input type="checkbox"  value="[value]"> <label class="value"/>      ', N'<div class="formcontrol">
        <h2>
            checkbox</h2>
        <div class="checkboxForm">
             <label>Question Text</label>
            <textarea id="QuestionText" class="input-medium"> </textarea
            <br>
            <label>
                Value:</label>
            <input type="text" id="value" class="input-medium">
           <br>
            <label>
                Name (blank is ok):</label>
            <input type="text" id="name" class="input-medium">
            
            
        </div>
        <div class="Html">
        </div>
    </div>')
INSERT [dbo].[cmsContent_Type] ([pkContentTypeId], [contentName], [fkLevelMappingId], [templateHtml], [inputForm]) VALUES (8, N'combobox', 3, N'  
<label class="questionText">[label]</label>
      <br>      
      <select class="questionSelect">
      </select>      <br>', N'       <div class="formcontrol">        <h2>combobox</h2>        <div class="comboboxForm">
 <label>ComboBox Name:</label>            <input type="text" id="name" class="input-medium">          <br>          <label>              ComboBox Label/Question:</label>          <input type="text" id="questionText" class="input-medium" value="comboQuestion">             <br>        <div class="addmore"> <!-- when addOption button is clicked, add the values from form below to class=items div above  -->             <label>Option Name:</label>            <input type="text" id="text" class="input-medium">            <br>            <label>Option Value:</label>            <input type="text" id="value" class="input-medium">             <br />            
 <button id="addOption" >Add Combobox Option</button>        </div>        </div>        <div class="Html">     </div>  </div>           ')
INSERT [dbo].[cmsContent_Type] ([pkContentTypeId], [contentName], [fkLevelMappingId], [templateHtml], [inputForm]) VALUES (9, N'label', 3, N'<span class="label">[label]</span>      ', N'
<div class="formcontrol">
<h2>label</h2>
<div class="labelForm">
       <label>Label Text:</label>
          <input type="text" id="label" class="input-medium">
          <br>
      </div>
      <div class="Html">
      
      </div>
</div>    
     ')
INSERT [dbo].[cmsContent_Type] ([pkContentTypeId], [contentName], [fkLevelMappingId], [templateHtml], [inputForm]) VALUES (10, N'multiline-textbox', 3, N'<span class="label">[label]</span> 
<br>      <textarea rows="10" cols="80" id="[name]" name="[name]"></textarea>      ', N'  <div class="formcontrol">         <h2>multiline-textbox</h2>         <div class="multilineTextboxForm">          <label>Textbox Label/Question:</label>            <input type="text" id="label" class="input-medium">            <br>         <label>Text box Name:</label>            <input type="text" id="name" class="input-medium">            <br>        </div>        <div class="Html">               </div>  </div>            ')
INSERT [dbo].[cmsContent_Type] ([pkContentTypeId], [contentName], [fkLevelMappingId], [templateHtml], [inputForm]) VALUES (11, N'radiobutton', 3, N'  <label class="label">[questiontext]</label><br />       <input type="radio"  value="[value]"> <label class="value"/>      ', N'<div class="formcontrol">          <h2>              radio</h2>          <div class="radioForm">               <label>Question Text</label>              <textarea id="QuestionText" class="input-medium"> </textarea>              <br>              <label>                  Value:</label>              <input type="text" id="value" class="input-medium">             <br>              <label>                  Name (blank is ok):</label>              <input type="text" id="name" class="input-medium">                                      </div>          <div class="Html">          </div>      </div>')
INSERT [dbo].[cmsContent_Type] ([pkContentTypeId], [contentName], [fkLevelMappingId], [templateHtml], [inputForm]) VALUES (12, N'textbox', 3, N' <label class="label">[Label]</label>      <br>      <input type="text" >      ', N'  <div class="formcontrol">       <h2>textbox</h2>       <div class="textboxForm">        <label>Textbox Label(Question):</label>            <input type="text" id="label" class="input-medium">            <br> 
<label>Textbox Name:</label>            <input type="text" id="name" class="input-medium">            <br>             
       </div>        <div class="Html">         </div>  </div>           ')
INSERT [dbo].[cmsContent_Type] ([pkContentTypeId], [contentName], [fkLevelMappingId], [templateHtml], [inputForm]) VALUES (13, N'ranking', 3, N'
<label class="label">[questiontext]</label><br /> 
<table> <thead><tr>            <th>[text]</th>            </tr> </thead>
<tbody>
<tr><td>[value]</td>
<td><input type="radio" name="[name]" id="[name]" value="[value]"></td>          
</tr>        
</tbody>      
</table>      ', N'  <div class="formcontrol">
<h2>ranking</h2>
<div class="RankingForm">
 <label>Question Text</label><textarea id="QuestionText" class="input-medium"> </textarea><br>  <label>Choices (one per line)</label><textarea id="Choices" class="input-medium"> </textarea><br>  
 <label>Items to be Ranked (one per line)</label><textarea id="Items" class="input-medium"> </textarea><br>
 </div>        
 <div class="Html">              </div>  </div>    ')
INSERT [dbo].[cmsContent_Type] ([pkContentTypeId], [contentName], [fkLevelMappingId], [templateHtml], [inputForm]) VALUES (14, N'checkboxlist', 3, N'<label class="label">[questiontext]</label><br /> 
<div class="choices">   </div>', N'  <div class="formcontrol">         <h2>checkboxlist</h2>         <div class="checkboxlistForm">
<label>Question Text</label><textarea id="QuestionText" class="input-medium"> </textarea><br>  <label>Choices (one per line)</label><textarea id="Choices" class="input-medium"> </textarea><br>  
           </div>        <div class="Html">        </div>  </div>      ')
INSERT [dbo].[cmsContent_Type] ([pkContentTypeId], [contentName], [fkLevelMappingId], [templateHtml], [inputForm]) VALUES (15, N'menu_component', 2, N'       <ul class="dropdown-menu" role="menu">[menu_component]</ul>        ', N'  <div class="formcontrol">         
<h2>menu_component</h2>         
<div class="menucomponentForm">         
<label>Menu Item:</label>            
<input type="text" id="label" class="input-medium">            <br>            
<label>Click Target:</label>            
<input type="text" id="target" class="input-medium" value="http://prairiesoft.co">             <br>            
<button id="addMenuItem">Add Menu Item</button>         </div>        <div class="Html">      </div>  </div>    ')
INSERT [dbo].[cmsContent_Type] ([pkContentTypeId], [contentName], [fkLevelMappingId], [templateHtml], [inputForm]) VALUES (16, N'Three Columns Row', 2, N'
<div class="row">
<div class="span12">
<div class="span4 col1">
[Content column 1]
</div>
<div class="span4 col2">
[Content column 2]
</div>
<div class="span4 col3">
[Content column 3]
</div>
</div>
</div>
', N'<div class="formcontrol">
    <h2>Three Columns Row</h2>
    <div class="threeColsForm">
      <label>Column 1 Contents:</label> <br>
      <textarea type="text" id="col1" class="input-medium"></textarea> <br>
      <label>Column 2 Contents:</label> <br>
      <textarea type="text" id="col2" class="input-medium"></textarea> <br>      
      <label>Column 3 Contents:</label> <br>
      <textarea type="text" id="col3" class="input-medium"></textarea> <br>
    </div>
    <div class="Html">
      
    </div>
</div> ')
INSERT [dbo].[cmsContent_Type] ([pkContentTypeId], [contentName], [fkLevelMappingId], [templateHtml], [inputForm]) VALUES (17, N'Survey Form Email', 5, N'

Hello,


The form [PageName] has been filled in and here are the results:

[SurveyAnswers]

', NULL)
SET IDENTITY_INSERT [dbo].[cmsContent_Type] OFF
/****** Object:  Table [dbo].[cms_Page_Map]    Script Date: 04/30/2013 14:07:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cms_Page_Map](
	[pkMapID] [int] IDENTITY(1,1) NOT NULL,
	[pageName] [nvarchar](50) NOT NULL,
	[fkMasterThemeID] [int] NOT NULL,
	[fkContentID] [int] NOT NULL,
	[fkEditorRoleID] [int] NOT NULL,
	[createdOn] [datetime] NOT NULL,
	[createdBy] [nvarchar](50) NOT NULL,
	[modifiedOn] [datetime] NOT NULL,
	[modifiedBy] [nvarchar](50) NOT NULL,
	[pageTitle] [nvarchar](200) NULL,
	[tags] [nvarchar](500) NULL,
	[isActive] [bit] NULL,
 CONSTRAINT [PK_CMRC_cms_Page_Map] PRIMARY KEY CLUSTERED 
(
	[pkMapID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[cms_Page_Map] ON
INSERT [dbo].[cms_Page_Map] ([pkMapID], [pageName], [fkMasterThemeID], [fkContentID], [fkEditorRoleID], [createdOn], [createdBy], [modifiedOn], [modifiedBy], [pageTitle], [tags], [isActive]) VALUES (3, N'home', 1, 3, 1, CAST(0x0000A16701390CBB AS DateTime), N'cms', CAST(0x0000A16701391018 AS DateTime), N'bobbi', N'Welcome to Shalom Baptist, Hutchinson, MN', NULL, NULL)
INSERT [dbo].[cms_Page_Map] ([pkMapID], [pageName], [fkMasterThemeID], [fkContentID], [fkEditorRoleID], [createdOn], [createdBy], [modifiedOn], [modifiedBy], [pageTitle], [tags], [isActive]) VALUES (19, N'page2', 1, 11, 1, CAST(0x0000A182009E4263 AS DateTime), N'cms', CAST(0x0000A182009E5ECA AS DateTime), N'bobbi', N'Welcome to Shalom Baptist Church', NULL, 1)
INSERT [dbo].[cms_Page_Map] ([pkMapID], [pageName], [fkMasterThemeID], [fkContentID], [fkEditorRoleID], [createdOn], [createdBy], [modifiedOn], [modifiedBy], [pageTitle], [tags], [isActive]) VALUES (20, N'home', 1, 3, 1, CAST(0x0000A18300F17EAA AS DateTime), N'cms', CAST(0x0000A18300F17EAF AS DateTime), N'bobbi', N'Welcome to Shalom Baptist, Hutchinson, MN', NULL, NULL)
INSERT [dbo].[cms_Page_Map] ([pkMapID], [pageName], [fkMasterThemeID], [fkContentID], [fkEditorRoleID], [createdOn], [createdBy], [modifiedOn], [modifiedBy], [pageTitle], [tags], [isActive]) VALUES (21, N'home', 1, 3, 1, CAST(0x0000A18300F4A0BF AS DateTime), N'cms', CAST(0x0000A18300F4A0C1 AS DateTime), N'bobbi', N'Welcome to Shalom Baptist, Hutchinson, MN', NULL, NULL)
INSERT [dbo].[cms_Page_Map] ([pkMapID], [pageName], [fkMasterThemeID], [fkContentID], [fkEditorRoleID], [createdOn], [createdBy], [modifiedOn], [modifiedBy], [pageTitle], [tags], [isActive]) VALUES (22, N'home', 1, 3, 1, CAST(0x0000A18300F908EF AS DateTime), N'cms', CAST(0x0000A18300F908F1 AS DateTime), N'bobbi', N'Welcome to Shalom Baptist, Hutchinson, MN', NULL, NULL)
INSERT [dbo].[cms_Page_Map] ([pkMapID], [pageName], [fkMasterThemeID], [fkContentID], [fkEditorRoleID], [createdOn], [createdBy], [modifiedOn], [modifiedBy], [pageTitle], [tags], [isActive]) VALUES (23, N'test input form', 1, 12, 1, CAST(0x0000A1AC00712435 AS DateTime), N'cms', CAST(0x0000A1AC00712439 AS DateTime), N'bobbi', N'test title', N'input form', 0)
INSERT [dbo].[cms_Page_Map] ([pkMapID], [pageName], [fkMasterThemeID], [fkContentID], [fkEditorRoleID], [createdOn], [createdBy], [modifiedOn], [modifiedBy], [pageTitle], [tags], [isActive]) VALUES (24, N'home', 1, 3, 1, CAST(0x0000A1AE00DEA31F AS DateTime), N'cms', CAST(0x0000A1AE00DEA323 AS DateTime), N'bobbi', N'Welcome to Shalom Baptist, Hutchinson, MN', NULL, NULL)
INSERT [dbo].[cms_Page_Map] ([pkMapID], [pageName], [fkMasterThemeID], [fkContentID], [fkEditorRoleID], [createdOn], [createdBy], [modifiedOn], [modifiedBy], [pageTitle], [tags], [isActive]) VALUES (25, N'home', 1, 3, 1, CAST(0x0000A1AE00F1CD75 AS DateTime), N'cms', CAST(0x0000A1AE00F1CD75 AS DateTime), N'bobbi', N'Welcome to Shalom Baptist, Hutchinson, MN', NULL, NULL)
INSERT [dbo].[cms_Page_Map] ([pkMapID], [pageName], [fkMasterThemeID], [fkContentID], [fkEditorRoleID], [createdOn], [createdBy], [modifiedOn], [modifiedBy], [pageTitle], [tags], [isActive]) VALUES (26, N'home', 1, 3, 1, CAST(0x0000A1AE00F65313 AS DateTime), N'cms', CAST(0x0000A1AE00F65313 AS DateTime), N'bobbi', N'Welcome to Shalom Baptist, Hutchinson, MN', NULL, 1)
INSERT [dbo].[cms_Page_Map] ([pkMapID], [pageName], [fkMasterThemeID], [fkContentID], [fkEditorRoleID], [createdOn], [createdBy], [modifiedOn], [modifiedBy], [pageTitle], [tags], [isActive]) VALUES (27, N'home', 1, 3, 1, CAST(0x0000A1AE00F31780 AS DateTime), N'cms', CAST(0x0000A1AF007E0451 AS DateTime), N'bobbi', N'Welcome to Shalom Baptist, Hutchinson, MN', NULL, NULL)
SET IDENTITY_INSERT [dbo].[cms_Page_Map] OFF
/****** Object:  StoredProcedure [dbo].[GetMainMenu]    Script Date: 04/30/2013 14:07:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetMainMenu]
AS
SET NOCOUNT ON
DECLARE @menu TABLE (
	[pkSiteMapItemID] int NOT NULL,
	[SiteMapItemName] [nvarchar](64) NOT NULL,
	[fkSiteMapParentId] [int] NOT NULL,
	[relativeUrl] [nvarchar](200) NULL,
	[itemOrder] [int] NULL,
	[templateHtml] [nvarchar] (MAX)
)
INSERT INTO @menu SELECT  -2 AS [pkSiteMapItemID]
,'template' AS [SiteMapItemName],
  -2 AS [fkSiteMapParentId],
  '' AS [relativeUrl],
  -1 AS [itemOrder] ,
  [templateHtml]
  FROM [cmsContent_Type]
  WHERE contentName = 'menu_component'
  
 INSERT INTO @menu  SELECT [pkSiteMapItemID]
	  ,[SiteMapItemName]
      ,[fkSiteMapParentId]
      ,[relativeUrl]
      ,[itemOrder]
      , '' AS [templateHtml]
  FROM [cmsSiteMapItems]
WHERE [fkSiteMapParentId] = -1

INSERT INTO @menu SELECT [pkSiteMapItemID]
	  ,[SiteMapItemName]
      ,[fkSiteMapParentId]
      ,[relativeUrl]
      ,[itemOrder]
      , '' AS [templateHtml]
  FROM [cmsSiteMapItems]
  WHERE [fkSiteMapParentId] IN 
  ( SELECT [pkSiteMapItemID]
  FROM [cmsSiteMapItems]
WHERE [fkSiteMapParentId] = -1)

SELECT * FROM @menu order by itemOrder
GO
/****** Object:  Table [dbo].[cmsContent_Type_Mapping]    Script Date: 04/30/2013 14:07:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsContent_Type_Mapping](
	[pkBcId] [int] IDENTITY(1,1) NOT NULL,
	[fkParent] [int] NOT NULL,
	[fkEditorsRole] [int] NOT NULL,
	[fkContentType] [int] NOT NULL,
	[fkContent] [int] NULL,
	[domInsertionPoint] [nvarchar](50) NULL,
	[dateCreated] [datetime] NOT NULL,
	[createdBy] [nvarchar](50) NOT NULL,
	[dateModified] [datetime] NOT NULL,
	[modifiedBy] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Content_Type_Mapping] PRIMARY KEY CLUSTERED 
(
	[pkBcId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'page, hero,ad,notice -fk into ContentType table' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'cmsContent_Type_Mapping', @level2type=N'COLUMN',@level2name=N'fkContentType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Partial page content, DOM where the content is inserted' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'cmsContent_Type_Mapping', @level2type=N'COLUMN',@level2name=N'domInsertionPoint'
GO
SET IDENTITY_INSERT [dbo].[cmsContent_Type_Mapping] ON
INSERT [dbo].[cmsContent_Type_Mapping] ([pkBcId], [fkParent], [fkEditorsRole], [fkContentType], [fkContent], [domInsertionPoint], [dateCreated], [createdBy], [dateModified], [modifiedBy]) VALUES (16, 19, 1, 1, 11, N'content_template', CAST(0x0000A182009E8D81 AS DateTime), N'bobbi', CAST(0x0000A182009E8569 AS DateTime), N'bobbi')
INSERT [dbo].[cmsContent_Type_Mapping] ([pkBcId], [fkParent], [fkEditorsRole], [fkContentType], [fkContent], [domInsertionPoint], [dateCreated], [createdBy], [dateModified], [modifiedBy]) VALUES (18, 27, 1, 1, 3, N'content_template', CAST(0x0000A18300F4BF38 AS DateTime), N'bobbi', CAST(0x0000A1AF007E0459 AS DateTime), N'bobbi')
INSERT [dbo].[cmsContent_Type_Mapping] ([pkBcId], [fkParent], [fkEditorsRole], [fkContentType], [fkContent], [domInsertionPoint], [dateCreated], [createdBy], [dateModified], [modifiedBy]) VALUES (20, 3, 1, 1, 3, N'body', CAST(0x0000A1830104D9D2 AS DateTime), N'system', CAST(0x0000A1830104DCA4 AS DateTime), N'system')
INSERT [dbo].[cmsContent_Type_Mapping] ([pkBcId], [fkParent], [fkEditorsRole], [fkContentType], [fkContent], [domInsertionPoint], [dateCreated], [createdBy], [dateModified], [modifiedBy]) VALUES (21, 23, 1, 1, 12, N'content_template', CAST(0x0000A1AC00712473 AS DateTime), N'bobbi', CAST(0x0000A1AC00712465 AS DateTime), N'bobbi')
SET IDENTITY_INSERT [dbo].[cmsContent_Type_Mapping] OFF
/****** Object:  Default [DF__webpages___IsCon__239E4DCF]    Script Date: 04/30/2013 14:07:22 ******/
ALTER TABLE [dbo].[webpages_Membership] ADD  DEFAULT ((0)) FOR [IsConfirmed]
GO
/****** Object:  Default [DF__webpages___Passw__24927208]    Script Date: 04/30/2013 14:07:22 ******/
ALTER TABLE [dbo].[webpages_Membership] ADD  DEFAULT ((0)) FOR [PasswordFailuresSinceLastSuccess]
GO
/****** Object:  ForeignKey [fk_RoleId]    Script Date: 04/30/2013 14:07:22 ******/
ALTER TABLE [dbo].[webpages_UsersInRoles]  WITH CHECK ADD  CONSTRAINT [fk_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[webpages_Roles] ([RoleId])
GO
ALTER TABLE [dbo].[webpages_UsersInRoles] CHECK CONSTRAINT [fk_RoleId]
GO
/****** Object:  ForeignKey [fk_UserId]    Script Date: 04/30/2013 14:07:22 ******/
ALTER TABLE [dbo].[webpages_UsersInRoles]  WITH CHECK ADD  CONSTRAINT [fk_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[webpages_UsersInRoles] CHECK CONSTRAINT [fk_UserId]
GO
/****** Object:  ForeignKey [FK_SiteSetup_Master_Template]    Script Date: 04/30/2013 14:07:22 ******/
ALTER TABLE [dbo].[cmsSiteSetup]  WITH CHECK ADD  CONSTRAINT [FK_SiteSetup_Master_Template] FOREIGN KEY([fkMaster_Template])
REFERENCES [dbo].[Master_Template] ([pkMasterID])
GO
ALTER TABLE [dbo].[cmsSiteSetup] CHECK CONSTRAINT [FK_SiteSetup_Master_Template]
GO
/****** Object:  ForeignKey [FK_SiteSetup_Master_Template1]    Script Date: 04/30/2013 14:07:22 ******/
ALTER TABLE [dbo].[cmsSiteSetup]  WITH CHECK ADD  CONSTRAINT [FK_SiteSetup_Master_Template1] FOREIGN KEY([fkMaster_Template])
REFERENCES [dbo].[Master_Template] ([pkMasterID])
GO
ALTER TABLE [dbo].[cmsSiteSetup] CHECK CONSTRAINT [FK_SiteSetup_Master_Template1]
GO
/****** Object:  ForeignKey [FK_Content_Type_Level_Mapping]    Script Date: 04/30/2013 14:07:22 ******/
ALTER TABLE [dbo].[cmsContent_Type]  WITH CHECK ADD  CONSTRAINT [FK_Content_Type_Level_Mapping] FOREIGN KEY([fkLevelMappingId])
REFERENCES [dbo].[cmsLevel_Mapping] ([pkLevelMappingId])
GO
ALTER TABLE [dbo].[cmsContent_Type] CHECK CONSTRAINT [FK_Content_Type_Level_Mapping]
GO
/****** Object:  ForeignKey [FK_cms_Page_Map_Content_Template]    Script Date: 04/30/2013 14:07:22 ******/
ALTER TABLE [dbo].[cms_Page_Map]  WITH CHECK ADD  CONSTRAINT [FK_cms_Page_Map_Content_Template] FOREIGN KEY([fkContentID])
REFERENCES [dbo].[Content_Template] ([pkContentID])
GO
ALTER TABLE [dbo].[cms_Page_Map] CHECK CONSTRAINT [FK_cms_Page_Map_Content_Template]
GO
/****** Object:  ForeignKey [FK_cms_Page_Map_Master_Template]    Script Date: 04/30/2013 14:07:22 ******/
ALTER TABLE [dbo].[cms_Page_Map]  WITH CHECK ADD  CONSTRAINT [FK_cms_Page_Map_Master_Template] FOREIGN KEY([fkMasterThemeID])
REFERENCES [dbo].[Master_Template] ([pkMasterID])
GO
ALTER TABLE [dbo].[cms_Page_Map] CHECK CONSTRAINT [FK_cms_Page_Map_Master_Template]
GO
/****** Object:  ForeignKey [FK_cms_Page_Map_webpages_Roles]    Script Date: 04/30/2013 14:07:22 ******/
ALTER TABLE [dbo].[cms_Page_Map]  WITH CHECK ADD  CONSTRAINT [FK_cms_Page_Map_webpages_Roles] FOREIGN KEY([fkEditorRoleID])
REFERENCES [dbo].[webpages_Roles] ([RoleId])
GO
ALTER TABLE [dbo].[cms_Page_Map] CHECK CONSTRAINT [FK_cms_Page_Map_webpages_Roles]
GO
/****** Object:  ForeignKey [FK_Content_Type_Mapping_Content_Template]    Script Date: 04/30/2013 14:07:25 ******/
ALTER TABLE [dbo].[cmsContent_Type_Mapping]  WITH CHECK ADD  CONSTRAINT [FK_Content_Type_Mapping_Content_Template] FOREIGN KEY([fkContent])
REFERENCES [dbo].[Content_Template] ([pkContentID])
GO
ALTER TABLE [dbo].[cmsContent_Type_Mapping] CHECK CONSTRAINT [FK_Content_Type_Mapping_Content_Template]
GO
/****** Object:  ForeignKey [FK_Content_Type_Mapping_Content_Type]    Script Date: 04/30/2013 14:07:25 ******/
ALTER TABLE [dbo].[cmsContent_Type_Mapping]  WITH CHECK ADD  CONSTRAINT [FK_Content_Type_Mapping_Content_Type] FOREIGN KEY([fkContentType])
REFERENCES [dbo].[cmsContent_Type] ([pkContentTypeId])
GO
ALTER TABLE [dbo].[cmsContent_Type_Mapping] CHECK CONSTRAINT [FK_Content_Type_Mapping_Content_Type]
GO
/****** Object:  ForeignKey [FK_Content_Type_Mapping_webpages_Roles]    Script Date: 04/30/2013 14:07:25 ******/
ALTER TABLE [dbo].[cmsContent_Type_Mapping]  WITH CHECK ADD  CONSTRAINT [FK_Content_Type_Mapping_webpages_Roles] FOREIGN KEY([fkEditorsRole])
REFERENCES [dbo].[webpages_Roles] ([RoleId])
GO
ALTER TABLE [dbo].[cmsContent_Type_Mapping] CHECK CONSTRAINT [FK_Content_Type_Mapping_webpages_Roles]
GO
