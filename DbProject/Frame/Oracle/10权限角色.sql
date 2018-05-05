CREATE TABLE JAuthorityRoles
(
	  num                  int                  null,
	  AuthorityGroup	   varchar(50)		  ,
	  ID                   varchar(50)    default(sys_guid())      not null,
	  AuthorityUnitID      varchar(50)          not null,
	  RoleID               varchar(50)          not null,
	  constraint PK_JAuthorityRoles primary key (ID)
)
