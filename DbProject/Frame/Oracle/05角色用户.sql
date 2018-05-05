CREATE TABLE JRoleUsers
(
   Num                   INTEGER,
   AuthorityGroup		 varchar(50)		  ,
   ID                    varchar(50)    default(sys_guid())     not null,
   RoleID                VARCHAR(50)         not null,
   UserID                VARCHAR(50)         not null,
   UserName				 varchar(50),
   Kind                  VARCHAR(1)          not null,
   constraint PK_JROLEUSERS primary key (ID),
   constraint UK_ROLEID_USERID unique(RoleID,UserID)
)
