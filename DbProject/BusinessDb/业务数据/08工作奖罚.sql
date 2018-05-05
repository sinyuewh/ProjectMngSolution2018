 CREATE TABLE Tb_WorkDayMoney
(						
   PersonID		varchar(50) not null,
   WorkMoney double,	
   MoneyDay  date,						  
   Remark varchar(200),				
   
   GuidID varchar(50)  not null ,   
   AddTime Date,				
   AddUser varchar(50),								
   
   LastTime Datetime,								
   ModifyUser varchar(50),							
   ManageID varchar(50),							
          
   constraint PK_Tb_WorkDayMoney primary key (GuidID)
)

/*
  工作奖罚
   PersonID		varchar(50) not null,	--奖罚人
   WorkMoney double,					--奖罚金额
   MoneyDay  date,						--奖罚日期  
   Remark varchar(200),					--奖罚原因
   
   GuidID varchar(50)  not null ,   
   AddTime Date,				
   AddUser varchar(50),								
   
   LastTime Datetime,								
   ModifyUser varchar(50),							
   ManageID varchar(50),	
*/