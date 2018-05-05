 /* 个人年度考核 */
 
 CREATE TABLE Tb_PersonYearKaoHe
(
   byear	int not null,
   UserID  varchar(50) not null,				
   UserName	varchar(200) not null,
   
   A1Count int,
   A2Count int,
   A3Count int,
   A4Count int,
   
   B1Count int,
   B2Count int,
   B3Count int,
   B4Count int,
     
   FDebug int,
   Debug1 int,
   Debug2 int,
   Debug3 int,
      
   GuidID varchar(50)  not null ,   
   AddTime Date,				
   AddUser varchar(50),														
   ManageID varchar(50),							
          
   constraint PK_Tb_PersonYearKaoHe primary key (GuidID)				
)