CREATE TABLE Tb_Doc
(
   ProjectGuidID	varchar(50) ,					
   
   ParentGuidID  varchar(50),						
   STitle  varchar(50),								
   
   SKind int,										
   FileName	varchar(200) ,							
   PhysicalFile	varchar(200) ,						
   FileDir	varchar(200) ,							
   
   DocType varchar(100),
   DocKeys varchar(200),							
   Remark varchar(250) ,							
   
   AddTime	datetime ,			
   AddUser	varchar(50) not null,		
   Manager  varchar(50),			 
	
   GuidID varchar(50)  not null ,
   ManageID varchar(50),							
   
   constraint PK_Tb_Doc primary key (GuidID)
)

--DocType 文件柜类别
--Manager 文件柜管理员（只允许设置一个）

drop table tb_doc


--电子文件柜的读者
CREATE TABLE Tb_DocReaders
(   
   ParentGuidID		varchar(50)	,					
   PersonID			varchar(50),	
   GuidID varchar(50)  not null ,    
   constraint PK_Tb_DocReaders primary key (GuidID)
)

--我关注的文档
CREATE TABLE Tb_MyDoc
(   
   ParentGuidID		varchar(50)	,					
   PersonID			varchar(50),	
   GuidID varchar(50)  not null ,    
   constraint PK_Tb_MyDoc primary key (GuidID)
)

/*
   针对文件柜，需要设置文件柜的访问者
    
   ProjectGuidID	varchar(50) ,					--项目ID（可以为空）
   ParentGuidID  varchar(50),						--父文档的ID
   STitle  varchar(50),								--标题
   
   SKind int,										--类别
   FileName	varchar(200) ,							--文件名称
   PhysicalFile	varchar(200) ,						--物理文件
   FileDir	varchar(200) ,							--存放虚拟目录
   
   DocKeys varchar(200),							--文档标签
   Remark varchar(500) ,							--文档说明
   
   AddTime	datetime default(getdate()),			--上传时间
   AddUser	varchar(50) not null,					--上传用户 
	
   GuidID varchar(50) default(newid()) not null ,
   ManageID varchar(50),							--管理ID
*/