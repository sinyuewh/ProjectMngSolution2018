--SQL语句
IF EXISTS (SELECT * FROM sysobjects WHERE type = 'U' AND name = 'JSqlInfo')
	BEGIN
		DROP  Table JSqlInfo
	END
GO

CREATE TABLE JSqlInfo
(
   num                  int                  null,
   AuthorityGroup		varchar(50)		  ,
   SqlID                varchar(10)          not null ,
   SqlText              varchar(2000)        null,
   author               varchar(50)          null,
   createtime           datetime             null,
   modelID              varchar(50)          null,
   remark               varchar(200)         null,
   constraint PK_JSqlInfo primary key (SqlID)
)
GO

