--BigKind 0 --计划派工 1--临时派工

 CREATE TABLE Tb_Task
(
   BigKind   varchar(2),							
   ProjectGuidID varchar(50) ,						
   
   begDate	date not null,						
   endDate	date not null,						
   
   TaskTitle  nvarchar(200) not null,				
   TaskGrade  nvarchar(1) not null,					
   
   content	text,									
   contentText	text,								
   
   Manager varchar(50) not null,	
   ExecuteMan varchar(50) not null,		
   
   Workload double,							  
   Status varchar(1) ,			
   CompleteRate double,				
   
   GuidID varchar(50)  not null ,   
   AddTime Date,				
   AddUser varchar(50),								
   
   LastTime Datetime,								
   ModifyUser varchar(50),							
   ManageID varchar(50),							
   PlanBillID	varchar(50),	
          
   constraint PK_Tb_Task primary key (GuidID)
)



/*
   
   drop table Tb_Task
   
   问题类型按照A、B、C、D、E顺序排列 
   A. 致命性：数据被破坏、数据丢失、系统崩溃、系统无法运行。 
   B. 重大性：处理结果不正确、流程不对、性能不能满足要求 
      重大性以上bug用白底红字方式标识出来。 
   C. 次要性：不会影响整个系统的运行性能， 
   D. 一般性：操作不方便，界面布局不合理，难以理解 
   E. 建议性：界面重构、描述更改、流程改进。
   
   
   
*/

create view Tb_TaskView as 
SELECT Tb_Task.*, Tb_Project.prjNum, Tb_Project.prjName, 
Tb_Project.Status AS projectStatus, Tb_Project.clientName, Tb_Project.content AS projectContent, 
Tb_Project.contenttext AS projectContentText, JUser.UserName AS ManagerName, JUser_1.UserName AS ExecuteManName
FROM ((Tb_Task LEFT JOIN Tb_Project ON Tb_Task.ProjectGuidID = Tb_Project.GuidID) LEFT JOIN JUser ON Tb_Task.Manager = JUser.UserID) LEFT JOIN JUser AS JUser_1 ON Tb_Task.ExecuteMan = JUser_1.UserID