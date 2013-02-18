USE [PrairieCMS]
GO
/****** Object:  Table [dbo].[webpages_Roles]    Script Date: 02/18/2013 14:59:06 ******/
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
/****** Object:  Table [dbo].[webpages_OAuthMembership]    Script Date: 02/18/2013 14:59:06 ******/
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
/****** Object:  Table [dbo].[webpages_Membership]    Script Date: 02/18/2013 14:59:06 ******/
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
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (1, CAST(0x0000A15F017F822C AS DateTime), NULL, 1, NULL, 0, N'AGaJlnOP7DTWtvj11jyfkY/xvu5B8YAL1tZGFaHih5epkerdF8W/cPgJH+LtJ2QPCA==', CAST(0x0000A15F017F822C AS DateTime), N'', NULL, NULL)
/****** Object:  Table [dbo].[Users]    Script Date: 02/18/2013 14:59:06 ******/
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


/****** Object:  Table [dbo].[Master_Template]    Script Date: 02/18/2013 14:59:06 ******/
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
INSERT [dbo].[Master_Template] ([pkMasterID], [themeName], [html], [createdOn], [createdBy], [modifiedOn], [modifiedBy], [markDown]) VALUES (1, N'Master Page', N'
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href=''http://fonts.googleapis.com/css?family=Lustria&subset=latin,latin-ext'' rel=''stylesheet'' type=''text/css''>
    <link href=''http://fonts.googleapis.com/css?family=Open+Sans&subset=latin,latin-ext'' rel=''stylesheet'' type=''text/css''>
    <link href="../_assets/main2012.less" rel="stylesheet" type="text/css" />
    <link href="../_assets/nav2012.less" rel="stylesheet" type="text/css" />
    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.8.1/jquery.min.js"></script>
    <!--[if IE 6]>
    <link rel="stylesheet" type="text/css" href="/_assets/ie6.css" />
    <![endif]-->
    <!--[if IE 7]>
        <link rel="stylesheet" type="text/css" href="/_assets/ie7.css" />
    <![endif]-->
      <!--[if IE 8]>
        <link rel="stylesheet" type="text/css" href="/_assets/ie8.css" />
    <![endif]-->
    <asp:ContentPlaceHolder ID="head" runat="server">
    </asp:ContentPlaceHolder>
</head>
<body><div id="wrapper">
    
    <div id="named">
        <a name="top"></a>
      {menu_component}
 </div>
    <div id="tophalf" class="post">
        <form id="form1" runat="server">
        <a href="/">
            <div id="logo">
                Shalom Baptist Church</div>
        </a>
        <div style="clear: both">
        </div>
        <div class="timesdirections">
            <h3>Directions</h3>
            <h4>1215 Roberts Road SW<br />
                Hutchinson, MN 55350 
                <a href="https://maps.google.com/maps?q=1215+Roberts+Road+Southwest,+Hutchinson,+MN&hl=en&sll=46.44186,-93.36129&sspn=8.221827,16.21582&oq=1215+Roberts+Road+SW,+hutchinson&t=h&hnear=1215+Roberts+Rd+SW,+Hutchinson,+Minnesota+55350&z=16">(map)</a></h4>
        </div>
        <div class="timesdirections">
            <h3>Sunday Worship Services:</h3>
            <h4>9 AM AND 10:30 AM</h4>
            </div>
        <div class="divider">
        </div>
        {content_template}
    </div>
    <div id="footer"><a style="float:right;" href="http://www.facebook.com/home.php?#!/pages/Hutchinson-MN/Shalom-Baptist-Church-Hutchinson-MN/152857658060134?ref=ts"><img src="/assets/images/facebook.png" alt="Shalom''s Facebook Page" /></a>
        <p>
            <a href="/">Home</a> | <a href="AboutUs">About</a> | <a href="/Contact">
                Contact</a> | <a href="SiteMap">Site Map</a></p>
         
        <p>
            &copy; 2009-2011 Shalom Baptist Church<br />
            1215 Roberts Road Southwest<br />
            Hutchinson MN 55350 320-587-2668<br />
        </p>
        <div id="purpose">
            <h3>
                Shalom’s Purpose</h3>
            <h4>
                to glorify God by making more devoted followers of Christ.</h4>
        </div>

    </div>
    </div>
</body>
</html>', CAST(0x0000A1660085DEF8 AS DateTime), N'bobbi', CAST(0x0000A16600E291B9 AS DateTime), N'cms', NULL)
SET IDENTITY_INSERT [dbo].[Master_Template] OFF
/****** Object:  Table [dbo].[Log]    Script Date: 02/18/2013 14:59:06 ******/
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
/****** Object:  Table [dbo].[cmsSiteMapItems]    Script Date: 02/18/2013 14:59:06 ******/
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
INSERT [dbo].[cmsSiteMapItems] ([pkSiteMapItemID], [SiteMapItemName], [fkSiteMapParentId], [relativeUrl], [itemOrder]) VALUES (1, N'Home', -1, N'/', 1)
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
/****** Object:  Table [dbo].[cmsLevel_Mapping]    Script Date: 02/18/2013 14:59:06 ******/
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
SET IDENTITY_INSERT [dbo].[cmsLevel_Mapping] OFF
/****** Object:  Table [dbo].[Content_Template]    Script Date: 02/18/2013 14:59:06 ******/
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
INSERT [dbo].[Content_Template] ([pkContentID], [contentName], [html], [createdOn], [createdBy], [modifiedOn], [modifiedBy]) VALUES (1, N'/', N'<p>
<script src="/assets/js/crossfade/jquery.easing.1.3.js" type="text/javascript"></script>
<script src="/assets/js/crossfade/jquery.pause.min.js" type="text/javascript"></script>
<script src="/assets/js/crossfade/jquery.cross-slide.min.js" type="text/javascript"></script>
<script src="/assets/js/crossfade/messageboard.js" type="text/javascript"></script>
</p>
<div id="messageboard">
<p id="picid1" class="messageseries"><img title="unstoppable" src="images/unstoppable-E-Banner.png" alt="unstoppable series" width="923" height="280" /></p>
<p id="picid2" class="messageseries"><a href="http://eepurl.com/l5DTr"><img title="subscribe to e-news" src="/images/BANNER-enews-subscribe.jpg" alt="subscribe to e-news" width="923" height="280" /></a></p>
<p id="picid3" class="messageseries"><img title="griefshare at Shalom" src="assets/images/griefsharebanner.png" alt="griefshare at Shalom" width="923" height="280" /></p>
<p id="picid4" class="messageseries"><img title="Awana Clubs at Shalom " src="assets/images/Awanaebanner.png" alt="Awana Clubs at Shalom " width="923" height="280" /></p>
<p id="picid5" class="messageseries"><a href="http://www.youtube.com/watch?v=lr_34vouvMk" target="blank"><img src="assets/images/altestimonybanner.png" alt="Testimony" width="923" height="289" /></a></p>
</div>
<div id="FrontPageLinkButtons"><a class="fpmessages" href="index.php?id=28">MESSAGES</a> <a class="fpblog" href="http://www.rickstapleton.com">PASTOR''S BLOG</a> <a class="fpcalendar" href="index.php?id=22">CALENDAR</a> </div>
<table id="needToKnow" border="0" cellspacing="10">
<tbody>
<tr valign="top">
<td width="34%">
<h3 style="TEXT-ALIGN: center">EVERYONE IS WELCOME!</h3>
<h3 style="TEXT-ALIGN: center">Sunday Worship times:<br /></h3>
<p style="text-align: center;">9 AM AND 10:30 AM</p>
<p style="text-align: center;"><br /><strong>SUNDAY SCHOOL</strong></p>
<p style="text-align: center;">9 AM<strong><br /></strong>Youth, children and adults</p>
<p style="text-align: center;">&nbsp;</p>
</td>
<td width="30%">
<p style="text-align: center;">Shalom is a community of real people working together to make a difference in their world for Christ. To us, the church is not just a building, but people who need each other, and the transforming power of God. We invite you to get to know us by browsing our site, then come and experience Shalom in person. We know you''ll fit right in. <strong></strong></p>
</td>
<td width="34%">
<p style="text-align: center;"><strong>GROWTH GROUPS</strong></p>
<p style="text-align: center;"><a href="http://shalombaptist.org/index.php?id=7"></a></p>
<p style="text-align: center;">Participate in one of several classes <br />just for adults. Classes meet Sundays at 9 AM at the Hutchinson High School (across the street from Shalom). </p>
</td>
</tr>
</tbody>
</table>', CAST(0x0000A167008AF2B4 AS DateTime), N'bobbi', CAST(0x0000A167008AF4E1 AS DateTime), N'bobbi')
INSERT [dbo].[Content_Template] ([pkContentID], [contentName], [html], [createdOn], [createdBy], [modifiedOn], [modifiedBy]) VALUES (2, N'/', N'<p>
<script src="/assets/js/crossfade/jquery.easing.1.3.js" type="text/javascript"></script>
<script src="/assets/js/crossfade/jquery.pause.min.js" type="text/javascript"></script>
<script src="/assets/js/crossfade/jquery.cross-slide.min.js" type="text/javascript"></script>
<script src="/assets/js/crossfade/messageboard.js" type="text/javascript"></script>
</p>
<div id="messageboard">
<p id="picid1" class="messageseries"><img title="unstoppable" src="images/unstoppable-E-Banner.png" alt="unstoppable series" width="923" height="280" /></p>
<p id="picid2" class="messageseries"><a href="http://eepurl.com/l5DTr"><img title="subscribe to e-news" src="/images/BANNER-enews-subscribe.jpg" alt="subscribe to e-news" width="923" height="280" /></a></p>
<p id="picid3" class="messageseries"><img title="griefshare at Shalom" src="assets/images/griefsharebanner.png" alt="griefshare at Shalom" width="923" height="280" /></p>
<p id="picid4" class="messageseries"><img title="Awana Clubs at Shalom " src="assets/images/Awanaebanner.png" alt="Awana Clubs at Shalom " width="923" height="280" /></p>
<p id="picid5" class="messageseries"><a href="http://www.youtube.com/watch?v=lr_34vouvMk" target="blank"><img src="assets/images/altestimonybanner.png" alt="Testimony" width="923" height="289" /></a></p>
</div>
<div id="FrontPageLinkButtons"><a class="fpmessages" href="index.php?id=28">MESSAGES</a> <a class="fpblog" href="http://www.rickstapleton.com">PASTOR''S BLOG</a> <a class="fpcalendar" href="index.php?id=22">CALENDAR</a> </div>
<table id="needToKnow" border="0" cellspacing="10">
<tbody>
<tr valign="top">
<td width="34%">
<h3 style="TEXT-ALIGN: center">EVERYONE IS WELCOME!</h3>
<h3 style="TEXT-ALIGN: center">Sunday Worship times:<br /></h3>
<p style="text-align: center;">9 AM AND 10:30 AM</p>
<p style="text-align: center;"><br /><strong>SUNDAY SCHOOL</strong></p>
<p style="text-align: center;">9 AM<strong><br /></strong>Youth, children and adults</p>
<p style="text-align: center;">&nbsp;</p>
</td>
<td width="30%">
<p style="text-align: center;">Shalom is a community of real people working together to make a difference in their world for Christ. To us, the church is not just a building, but people who need each other, and the transforming power of God. We invite you to get to know us by browsing our site, then come and experience Shalom in person. We know you''ll fit right in. <strong></strong></p>
</td>
<td width="34%">
<p style="text-align: center;"><strong>GROWTH GROUPS</strong></p>
<p style="text-align: center;"><a href="http://shalombaptist.org/index.php?id=7"></a></p>
<p style="text-align: center;">Participate in one of several classes <br />just for adults. Classes meet Sundays at 9 AM at the Hutchinson High School (across the street from Shalom). </p>
</td>
</tr>
</tbody>
</table>', CAST(0x0000A1670125A41C AS DateTime), N'bobbi', CAST(0x0000A1670125A6F3 AS DateTime), N'bobbi')
INSERT [dbo].[Content_Template] ([pkContentID], [contentName], [html], [createdOn], [createdBy], [modifiedOn], [modifiedBy]) VALUES (3, N'/', N'<p>
<script src="/assets/js/crossfade/jquery.easing.1.3.js" type="text/javascript"></script>
<script src="/assets/js/crossfade/jquery.pause.min.js" type="text/javascript"></script>
<script src="/assets/js/crossfade/jquery.cross-slide.min.js" type="text/javascript"></script>
<script src="/assets/js/crossfade/messageboard.js" type="text/javascript"></script>
</p>
<div id="messageboard">
<p id="picid1" class="messageseries"><img title="unstoppable" src="images/unstoppable-E-Banner.png" alt="unstoppable series" width="923" height="280" /></p>
<p id="picid2" class="messageseries"><a href="http://eepurl.com/l5DTr"><img title="subscribe to e-news" src="/images/BANNER-enews-subscribe.jpg" alt="subscribe to e-news" width="923" height="280" /></a></p>
<p id="picid3" class="messageseries"><img title="griefshare at Shalom" src="assets/images/griefsharebanner.png" alt="griefshare at Shalom" width="923" height="280" /></p>
<p id="picid4" class="messageseries"><img title="Awana Clubs at Shalom " src="assets/images/Awanaebanner.png" alt="Awana Clubs at Shalom " width="923" height="280" /></p>
<p id="picid5" class="messageseries"><a href="http://www.youtube.com/watch?v=lr_34vouvMk" target="blank"><img src="assets/images/altestimonybanner.png" alt="Testimony" width="923" height="289" /></a></p>
</div>
<div id="FrontPageLinkButtons"><a class="fpmessages" href="index.php?id=28">MESSAGES</a> <a class="fpblog" href="http://www.rickstapleton.com">PASTOR''S BLOG</a> <a class="fpcalendar" href="index.php?id=22">CALENDAR</a> </div>
<table id="needToKnow" border="0" cellspacing="10">
<tbody>
<tr valign="top">
<td width="34%">
<h3 style="TEXT-ALIGN: center">EVERYONE IS WELCOME!</h3>
<h3 style="TEXT-ALIGN: center">Sunday Worship times:<br /></h3>
<p style="text-align: center;">9 AM AND 10:30 AM</p>
<p style="text-align: center;"><br /><strong>SUNDAY SCHOOL</strong></p>
<p style="text-align: center;">9 AM<strong><br /></strong>Youth, children and adults</p>
<p style="text-align: center;">&nbsp;</p>
</td>
<td width="30%">
<p style="text-align: center;">Shalom is a community of real people working together to make a difference in their world for Christ. To us, the church is not just a building, but people who need each other, and the transforming power of God. We invite you to get to know us by browsing our site, then come and experience Shalom in person. We know you''ll fit right in. <strong></strong></p>
</td>
<td width="34%">
<p style="text-align: center;"><strong>GROWTH GROUPS</strong></p>
<p style="text-align: center;"><a href="http://shalombaptist.org/index.php?id=7"></a></p>
<p style="text-align: center;">Participate in one of several classes <br />just for adults. Classes meet Sundays at 9 AM at the Hutchinson High School (across the street from Shalom). </p>
</td>
</tr>
</tbody>
</table>', CAST(0x0000A16701390577 AS DateTime), N'bobbi', CAST(0x0000A16701390790 AS DateTime), N'bobbi')
SET IDENTITY_INSERT [dbo].[Content_Template] OFF
/****** Object:  Table [dbo].[webpages_UsersInRoles]    Script Date: 02/18/2013 14:59:06 ******/
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
/****** Object:  Table [dbo].[cmsSiteSetup]    Script Date: 02/18/2013 14:59:06 ******/
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
/****** Object:  Table [dbo].[cmsContent_Type]    Script Date: 02/18/2013 14:59:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsContent_Type](
	[pkContentTypeId] [int] IDENTITY(1,1) NOT NULL,
	[contentName] [nvarchar](100) NOT NULL,
	[fkLevelMappingId] [int] NULL,
	[templateHtml] [nvarchar](500) NULL,
 CONSTRAINT [PK_Content_Type] PRIMARY KEY CLUSTERED 
(
	[pkContentTypeId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[cmsContent_Type] ON
INSERT [dbo].[cmsContent_Type] ([pkContentTypeId], [contentName], [fkLevelMappingId], [templateHtml]) VALUES (1, N'Page', 1, N'{content}')
INSERT [dbo].[cmsContent_Type] ([pkContentTypeId], [contentName], [fkLevelMappingId], [templateHtml]) VALUES (2, N'HeroBar', 2, N'<div class="hero-unit">  <h1>{Heading}</h1>  <p>{Tagline}</p>  <p>    <a class="btn btn-primary btn-large">      {Learn more}    </a>  </p></div>')
INSERT [dbo].[cmsContent_Type] ([pkContentTypeId], [contentName], [fkLevelMappingId], [templateHtml]) VALUES (3, N'Ad', 2, N'<div class="ad">{content}</div>')
INSERT [dbo].[cmsContent_Type] ([pkContentTypeId], [contentName], [fkLevelMappingId], [templateHtml]) VALUES (4, N'ContentArea', 2, N'<div>{content}</div>')
INSERT [dbo].[cmsContent_Type] ([pkContentTypeId], [contentName], [fkLevelMappingId], [templateHtml]) VALUES (5, N'Notices', 2, N'<div class="alert">{content}</div>')
INSERT [dbo].[cmsContent_Type] ([pkContentTypeId], [contentName], [fkLevelMappingId], [templateHtml]) VALUES (6, N'button', 3, N'<input type="button" id="[name]" value="[label]">')
INSERT [dbo].[cmsContent_Type] ([pkContentTypeId], [contentName], [fkLevelMappingId], [templateHtml]) VALUES (7, N'checkbox', 3, N'[label]<input type="checkbox" id="[name]" name="[name]" value="[value]" />[text]')
INSERT [dbo].[cmsContent_Type] ([pkContentTypeId], [contentName], [fkLevelMappingId], [templateHtml]) VALUES (8, N'combobox', 3, N'[label]<br/><select id="[name]" name="[name]"> [repeat] <option value="[value]">[text]</option>[endrepeat]</select>')
INSERT [dbo].[cmsContent_Type] ([pkContentTypeId], [contentName], [fkLevelMappingId], [templateHtml]) VALUES (9, N'label', 3, N'[label]')
INSERT [dbo].[cmsContent_Type] ([pkContentTypeId], [contentName], [fkLevelMappingId], [templateHtml]) VALUES (10, N'multiline-textbox', 3, N'[label]<br/><textarea rows="10" cols="80" id="[name]" name="[name]"></textarea>')
INSERT [dbo].[cmsContent_Type] ([pkContentTypeId], [contentName], [fkLevelMappingId], [templateHtml]) VALUES (11, N'radiobutton', 3, N'<input type="radio" name="[name]" id="[name]" value="[value]" /> [text]')
INSERT [dbo].[cmsContent_Type] ([pkContentTypeId], [contentName], [fkLevelMappingId], [templateHtml]) VALUES (12, N'textbox', 3, N'[label]<br/><input type="text" name="[name]" id="[name]" />')
INSERT [dbo].[cmsContent_Type] ([pkContentTypeId], [contentName], [fkLevelMappingId], [templateHtml]) VALUES (13, N'ranking', 3, N'<table>
<tr><th>[text]</th>
[repeat]
<th><span>[frequencyvalue]</span></th>
[endrepeat]
</tr>
[repeat]
<tr><td style="text-align:left; padding-bottom:8px;">[value]</td>
[repeat]
<td><input type="radio" name="[name]" id="[name]" value="[value]" /></td>
[endrepeat]
</tr>
[endrepeat]
</table>')
INSERT [dbo].[cmsContent_Type] ([pkContentTypeId], [contentName], [fkLevelMappingId], [templateHtml]) VALUES (14, N'checkboxlist', 3, N'[label] <br />  
[repeat]
<input type="checkbox" name="[name]" id="[name]" value="[value]" />[text]
[endrepeat]')
INSERT [dbo].[cmsContent_Type] ([pkContentTypeId], [contentName], [fkLevelMappingId], [templateHtml]) VALUES (15, N'menu_component', 2, N'<ul class="dropdown-menu" role="menu" >{menu_component}</ul>')
SET IDENTITY_INSERT [dbo].[cmsContent_Type] OFF
/****** Object:  Table [dbo].[cms_Page_Map]    Script Date: 02/18/2013 14:59:06 ******/
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
INSERT [dbo].[cms_Page_Map] ([pkMapID], [pageName], [fkMasterThemeID], [fkContentID], [fkEditorRoleID], [createdOn], [createdBy], [modifiedOn], [modifiedBy], [pageTitle], [tags], [isActive]) VALUES (3, N'/', 1, 3, 1, CAST(0x0000A16701390CBB AS DateTime), N'cms', CAST(0x0000A16701391018 AS DateTime), N'bobbi', N'Welcome to Shalom Baptist, Hutchinson, MN', NULL, NULL)
SET IDENTITY_INSERT [dbo].[cms_Page_Map] OFF
/****** Object:  StoredProcedure [dbo].[GetMainMenu]    Script Date: 02/18/2013 14:59:09 ******/
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
/****** Object:  Table [dbo].[cmsContent_Type_Mapping]    Script Date: 02/18/2013 14:59:06 ******/
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
/****** Object:  Default [DF__webpages___IsCon__239E4DCF]    Script Date: 02/18/2013 14:59:06 ******/
ALTER TABLE [dbo].[webpages_Membership] ADD  DEFAULT ((0)) FOR [IsConfirmed]
GO
/****** Object:  Default [DF__webpages___Passw__24927208]    Script Date: 02/18/2013 14:59:06 ******/
ALTER TABLE [dbo].[webpages_Membership] ADD  DEFAULT ((0)) FOR [PasswordFailuresSinceLastSuccess]
GO
/****** Object:  ForeignKey [FK_cms_Page_Map_Master_Template]    Script Date: 02/18/2013 14:59:06 ******/
ALTER TABLE [dbo].[cms_Page_Map]  WITH CHECK ADD  CONSTRAINT [FK_cms_Page_Map_Master_Template] FOREIGN KEY([fkMasterThemeID])
REFERENCES [dbo].[Master_Template] ([pkMasterID])
GO
ALTER TABLE [dbo].[cms_Page_Map] CHECK CONSTRAINT [FK_cms_Page_Map_Master_Template]
GO
/****** Object:  ForeignKey [FK_cms_Page_Map_webpages_Roles]    Script Date: 02/18/2013 14:59:06 ******/
ALTER TABLE [dbo].[cms_Page_Map]  WITH CHECK ADD  CONSTRAINT [FK_cms_Page_Map_webpages_Roles] FOREIGN KEY([fkEditorRoleID])
REFERENCES [dbo].[webpages_Roles] ([RoleId])
GO
ALTER TABLE [dbo].[cms_Page_Map] CHECK CONSTRAINT [FK_cms_Page_Map_webpages_Roles]
GO
/****** Object:  ForeignKey [FK_Content_Type_Level_Mapping]    Script Date: 02/18/2013 14:59:06 ******/
ALTER TABLE [dbo].[cmsContent_Type]  WITH CHECK ADD  CONSTRAINT [FK_Content_Type_Level_Mapping] FOREIGN KEY([fkLevelMappingId])
REFERENCES [dbo].[cmsLevel_Mapping] ([pkLevelMappingId])
GO
ALTER TABLE [dbo].[cmsContent_Type] CHECK CONSTRAINT [FK_Content_Type_Level_Mapping]
GO
/****** Object:  ForeignKey [FK_cmsContent_Type_Mapping_cms_Page_Map]    Script Date: 02/18/2013 14:59:06 ******/
ALTER TABLE [dbo].[cmsContent_Type_Mapping]  WITH CHECK ADD  CONSTRAINT [FK_cmsContent_Type_Mapping_cms_Page_Map] FOREIGN KEY([fkParent])
REFERENCES [dbo].[cms_Page_Map] ([pkMapID])
GO
ALTER TABLE [dbo].[cmsContent_Type_Mapping] CHECK CONSTRAINT [FK_cmsContent_Type_Mapping_cms_Page_Map]
GO
/****** Object:  ForeignKey [FK_Content_Type_Mapping_Content_Template]    Script Date: 02/18/2013 14:59:06 ******/
ALTER TABLE [dbo].[cmsContent_Type_Mapping]  WITH CHECK ADD  CONSTRAINT [FK_Content_Type_Mapping_Content_Template] FOREIGN KEY([fkContent])
REFERENCES [dbo].[Content_Template] ([pkContentID])
GO
ALTER TABLE [dbo].[cmsContent_Type_Mapping] CHECK CONSTRAINT [FK_Content_Type_Mapping_Content_Template]
GO
/****** Object:  ForeignKey [FK_Content_Type_Mapping_Content_Type]    Script Date: 02/18/2013 14:59:06 ******/
ALTER TABLE [dbo].[cmsContent_Type_Mapping]  WITH CHECK ADD  CONSTRAINT [FK_Content_Type_Mapping_Content_Type] FOREIGN KEY([fkContentType])
REFERENCES [dbo].[cmsContent_Type] ([pkContentTypeId])
GO
ALTER TABLE [dbo].[cmsContent_Type_Mapping] CHECK CONSTRAINT [FK_Content_Type_Mapping_Content_Type]
GO
/****** Object:  ForeignKey [FK_Content_Type_Mapping_webpages_Roles]    Script Date: 02/18/2013 14:59:06 ******/
ALTER TABLE [dbo].[cmsContent_Type_Mapping]  WITH CHECK ADD  CONSTRAINT [FK_Content_Type_Mapping_webpages_Roles] FOREIGN KEY([fkEditorsRole])
REFERENCES [dbo].[webpages_Roles] ([RoleId])
GO
ALTER TABLE [dbo].[cmsContent_Type_Mapping] CHECK CONSTRAINT [FK_Content_Type_Mapping_webpages_Roles]
GO
/****** Object:  ForeignKey [FK_SiteSetup_Master_Template]    Script Date: 02/18/2013 14:59:06 ******/
ALTER TABLE [dbo].[cmsSiteSetup]  WITH CHECK ADD  CONSTRAINT [FK_SiteSetup_Master_Template] FOREIGN KEY([fkMaster_Template])
REFERENCES [dbo].[Master_Template] ([pkMasterID])
GO
ALTER TABLE [dbo].[cmsSiteSetup] CHECK CONSTRAINT [FK_SiteSetup_Master_Template]
GO
/****** Object:  ForeignKey [FK_SiteSetup_Master_Template1]    Script Date: 02/18/2013 14:59:06 ******/
ALTER TABLE [dbo].[cmsSiteSetup]  WITH CHECK ADD  CONSTRAINT [FK_SiteSetup_Master_Template1] FOREIGN KEY([fkMaster_Template])
REFERENCES [dbo].[Master_Template] ([pkMasterID])
GO
ALTER TABLE [dbo].[cmsSiteSetup] CHECK CONSTRAINT [FK_SiteSetup_Master_Template1]
GO
/****** Object:  ForeignKey [fk_RoleId]    Script Date: 02/18/2013 14:59:06 ******/
ALTER TABLE [dbo].[webpages_UsersInRoles]  WITH CHECK ADD  CONSTRAINT [fk_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[webpages_Roles] ([RoleId])
GO
ALTER TABLE [dbo].[webpages_UsersInRoles] CHECK CONSTRAINT [fk_RoleId]
GO
/****** Object:  ForeignKey [fk_UserId]    Script Date: 02/18/2013 14:59:06 ******/
ALTER TABLE [dbo].[webpages_UsersInRoles]  WITH CHECK ADD  CONSTRAINT [fk_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[webpages_UsersInRoles] CHECK CONSTRAINT [fk_UserId]
GO
