USE [master]
GO
/****** Object:  Database [PrairieCMS]    Script Date: 02/11/2013 07:44:21 ******/
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
/****** Object:  Table [dbo].[cmsSiteMapItems]    Script Date: 02/11/2013 07:44:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsSiteMapItems](
	[pkSiteMapItemID] [int] IDENTITY(1,1) NOT NULL,
	[SiteMapItemName] [nvarchar](64) NOT NULL,
	[fkSiteMapParentId] [int] NOT NULL,
	[relativeUrl] [nvarchar](200) NULL,
 CONSTRAINT [PK_SiteMap] PRIMARY KEY CLUSTERED 
(
	[pkSiteMapItemID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[cmsLevel_Mapping]    Script Date: 02/11/2013 07:44:23 ******/
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
/****** Object:  Table [dbo].[webpages_Roles]    Script Date: 02/11/2013 07:44:23 ******/
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
/****** Object:  Table [dbo].[webpages_OAuthMembership]    Script Date: 02/11/2013 07:44:23 ******/
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
/****** Object:  Table [dbo].[webpages_Membership]    Script Date: 02/11/2013 07:44:23 ******/
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
/****** Object:  Table [dbo].[Users]    Script Date: 02/11/2013 07:44:23 ******/
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
/****** Object:  Table [dbo].[Master_Template]    Script Date: 02/11/2013 07:44:23 ******/
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
/****** Object:  Table [dbo].[Log]    Script Date: 02/11/2013 07:44:23 ******/
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
/****** Object:  Table [dbo].[Content_Template]    Script Date: 02/11/2013 07:44:23 ******/
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
/****** Object:  Table [dbo].[webpages_UsersInRoles]    Script Date: 02/11/2013 07:44:23 ******/
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
/****** Object:  Table [dbo].[cmsSiteSetup]    Script Date: 02/11/2013 07:44:23 ******/
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
/****** Object:  Table [dbo].[cmsContent_Type]    Script Date: 02/11/2013 07:44:23 ******/
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
SET IDENTITY_INSERT [dbo].[cmsContent_Type] OFF
/****** Object:  Table [dbo].[cms_Page_Map]    Script Date: 02/11/2013 07:44:23 ******/
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
/****** Object:  Table [dbo].[cmsContent_Type_Mapping]    Script Date: 02/11/2013 07:44:23 ******/
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
/****** Object:  Default [DF__webpages___IsCon__239E4DCF]    Script Date: 02/11/2013 07:44:23 ******/
ALTER TABLE [dbo].[webpages_Membership] ADD  DEFAULT ((0)) FOR [IsConfirmed]
GO
/****** Object:  Default [DF__webpages___Passw__24927208]    Script Date: 02/11/2013 07:44:23 ******/
ALTER TABLE [dbo].[webpages_Membership] ADD  DEFAULT ((0)) FOR [PasswordFailuresSinceLastSuccess]
GO
/****** Object:  ForeignKey [fk_RoleId]    Script Date: 02/11/2013 07:44:23 ******/
ALTER TABLE [dbo].[webpages_UsersInRoles]  WITH CHECK ADD  CONSTRAINT [fk_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[webpages_Roles] ([RoleId])
GO
ALTER TABLE [dbo].[webpages_UsersInRoles] CHECK CONSTRAINT [fk_RoleId]
GO
/****** Object:  ForeignKey [fk_UserId]    Script Date: 02/11/2013 07:44:23 ******/
ALTER TABLE [dbo].[webpages_UsersInRoles]  WITH CHECK ADD  CONSTRAINT [fk_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[webpages_UsersInRoles] CHECK CONSTRAINT [fk_UserId]
GO
/****** Object:  ForeignKey [FK_SiteSetup_Master_Template]    Script Date: 02/11/2013 07:44:23 ******/
ALTER TABLE [dbo].[cmsSiteSetup]  WITH CHECK ADD  CONSTRAINT [FK_SiteSetup_Master_Template] FOREIGN KEY([fkMaster_Template])
REFERENCES [dbo].[Master_Template] ([pkMasterID])
GO
ALTER TABLE [dbo].[cmsSiteSetup] CHECK CONSTRAINT [FK_SiteSetup_Master_Template]
GO
/****** Object:  ForeignKey [FK_SiteSetup_Master_Template1]    Script Date: 02/11/2013 07:44:23 ******/
ALTER TABLE [dbo].[cmsSiteSetup]  WITH CHECK ADD  CONSTRAINT [FK_SiteSetup_Master_Template1] FOREIGN KEY([fkMaster_Template])
REFERENCES [dbo].[Master_Template] ([pkMasterID])
GO
ALTER TABLE [dbo].[cmsSiteSetup] CHECK CONSTRAINT [FK_SiteSetup_Master_Template1]
GO
/****** Object:  ForeignKey [FK_Content_Type_Level_Mapping]    Script Date: 02/11/2013 07:44:23 ******/
ALTER TABLE [dbo].[cmsContent_Type]  WITH CHECK ADD  CONSTRAINT [FK_Content_Type_Level_Mapping] FOREIGN KEY([fkLevelMappingId])
REFERENCES [dbo].[cmsLevel_Mapping] ([pkLevelMappingId])
GO
ALTER TABLE [dbo].[cmsContent_Type] CHECK CONSTRAINT [FK_Content_Type_Level_Mapping]
GO
/****** Object:  ForeignKey [FK_cms_Page_Map_Master_Template]    Script Date: 02/11/2013 07:44:23 ******/
ALTER TABLE [dbo].[cms_Page_Map]  WITH CHECK ADD  CONSTRAINT [FK_cms_Page_Map_Master_Template] FOREIGN KEY([fkMasterThemeID])
REFERENCES [dbo].[Master_Template] ([pkMasterID])
GO
ALTER TABLE [dbo].[cms_Page_Map] CHECK CONSTRAINT [FK_cms_Page_Map_Master_Template]
GO
/****** Object:  ForeignKey [FK_cms_Page_Map_webpages_Roles]    Script Date: 02/11/2013 07:44:23 ******/
ALTER TABLE [dbo].[cms_Page_Map]  WITH CHECK ADD  CONSTRAINT [FK_cms_Page_Map_webpages_Roles] FOREIGN KEY([fkEditorRoleID])
REFERENCES [dbo].[webpages_Roles] ([RoleId])
GO
ALTER TABLE [dbo].[cms_Page_Map] CHECK CONSTRAINT [FK_cms_Page_Map_webpages_Roles]
GO
/****** Object:  ForeignKey [FK_cmsContent_Type_Mapping_cms_Page_Map]    Script Date: 02/11/2013 07:44:23 ******/
ALTER TABLE [dbo].[cmsContent_Type_Mapping]  WITH CHECK ADD  CONSTRAINT [FK_cmsContent_Type_Mapping_cms_Page_Map] FOREIGN KEY([fkParent])
REFERENCES [dbo].[cms_Page_Map] ([pkMapID])
GO
ALTER TABLE [dbo].[cmsContent_Type_Mapping] CHECK CONSTRAINT [FK_cmsContent_Type_Mapping_cms_Page_Map]
GO
/****** Object:  ForeignKey [FK_Content_Type_Mapping_Content_Template]    Script Date: 02/11/2013 07:44:23 ******/
ALTER TABLE [dbo].[cmsContent_Type_Mapping]  WITH CHECK ADD  CONSTRAINT [FK_Content_Type_Mapping_Content_Template] FOREIGN KEY([fkContent])
REFERENCES [dbo].[Content_Template] ([pkContentID])
GO
ALTER TABLE [dbo].[cmsContent_Type_Mapping] CHECK CONSTRAINT [FK_Content_Type_Mapping_Content_Template]
GO
/****** Object:  ForeignKey [FK_Content_Type_Mapping_Content_Type]    Script Date: 02/11/2013 07:44:23 ******/
ALTER TABLE [dbo].[cmsContent_Type_Mapping]  WITH CHECK ADD  CONSTRAINT [FK_Content_Type_Mapping_Content_Type] FOREIGN KEY([fkContentType])
REFERENCES [dbo].[cmsContent_Type] ([pkContentTypeId])
GO
ALTER TABLE [dbo].[cmsContent_Type_Mapping] CHECK CONSTRAINT [FK_Content_Type_Mapping_Content_Type]
GO
/****** Object:  ForeignKey [FK_Content_Type_Mapping_webpages_Roles]    Script Date: 02/11/2013 07:44:23 ******/
ALTER TABLE [dbo].[cmsContent_Type_Mapping]  WITH CHECK ADD  CONSTRAINT [FK_Content_Type_Mapping_webpages_Roles] FOREIGN KEY([fkEditorsRole])
REFERENCES [dbo].[webpages_Roles] ([RoleId])
GO
ALTER TABLE [dbo].[cmsContent_Type_Mapping] CHECK CONSTRAINT [FK_Content_Type_Mapping_webpages_Roles]
GO
