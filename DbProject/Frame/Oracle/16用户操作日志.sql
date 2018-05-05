 
CREATE TABLE JUserActionLog
(
   ID                   varchar(50) default(sys_guid())  not null,						--ID
   AuthorityGroup		varchar(50)		  ,
   CreateTime           date             null,					--创建时间
   UserID               varchar(50)          null,					--用户ID
   UserName				varchar(50)			 null,					--用户姓名
   ActionName			varchar(50)			 null,					--操作名称（如新增、修改、删除、打印、审核等）
   MainTable			varchar(200)		 null,					--相关的主表
   Remark				varchar(500)         null,					--操作描述
   ActionInfo           varchar(4000)        null,					--操作详细内容
   constraint PK_JUserActionLog primary key (ID)
)
GO