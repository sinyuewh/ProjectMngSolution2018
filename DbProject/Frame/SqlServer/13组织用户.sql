 --组织用户
 IF EXISTS (SELECT * FROM sysobjects WHERE type = 'U' AND name = 'JOrgUsers')
	BEGIN
		DROP  Table JOrgUsers
	END
GO

CREATE TABLE JOrgUsers
(
   num                  int                  null,
   AuthorityGroup		varchar(50)		  ,
   OrgID                varchar(50)          not null,
   UserID               varchar(50)          not null,
   constraint PK_JOrgUsers primary key (OrgID,UserID)
)
GO