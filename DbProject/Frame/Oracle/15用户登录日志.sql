
CREATE TABLE JUserLoginLog
(
   ID                   varchar(50)  default(sys_guid())  not null,
   AuthorityGroup		varchar(50)		  ,
   CreateTime           date             null,
   UserID               varchar(50)          null,
   UserName				varchar(50)			 null,
   Remark				varchar(500)         null,
  
   constraint PK_JUserLoginLog primary key (ID)
)
