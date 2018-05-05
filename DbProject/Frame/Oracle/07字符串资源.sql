CREATE TABLE JStrInfo
(
   num                  int                  null,
   AuthorityGroup		varchar(50)		  ,
   strID                varchar(50)          not null,
   strText              clob                 null,
   strText1             clob                 null,
   author               varchar(50)          null,
   createtime           date                 null,
   modelid              varchar(50)          null,
   kind                 VARCHAR(10),
   remark               varchar(200)         null,
   constraint PK_JStrInfo primary key (StrID)
)
