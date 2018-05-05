CREATE TABLE Tb_MoneyBill
(
   ProjectGuidID varchar(50) not null ,	  
   STitle  nvarchar(200) not null,
   SKind nvarchar(1) not null,
   
   PersonID		varchar(50) not null,				
   DoMoney double		not null,	
   DoTime Date,
     						  
   Remark varchar(200),				
   
   GuidID varchar(50)  not null ,   
   AddTime Date,				
   AddUser varchar(50),								
   
   LastTime Date,								
   ModifyUser varchar(50),							
   ManageID varchar(50),							
          
   constraint PK_Tb_MoneyBill primary key (GuidID)
)

/*
  回款支出流水
  SKind=0 表示回款
  SKind=1 表示支出
  
*/