CREATE TABLE JItemDetail
(
   ID                 varchar(50) default(sys_guid())  not null,
   AuthorityGroup	  varchar(50)		  ,
   num                INTEGER,
   itemname           VARCHAR(50)         not null,
   itemtext           VARCHAR(50)         not null,
   itemValue          VARCHAR(50)         not null,
   constraint PK_JITEMDETAIL primary key (ID),
   constraint UK_itemname_itemtext unique(itemname,itemtext)
)
GO
