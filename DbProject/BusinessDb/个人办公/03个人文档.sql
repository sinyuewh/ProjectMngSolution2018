CREATE TABLE Tb_PersonDoc
( 
   PersonID varchar(50) not null,										
   STitle  varchar(50),								
   									
   FileName	varchar(200) ,							
   PhysicalFile	varchar(200) ,						
   FileDir	varchar(200) ,							
   
   DocKeys varchar(200),							
   Remark varchar(250) ,											 
	
   GuidID varchar(50)  not null ,						     
   constraint PK_Tb_PersonDoc primary key (GuidID)
)

/*
个人文档
*/