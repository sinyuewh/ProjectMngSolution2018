 CREATE TABLE Tb_Reply
(
    guidID varchar(50)  not null,						
	parentGuid varchar(50) ,							
   
    Stitle  varchar(200),								
    Content text,										
    Status int ,								
          
    AddTime Date ,										
    AddUserID varchar(50),								
    AddUserNet varchar(50),								
    AddIP varchar(50),									
    ManageID varchar(50),								
    
    constraint PK_Tb_Reply primary key (GuidID)
)

create view Tb_ReplyView
 as
  select Tb_Reply.*,JUser.UserName from Tb_Reply 
     left outer join JUser on Tb_Reply.AddUserID=JUser.UserID
/*
 为综合信息回复表
 CREATE TABLE Tb_Reply
(
    guidID varchar(50)  not null,						--唯一标示码
	parentGuid varchar(50) ,							--父表Guid
   
    Stitle  varchar(200),								--回复标题
    Content text,										--回复内容
    Status int default(0),								--状态(1--显示 0--不显示）
          
    AddTime Date ,										--创建时间
    AddUserID varchar(50),								--创建用户ID
    AddUserNet varchar(50),								--创建会员昵称
    AddIP varchar(50),									--创建IP
    ManageID varchar(50),								--管理ID
    
    constraint PK_Tb_Reply primary key (GuidID)
)
*/