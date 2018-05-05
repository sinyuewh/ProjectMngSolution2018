
CREATE TABLE JOrgUsers
(
   num                  int                  null,
   AuthorityGroup		varchar(50)		  ,
   OrgID                varchar(50)          not null,
   UserID               varchar(50)          not null,
   constraint PK_JOrgUsers primary key (OrgID,UserID)
)