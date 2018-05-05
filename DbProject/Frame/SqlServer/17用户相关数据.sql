     --用户相关数据
 IF EXISTS (SELECT * FROM sysobjects WHERE type = 'U' AND name = 'JUserData')
	BEGIN
		DROP  Table JUserData
	END
GO

CREATE TABLE JUserData
(
   ID                   varchar(50) default(newid())  not null,						--ID
   CreateTime           datetime             null,					--创建时间
   UserID               varchar(50)          null,					--用户ID
   DataKey				varchar(50)			 null,					--数据条目
   DataValue			varchar(4000)		 null,					--数据值
   constraint PK_JUserData primary key (ID)
)
GO