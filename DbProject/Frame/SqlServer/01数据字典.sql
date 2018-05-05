-- 数据字典
IF EXISTS (SELECT * FROM sysobjects WHERE type = 'U' AND name = 'JItem')
	BEGIN
		DROP  Table JItem
	END
GO

CREATE TABLE JItem
(
   num                INTEGER,
   AuthorityGroup	  varchar(50)		  ,
   itemname           VARCHAR(50)     not null,
   author             VARCHAR(50),
   createtime         datetime,
   minvalue           INTEGER,
   maxvalue           INTEGER,
   intervalue         INTEGER,
   kind               VARCHAR(10),
   modelID            VARCHAR(50),
   remark             VARCHAR(200),
   constraint PK_JITEM primary key (itemname)
)
GO