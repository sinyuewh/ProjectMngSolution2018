 --组织结构
IF EXISTS (SELECT * FROM sysobjects WHERE type = 'U' AND name = 'JOrg')
	BEGIN
		DROP  Table JOrg
	END
GO

CREATE TABLE JOrg
(
   num                  int                  null,
   AuthorityGroup		varchar(50)		  ,
   OrgID                varchar(50)          not null,
   OrgName              varchar(50)          not null,
   parent               varchar(50)          null,
   status				int,
   constraint PK_JOrg primary key (OrgID)
)
GO