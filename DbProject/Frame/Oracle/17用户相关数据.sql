 
CREATE TABLE JUserData
(
   ID                   varchar(50) default(sys_guid())  not null,						--ID
   CreateTime           date             null,					--创建时间
   UserID               varchar(50)          null,					--用户ID
   DataKey				varchar(50)			 null,					--数据条目
   DataValue			varchar(4000)		 null,					--数据值
   constraint PK_JUserData primary key (ID)
)
GO