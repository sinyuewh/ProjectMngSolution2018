-- 系统角色
IF EXISTS (SELECT * FROM sysobjects WHERE type = 'U' AND name = 'JRole')
	BEGIN
		DROP  Table JRole
	END
GO

CREATE TABLE JRole
(
   num                INTEGER,
   AuthorityGroup	  varchar(50)		  ,
   RoleID             VARCHAR(50)         not null,
   RoleName           VARCHAR(50)         not null,
   kind               VARCHAR(10),
   modelid            VARCHAR(50),
   remark             VARCHAR(200),
   constraint PK_JROLE primary key (RoleID)
)
GO
