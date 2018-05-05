
CREATE TABLE JUserUrl
(
   num                  int							null,
   InfoID				guid default GenGUID()		not null,
   UserID				varchar(50)				not null,
   UrlText				text					not null,
   urlValue				text					not null,
   AddTime				date					not null,
   constraint PK_JUserUrl primary key (InfoID)
)
