CREATE TABLE JModel
( 
   num                  int                  null,
   AuthorityGroup		varchar(50)		  ,
   modelGroup           varchar(50)          ,
   modelID              varchar(50)          not null,
   modelName            varchar(50)          not null,
   modelText            varchar(50)          null,
   modelICo             varchar(200)         null,
   modelUrl             varchar(200)         null,
   menuID               int                  null,
   AuthorityUnitID      varchar(50)          null,
   remark               varchar(200)         null,
   constraint PK_JMODEL primary key (modelID),
   constraint AK_UK_MODELNAME_JMODEL unique (modelName)
)
GO
