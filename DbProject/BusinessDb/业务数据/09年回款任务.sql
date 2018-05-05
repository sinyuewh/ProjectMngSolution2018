 CREATE TABLE Tb_YearMoney
(
   byear	int	     not null,
   OrgID    varchar(50)      ,						
 
   YearMoney double		not null,	
   HuiMoney  double	,
   ChuMoney  double,
   						  
   Remark varchar(200),				
   
   GuidID varchar(50)  not null ,   
   AddTime Date,				
   AddUser varchar(50),								
   
   LastTime Date,								
   ModifyUser varchar(50),							
   ManageID varchar(50),							
          
   constraint PK_Tb_YearMoney primary key (GuidID)
)

/*
  年回款任务
*/