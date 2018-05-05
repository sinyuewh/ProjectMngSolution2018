CREATE TABLE JSqlInfo
(
   num                  int                  null,
   AuthorityGroup		varchar(50)		  ,
   SqlID                varchar(10)          not null ,
   SqlText              text				null,
   author               varchar(50)          null,
   createtime           date                  null,
   modelID              varchar(50)          null,
   remark               varchar(200)         null,
   constraint PK_JSqlInfo primary key (SqlID)
)

