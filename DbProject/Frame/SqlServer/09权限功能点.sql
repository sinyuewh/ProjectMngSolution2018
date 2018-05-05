 --权限功能点（取消权限功能点的主键）
IF EXISTS (SELECT * FROM sysobjects WHERE type = 'U' AND name = 'JAuthorityDetail')
	BEGIN
		DROP  Table JAuthorityDetail
	END
GO

CREATE TABLE JAuthorityDetail
(
	 num                  int                  null,
	 AuthorityGroup		  varchar(50)		  ,
     AuthorityID          varchar(50)          not null ,
     AuthorityUnitID      varchar(50)          not null ,
     Remark               varchar(50)          not null,
     AuthorityIDValue     int        
)
GO