CREATE TABLE JAuthorityDetail
(
	 num                  int                  null,
	 AuthorityGroup		  varchar(50)		  ,
     AuthorityID          varchar(50)          not null ,
     AuthorityUnitID      varchar(50)          not null ,
     Remark               varchar(50)          not null,
     AuthorityIDValue     int        
)