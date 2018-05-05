  --用户收藏
 IF EXISTS (SELECT * FROM sysobjects WHERE type = 'U' AND name = 'JUserUrl')
	BEGIN
		DROP  Table JUserUrl
	END
GO

CREATE TABLE JUserUrl
(
   num                  int							null,
   InfoID				varchar(50)			default(newid())		not null,
   UserID				varchar(50)				not null,
   UrlText				varchar(500)				not null,
   urlValue				varchar(500)				not null,
   AddTime				datetime					not null,
   constraint PK_JUserUrl primary key (InfoID)
)
GO