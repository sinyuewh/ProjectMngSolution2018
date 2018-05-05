 CREATE TABLE JUser
(
   num					  int,
   AuthorityGroup		  varchar(50)		  ,
   UserID                 varchar(50)          not null,
   [PassWord]               varchar(50)          not null,
   UserName               varchar(50)          ,
   LastLogin			  date,
   status				  int,
   LoginCount			  int,
   AuthorityID			  varchar(50),
   constraint PK_JUser primary key (UserID)          
)

