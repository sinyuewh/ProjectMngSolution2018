 --权限角色
IF EXISTS (SELECT * FROM sysobjects WHERE type = 'U' AND name = 'JAuthorityRoles')
	BEGIN
		DROP  Table JAuthorityRoles
	END
GO

CREATE TABLE JAuthorityRoles
(
	  num                  int                  null,
	  AuthorityGroup	   varchar(50)		  ,
	  ID                   varchar(50)    default(newid())      not null,
	  AuthorityUnitID      varchar(50)          not null,
	  RoleID               varchar(50)          not null,
	  constraint PK_JAuthorityRoles primary key (ID)
)
GO
