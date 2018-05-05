 CREATE TABLE Tb_Project
(
   prjNum	varchar(50) not null,					
   prjName	varchar(200) not null,					
   begDate	date,									
   endDate	date,									
   prjMoney	double,			
   Status   int,						

   clientName varchar(200),							
   prjKeys varchar(200),							
   
   content	text,									
   contenttext	text,								
  
   GuidID varchar(50)  not null ,
   AddTime Date ,									
   AddUser varchar(50),								
   
   LastTime Date,									
   ModifyUser varchar(50),							
   ManageID varchar(50),		
   Weight int,		
   FinishDate Date,
   
   constraint PK_Tb_Project primary key (prjNum),
   constraint UK_Tb_Project unique(GuidID)
)

/*
   drop table Tb_Project
   项目资料
   prjNum	varchar(50) not null,					--项目编号
   prjName	varchar(200) not null,					--项目名称
   begDate	datetime,								--合同签订日期
   endDate	datetime,								--计划结束日期
   
   prjMoney	numeric(18,2),							--项目金额
   Status   int,									--项目状态
   
   clientName varchar(200),							--客户名称
   prjKeys varchar(200),							--项目关键字（检索用）
   
   content	text,									--项目介绍
   contenttext	text,									--项目介绍纯文本
  
   GuidID varchar(50) default(newid()) not null ,
   AddTime Datetime default(getdate()),				--创建时间
   AddUser varchar(50),								--创建用户
   
   LastTime Datetime,								--修改时间
   ModifyUser varchar(50),							--修改用户
   ManageID varchar(50),							--管理ID
*/

--项目文档视图
drop view Tb_ProjectDocView
create View Tb_ProjectDocView
as 
select JAttachment.*,Tb_Project.prjNum,Tb_Project.prjName,Tb_Project.ManageID from 
JAttachment inner join Tb_Project on JAttachment.parentGuid=Tb_Project.Guidid

--项目日志视图
create view Tb_ProjectLogView
as 
select Tb_ReplyView.*, Tb_Project.prjNum,Tb_Project.prjName from 
Tb_ReplyView inner join Tb_Project on Tb_ReplyView.parentGuid=Tb_Project.Guidid


--项目计划
--PlanKind  总体计划 调研计划  开发计划 施工计划 培训计划 其他
 CREATE TABLE Tb_Plan
(					
   parentGuid varchar(50) not null,	
   PlanKind varchar(50) not null,
   begDate	date,									
   endDate	date,									
   Status   int,												
   content	varchar(250) not null,															
  
   GuidID varchar(50)  not null ,
   AddTime Date ,									
   AddUser varchar(50),								
   
   LastTime Date,									
   ModifyUser varchar(50),							
   ManageID varchar(50),					
   
   constraint PK_Tb_Plan primary key (GuidID)
)

--项目计划明细
--Bkind  需求、设计、编码、测试、上线
--drop table Tb_PlanBill
 CREATE TABLE Tb_PlanBill
(					
   parentGuid varchar(50) not null,	
   num int not null,
   BKind varchar(250) not null,
   workcontent	varchar(250) not null,	
   
   begDate	date,									
   endDate	date,																				

   CheckContent varchar(250) not null,
   zeRen varchar(250) not null,
   IsKeyPoint int not null,
   IsComplete int not null,
   IsWork int not null,
   														
   GuidID varchar(50)  not null ,
   constraint PK_Tb_PlanBill primary key (GuidID)
)

--项目计划视图
-- drop view 
create view Tb_PlanView
as 
select Tb_Plan.*, Tb_Project.prjNum,Tb_Project.prjName from 
Tb_Plan inner join Tb_Project on Tb_Plan.parentGuid=Tb_Project.Guidid


--项目计划明细视图
-- drop view Tb_PlanBillView
create view Tb_PlanBillView as
SELECT Tb_PlanBill.*, Tb_Plan.Status AS PlanStatus, Tb_Plan.content AS PlanContent, 
      Tb_Project.prjNum, Tb_Project.prjName, Tb_Project.Status AS ProjectStatus, 
      Tb_Plan.AddUser AS PlanAuthor, Tb_Plan.GuidID AS PlanID, Tb_Plan.ManageID,
      Tb_Project.GuidID AS ProjectID
FROM ((Tb_Project INNER JOIN
      Tb_Plan ON Tb_Project.GuidID = Tb_Plan.parentGuid) INNER JOIN
      Tb_PlanBill ON Tb_Plan.GuidID = Tb_PlanBill.parentGuid)
