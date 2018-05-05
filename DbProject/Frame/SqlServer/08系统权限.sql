--系统权限
IF EXISTS (SELECT * FROM sysobjects WHERE type = 'U' AND name = 'JAuthority')
	BEGIN
		DROP  Table JAuthority
	END
GO

CREATE TABLE JAuthority
(
   num                  int                  null,
   AuthorityGroup		varchar(50)		  ,
   AuthorityID          varchar(50)          not null,
   AuthorityName        varchar(50)          not null,
   Author               varchar(50)          null,
   CreateTime           datetime             null,
   ModelID              varchar(50)          null,
   Remark               varchar(200)         null,
   RelPages				varchar(4000),
   AuthUnitNum			varchar(500),
   AuthUnitText			varchar(500),
   constraint PK_JAuthority primary key (AuthorityID)
)
GO

