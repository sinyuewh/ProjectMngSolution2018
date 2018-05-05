CREATE TABLE JAuthority
(
   num                  int                  null,
   AuthorityGroup		varchar(50)		  ,
   AuthorityID          varchar(50)          not null,
   AuthorityName        varchar(50)          not null,
   Author               varchar(50)          null,
   CreateTime           date                 null,
   ModelID              varchar(50)          null,
   Remark               varchar(200)         null,
   RelPages				text,
   AuthUnitNum			text,
   AuthUnitText			text,
   constraint PK_JAuthority primary key (AuthorityID)
)

