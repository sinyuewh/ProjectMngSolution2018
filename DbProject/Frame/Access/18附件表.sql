CREATE TABLE JAttachment
(
   guidID             guid default GenGUID()   not null,
   parentGuid		  varchar(36) not null,		
   
   FileName varchar(200),							  
   EncryptFileName varchar(200) ,					
   UploadTime  Date,			
   UploadPerson varchar(20),						
   kind varchar(1),									
   FileDir varchar(250),							
   del int default 0 not null,						
   constraint PK_JAttachment primary key (guidID)	
)
GO



