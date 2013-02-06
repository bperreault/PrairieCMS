USE [PrairieCMS]
GO
/****** Object:  Table [dbo].[cmsLevel_Mapping]    Script Date: 02/06/2013 06:41:45 ******/
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
/****** Object:  Table [dbo].[webpages_Roles]    Script Date: 02/06/2013 06:41:45 ******/
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
/****** Object:  Table [dbo].[webpages_OAuthMembership]    Script Date: 02/06/2013 06:41:45 ******/
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
/****** Object:  Table [dbo].[webpages_Membership]    Script Date: 02/06/2013 06:41:45 ******/
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
/****** Object:  Table [dbo].[Users]    Script Date: 02/06/2013 06:41:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[Username] [nvarchar](56) NOT NULL,
	[Firstname] [nvarchar](50) NULL,
	[Lastname] [nvarchar](50) NULL,
	[company] [int] NULL,
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
/****** Object:  Table [dbo].[Master_Template]    Script Date: 02/06/2013 06:41:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Master_Template](
	[pkMasterID] [int] IDENTITY(1,1) NOT NULL,
	[themeName] [nvarchar](150) NOT NULL,
	[html] [text] NULL,
	[fkBelongsTo] [int] NOT NULL,
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
/****** Object:  Table [dbo].[Content_Template]    Script Date: 02/06/2013 06:41:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Content_Template](
	[pkContentID] [int] IDENTITY(1,1) NOT NULL,
	[contentName] [nvarchar](150) NOT NULL,
	[html] [text] NULL,
	[belongsTo] [int] NOT NULL,
	[createdOn] [datetime] NOT NULL,
	[createdBy] [nvarchar](50) NOT NULL,
	[modifiedOn] [datetime] NOT NULL,
	[modifiedBy] [nvarchar](50) NOT NULL,
	[markDown] [text] NULL,
 CONSTRAINT [PK_CMRC_Content] PRIMARY KEY CLUSTERED 
(
	[pkContentID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[cmsSiteSetup]    Script Date: 02/06/2013 06:41:45 ******/
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
/****** Object:  Table [dbo].[cmsContent_Type]    Script Date: 02/06/2013 06:41:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsContent_Type](
	[pkContentTypeId] [int] IDENTITY(1,1) NOT NULL,
	[contentName] [nvarchar](100) NOT NULL,
	[fkLevelMappingId] [int] NULL,
	[contentTemplate] [nvarchar](500) NULL,
	[companyid] [int] NULL,
 CONSTRAINT [PK_Content_Type] PRIMARY KEY CLUSTERED 
(
	[pkContentTypeId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[cms_Page_Map]    Script Date: 02/06/2013 06:41:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cms_Page_Map](
	[pkMapID] [int] IDENTITY(1,1) NOT NULL,
	[pageName] [nvarchar](50) NOT NULL,
	[fkMasterThemeID] [int] NOT NULL,
	[fkEditorRoleID] [int] NOT NULL,
	[fkBelongsTo] [int] NOT NULL,
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
/****** Object:  Table [dbo].[webpages_UsersInRoles]    Script Date: 02/06/2013 06:41:45 ******/
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
/****** Object:  Table [dbo].[cmsContent_Type_Mapping]    Script Date: 02/06/2013 06:41:45 ******/
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
	[insertionPoint] [nvarchar](50) NULL,
	[dateCreated] [datetime] NOT NULL,
	[createdBy] [nvarchar](50) NOT NULL,
	[dateModified] [datetime] NOT NULL,
	[modifiedBy] [nvarchar](50) NOT NULL,
	[companyid] [int] NULL,
 CONSTRAINT [PK_Content_Type_Mapping] PRIMARY KEY CLUSTERED 
