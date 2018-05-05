CREATE TABLE JItem
(
   num                INTEGER,
   AuthorityGroup	  varchar(50)		  ,
   itemname           VARCHAR(50)     not null,
   author             VARCHAR(50),
   createtime         date,
   minvalue           INTEGER,
   maxvalue           INTEGER,
   intervalue         INTEGER,
   kind               VARCHAR(10),
   modelID            VARCHAR(50),
   remark             VARCHAR(200),
   constraint PK_JITEM primary key (itemname)
)
GO