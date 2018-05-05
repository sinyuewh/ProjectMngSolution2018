 
CREATE TABLE JUserData
(
   ID                   guid default GenGUID()  not null,						
   CreateTime           date             null,					
   UserID               varchar(50)          null,					
   DataKey				varchar(50)			 null,					
   DataValue			text		 null,					
   constraint PK_JUserData primary key (ID)
)
GO