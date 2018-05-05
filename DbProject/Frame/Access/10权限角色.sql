CREATE TABLE JAuthorityRoles
(
	  num                  int                  null,
	  AuthorityGroup	   varchar(50)		  ,
	  ID                   guid default GenGUID()      not null,
	  AuthorityUnitID      varchar(50)          not null,
	  RoleID               varchar(50)          not null,
	  constraint PK_JAuthorityRoles primary key (ID)
)
