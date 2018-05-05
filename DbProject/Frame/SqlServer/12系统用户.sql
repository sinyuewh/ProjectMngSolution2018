 --系统用户
IF EXISTS (SELECT * FROM sysobjects WHERE type = 'U' AND name = 'JUser')
	BEGIN
		DROP  Table JUser
	END
GO

CREATE TABLE JUser
(
   num					  int,
   AuthorityGroup		  varchar(50)		  ,
   UserID                 varchar(50)          not null,
   PassWord               varchar(50)          not null,
   UserName               varchar(50)          ,
   LastLogin			  datetime,
   status				  int,
   LoginCount			  int,
   AuthorityID			  varchar(50),
   constraint PK_JUser primary key (UserID)          
)
GO