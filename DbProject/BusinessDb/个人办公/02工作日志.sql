  CREATE TABLE Tb_PersonWork
( 
   PersonID varchar(50) not null,	
   begDate	date not null,											
   
   TaskTitle  nvarchar(200) not null,							
   Remark	  nvarchar(250),
   content	text,									
   contentText	text,										
   
   GuidID varchar(50)  not null ,   
   AddTime Date,				
             
   constraint PK_Tb_PersonWork primary key (GuidID)
)

/*
工作日志
*/