(
	[pkBcId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'page, hero,ad,notice -fk into ContentType table' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'cmsContent_Type_Mapping', @level2type=N'COLUMN',@level2name=N'fkContentType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Partial page content, DOM where the content is inserted' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'cmsContent_Type_Mapping', @level2type=N'COLUMN',@level2name=N'insertionPoint'
GO
/****** Object:  Default [DF__webpages___IsCon__46E78A0C]    Script Date: 02/06/2013 06:41:45 ******/
ALTER TABLE [dbo].[webpages_Membership] ADD  DEFAULT ((0)) FOR [IsConfirmed]
GO
/****** Object:  Default [DF__webpages___Passw__47DBAE45]    Script Date: 02/06/2013 06:41:45 ******/
ALTER TABLE [dbo].[webpages_Membership] ADD  DEFAULT ((0)) FOR [PasswordFailuresSinceLastSuccess]
GO
/****** Object:  ForeignKey [FK_cms_Page_Map_Master_Template]    Script Date: 02/06/2013 06:41:45 ******/
ALTER TABLE [dbo].[cms_Page_Map]  WITH CHECK ADD  CONSTRAINT [FK_cms_Page_Map_Master_Template] FOREIGN KEY([fkMasterThemeID])
REFERENCES [dbo].[Master_Template] ([pkMasterID])
GO
ALTER TABLE [dbo].[cms_Page_Map] CHECK CONSTRAINT [FK_cms_Page_Map_Master_Template]
GO
/****** Object:  ForeignKey [FK_cms_Page_Map_webpages_Roles]    Script Date: 02/06/2013 06:41:45 ******/
ALTER TABLE [dbo].[cms_Page_Map]  WITH CHECK ADD  CONSTRAINT [FK_cms_Page_Map_webpages_Roles] FOREIGN KEY([fkEditorRoleID])
REFERENCES [dbo].[webpages_Roles] ([RoleId])
GO
ALTER TABLE [dbo].[cms_Page_Map] CHECK CONSTRAINT [FK_cms_Page_Map_webpages_Roles]
GO
/****** Object:  ForeignKey [FK_Content_Type_Level_Mapping]    Script Date: 02/06/2013 06:41:45 ******/
ALTER TABLE [dbo].[cmsContent_Type]  WITH CHECK ADD  CONSTRAINT [FK_Content_Type_Level_Mapping] FOREIGN KEY([fkLevelMappingId])
REFERENCES [dbo].[cmsLevel_Mapping] ([pkLevelMappingId])
GO
ALTER TABLE [dbo].[cmsContent_Type] CHECK CONSTRAINT [FK_Content_Type_Level_Mapping]
GO
/****** Object:  ForeignKey [FK_cmsContent_Type_Mapping_cms_Page_Map]    Script Date: 02/06/2013 06:41:45 ******/
ALTER TABLE [dbo].[cmsContent_Type_Mapping]  WITH CHECK ADD  CONSTRAINT [FK_cmsContent_Type_Mapping_cms_Page_Map] FOREIGN KEY([fkParent])
REFERENCES [dbo].[cms_Page_Map] ([pkMapID])
GO
ALTER TABLE [dbo].[cmsContent_Type_Mapping] CHECK CONSTRAINT [FK_cmsContent_Type_Mapping_cms_Page_Map]
GO
/****** Object:  ForeignKey [FK_Content_Type_Mapping_Content_Template]    Script Date: 02/06/2013 06:41:45 ******/
ALTER TABLE [dbo].[cmsContent_Type_Mapping]  WITH CHECK ADD  CONSTRAINT [FK_Content_Type_Mapping_Content_Template] FOREIGN KEY([fkContent])
REFERENCES [dbo].[Content_Template] ([pkContentID])
GO
ALTER TABLE [dbo].[cmsContent_Type_Mapping] CHECK CONSTRAINT [FK_Content_Type_Mapping_Content_Template]
GO
/****** Object:  ForeignKey [FK_Content_Type_Mapping_Content_Type]    Script Date: 02/06/2013 06:41:45 ******/
ALTER TABLE [dbo].[cmsContent_Type_Mapping]  WITH CHECK ADD  CONSTRAINT [FK_Content_Type_Mapping_Content_Type] FOREIGN KEY([fkContentType])
REFERENCES [dbo].[cmsContent_Type] ([pkContentTypeId])
GO
ALTER TABLE [dbo].[cmsContent_Type_Mapping] CHECK CONSTRAINT [FK_Content_Type_Mapping_Content_Type]
GO
/****** Object:  ForeignKey [FK_Content_Type_Mapping_webpages_Roles]    Script Date: 02/06/2013 06:41:45 ******/
ALTER TABLE [dbo].[cmsContent_Type_Mapping]  WITH CHECK ADD  CONSTRAINT [FK_Content_Type_Mapping_webpages_Roles] FOREIGN KEY([fkEditorsRole])
REFERENCES [dbo].[webpages_Roles] ([RoleId])
GO
ALTER TABLE [dbo].[cmsContent_Type_Mapping] CHECK CONSTRAINT [FK_Content_Type_Mapping_webpages_Roles]
GO
/****** Object:  ForeignKey [FK_SiteSetup_Master_Template]    Script Date: 02/06/2013 06:41:45 ******/
ALTER TABLE [dbo].[cmsSiteSetup]  WITH CHECK ADD  CONSTRAINT [FK_SiteSetup_Master_Template] FOREIGN KEY([fkMaster_Template])
REFERENCES [dbo].[Master_Template] ([pkMasterID])
GO
ALTER TABLE [dbo].[cmsSiteSetup] CHECK CONSTRAINT [FK_SiteSetup_Master_Template]
GO
/****** Object:  ForeignKey [FK_SiteSetup_Master_Template1]    Script Date: 02/06/2013 06:41:45 ******/
ALTER TABLE [dbo].[cmsSiteSetup]  WITH CHECK ADD  CONSTRAINT [FK_SiteSetup_Master_Template1] FOREIGN KEY([fkMaster_Template])
REFERENCES [dbo].[Master_Template] ([pkMasterID])
GO
ALTER TABLE [dbo].[cmsSiteSetup] CHECK CONSTRAINT [FK_SiteSetup_Master_Template1]
GO
/****** Object:  ForeignKey [fk_RoleId]    Script Date: 02/06/2013 06:41:45 ******/
ALTER TABLE [dbo].[webpages_UsersInRoles]  WITH CHECK ADD  CONSTRAINT [fk_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[webpages_Roles] ([RoleId])
GO
ALTER TABLE [dbo].[webpages_UsersInRoles] CHECK CONSTRAINT [fk_RoleId]
GO
/****** Object:  ForeignKey [fk_UserId]    Script Date: 02/06/2013 06:41:45 ******/
ALTER TABLE [dbo].[webpages_UsersInRoles]  WITH CHECK ADD  CONSTRAINT [fk_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[webpages_UsersInRoles] CHECK CONSTRAINT [fk_UserId]
GO
USE [MessagingSystem]
GO
/****** Object:  Table [dbo].[Log]    Script Date: 02/06/2013 06:45:17 ******/
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
