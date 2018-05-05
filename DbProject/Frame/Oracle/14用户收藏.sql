
CREATE TABLE JUserUrl
(
   num                  int							null,
   InfoID				varchar(50)			default(sys_guid())		not null,
   UserID				varchar(50)				not null,
   UrlText				varchar(500)				not null,
   urlValue				varchar(500)				not null,
   AddTime				date					not null,
   constraint PK_JUserUrl primary key (InfoID)
)
