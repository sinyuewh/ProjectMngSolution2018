--测试单
/*
   TaskGuidID varchar(50) ,		--派工单ID	
   ProjectGuidID varchar(50),   --项目ID			 
   begDate	date not null,		--开始日期				
   endDate	date not null,		--结束日期				
   
   DebugTitle  nvarchar(200) not null,				
   DebugGrade  nvarchar(1) not null,					
   
   content	text,									
   contentText	text,								
   
   Manager varchar(50) not null,	
   ExecuteMan varchar(50) not null,			
   					  
   Status varchar(1) ,				
   
   GuidID varchar(50)  not null ,   
   AddTime Date,				
   AddUser varchar(50),								
   
   LastTime Datetime,								
   ModifyUser varchar(50),							
   ManageID varchar(50),		
   SubmitCount int,     --往返次数						
          
   constraint PK_Tb_Debug primary key (GuidID)
*/


 CREATE TABLE Tb_Debug
(				
   TaskGuidID varchar(50) ,		
   ProjectGuidID varchar(50) ,				
   
   begDate	date not null,						
   endDate	date not null,						
   
   DebugTitle  nvarchar(200) not null,				
   DebugGrade  nvarchar(1) not null,					
   
   content	text,									
   contentText	text,								
   
   Manager varchar(50) not null,	
   ExecuteMan varchar(50) not null,			
   					  
   Status varchar(1) ,				
   
   GuidID varchar(50)  not null ,   
   AddTime Date,				
   AddUser varchar(50),								
   
   LastTime Datetime,								
   ModifyUser varchar(50),							
   ManageID varchar(50),		
   SubmitCount int,						
          
   constraint PK_Tb_Debug primary key (GuidID)
)



/*
   
   drop table Tb_Debug
   
   问题类型按照A、B、C、D、E顺序排列 
   A. 致命性：数据被破坏、数据丢失、系统崩溃、系统无法运行。 
   B. 重大性：处理结果不正确、流程不对、性能不能满足要求 
      重大性以上bug用白底红字方式标识出来。 
   C. 次要性：不会影响整个系统的运行性能， 
   D. 一般性：操作不方便，界面布局不合理，难以理解 
   E. 建议性：界面重构、描述更改、流程改进。
   
   
   
*/

create view Tb_DebugView as 
SELECT Tb_Debug.*, Tb_Project.prjNum, Tb_Project.prjName, 
Tb_Project.Status AS projectStatus, Tb_Project.clientName, Tb_Project.content AS projectContent, 
Tb_Project.contenttext AS projectContentText, JUser.UserName AS ManagerName, JUser_1.UserName AS ExecuteManName
FROM ((Tb_Debug LEFT JOIN Tb_Project ON Tb_Debug.ProjectGuidID = Tb_Project.GuidID) LEFT JOIN JUser ON Tb_Debug.Manager = JUser.UserID) LEFT JOIN JUser AS JUser_1 ON Tb_Debug.ExecuteMan = JUser_1.UserID

