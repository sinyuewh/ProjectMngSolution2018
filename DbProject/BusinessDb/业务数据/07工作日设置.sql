CREATE TABLE Tb_WorkDay
(
   byear	int,							
   bmonth	int,									
   
   Workload double,							  
   Remark varchar(200),				
   
   GuidID varchar(50)  not null ,   
   AddTime Date,				
   AddUser varchar(50),								
   
   LastTime Date,								
   ModifyUser varchar(50),							
   ManageID varchar(50),							
          
   constraint PK_Tb_WorkDay primary key (GuidID)
)

/*
  drop table Tb_WorkDay
  工作日设置
*/