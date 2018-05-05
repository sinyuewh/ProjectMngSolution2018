  -- 2）项目组成员
CREATE TABLE Tb_Project_Person
(
   num int not null,								
   ProjectGuidID	varchar(50) not null,			
   PersonID			varchar(50) not null,			
   PrjRole			varchar(1) not null,			
      
   GuidID			varchar(50) not null ,
   ManageID			varchar(50),							
       
   constraint PK_Tb_Project_Person primary key (GuidID)
)

/*
  drop table Tb_Project_Person
  CREATE TABLE Tb_Project_Person
(
   num int not null,								--序号
   ProjectGuidID	varchar(50) not null,			--项目ID
   PersonID			varchar(50) not null,			--人员ID
   PrjRole			varchar(1) not null,			--项目中角色（0--项目经理 1--普通成员）
      
   GuidID varchar(50) default(newid()) not null ,
   ManageID varchar(50),							--管理ID
       
   constraint PK_Tb_Project_Person primary key (GuidID)
)
*/

