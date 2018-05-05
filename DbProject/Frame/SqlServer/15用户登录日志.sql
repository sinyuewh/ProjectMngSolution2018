   --用户登录日志
 IF EXISTS (SELECT * FROM sysobjects WHERE type = 'U' AND name = 'JUserLoginLog')
	BEGIN
		DROP  Table JUserLoginLog
	END
GO

CREATE TABLE JUserLoginLog
(
   ID                   varchar(50)  default(newid())  not null,
   AuthorityGroup		varchar(50)		  ,
   CreateTime           datetime             null,
   UserID               varchar(50)          null,
   UserName				varchar(50)			 null,
   Remark				varchar(500)         null,
  
   constraint PK_JUserLoginLog primary key (ID)
)
GO