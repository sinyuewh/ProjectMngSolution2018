CREATE TABLE Tb_WorkResult
(
   byear	int,							
   bmonth	int,	
   UserName varchar(50),
   
   sworkload double,  --标准工作量
   pworkload0 double, --个人工作量
   tworkload0 double, --团队工作量	
   						  
   completionrate double,
   examresult varchar(50)
)