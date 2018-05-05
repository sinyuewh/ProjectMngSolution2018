--字符串资源
IF EXISTS (SELECT * FROM sysobjects WHERE type = 'U' AND name = 'JStrInfo')
	BEGIN
		DROP  Table JStrInfo
	END
GO

CREATE TABLE JStrInfo
(
   num                  int                  null,
   AuthorityGroup		varchar(50)		  ,
   strID                varchar(50)          not null,
   strText              text                 null,
   strText1             text                 null,
   author               varchar(50)          null,
   createtime           datetime             null,
   modelid              varchar(50)          null,
   kind                 VARCHAR(10),
   remark               varchar(200)         null,
   constraint PK_JStrInfo primary key (StrID)
)
GO
