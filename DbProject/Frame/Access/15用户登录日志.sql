
CREATE TABLE JUserLoginLog
(
   ID                 guid default GenGUID()   not null,
   AuthorityGroup		varchar(50)		  ,
   CreateTime           date             null,
   UserID               varchar(50)          null,
   UserName				varchar(50)			 null,
   Remark				text         null,
   constraint PK_JUserLoginLog primary key (ID)
)


