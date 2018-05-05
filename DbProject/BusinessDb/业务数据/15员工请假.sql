 CREATE TABLE Tb_QingJia
(
   UserID varchar(50) not null,	
   QingJiaDate	date not null,										
   STitle  nvarchar(200) not null,							
   TianShu int not null,	
   
   GuidID varchar(50)  not null ,   
   AddTime Date,				
   AddUser varchar(50),												
   ManageID varchar(50),							
          
   constraint PK_Tb_QingJia primary key (GuidID)
)


create view Tb_QingJiaView as 
SELECT Tb_QingJia.*, JUser.UserName from Tb_QingJia inner join JUser on Tb_QingJia.UserID=JUser.UserID
