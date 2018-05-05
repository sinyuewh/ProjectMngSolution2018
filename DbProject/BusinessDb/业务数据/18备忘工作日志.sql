CREATE TABLE JLog
(
   guidID	        int identity(1,1),							
   parentGuid	    varchar(36),	
   uploadTime       datetime default(getdate()),
   
   uploadPerson     varchar(20),  --记录用户
   content          varchar(250) --日志内容
   
   constraint PK_Tb_Reply primary key (guidID)
) 