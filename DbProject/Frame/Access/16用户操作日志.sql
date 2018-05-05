CREATE TABLE JUserActionLog
(
   ID                 guid default GenGUID()   not null,
   AuthorityGroup	  varchar(50)		  ,
   CreateTime           date             null,
   UserID               varchar(50)          null,
   UserName				varchar(50)			 null,
   ActionName			varchar(50)			 null,	
   MainTable			varchar(200)		 null,	
   Remark				text        null,
   ActionInfo           text        null,
   constraint PK_JUserActionLog primary key (ID)
)
GO