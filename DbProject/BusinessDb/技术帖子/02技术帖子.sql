 CREATE TABLE Tb_Info
(
    TypeID	varchar(50),					
    Pic varchar(200) ,						
    STitle  varchar(200),					
    STitle1  varchar(200),					
    Content text,							
    ContentText text,						
    Keys varchar(200),						
    WebUrl varchar(250),					
    
    Source varchar(200),				    
    Weight int ,							
    Status int,											
    Remark varchar(250),					
    VisitTime datetime,						
    HitCount int ,				
    Del int ,						
       
    GuidID varchar(50) not null ,
    AddTime Datetime ,	
    AddUser varchar(50),					
    ExpireDate Datetime,					
    LastTime Datetime,						
    ModifyUser varchar(50),					
    ManageID varchar(50),					
    
    constraint PK_Tb_Info primary key (GuidID)
)

/*
	帖子信息
*/