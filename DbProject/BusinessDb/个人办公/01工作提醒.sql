 CREATE TABLE Tb_TodayWork
( 
   PersonID varchar(50) not null,	
   begDate	date not null,										
   
   TaskTitle  nvarchar(200) not null,				
   TaskGrade  nvarchar(1) not null,	
   IsFinish nvarchar(1) not null,				
   
   Remark	  nvarchar(250),
   content	text,									
   contentText	text,										
   
   GuidID varchar(50)  not null ,   
   AddTime Date,				
             
   constraint PK_Tb_TodayWork primary key (GuidID)
)

/*
工作提醒
drop table Tb_PersonReminder
*/

/* 工作备忘提醒考核 */
CREATE TABLE Tb_TodayWorkResult
(
   byear	int,							
   bmonth	int,	
   UserName varchar(50),
   
   d1 double,  
   d2 double, 
   d3 double, 	
   						  
   hgrate double
)