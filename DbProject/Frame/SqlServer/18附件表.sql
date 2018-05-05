 -- 附件表
IF EXISTS (SELECT * FROM sysobjects WHERE type = 'U' AND name = 'JAttachment')
	BEGIN
		DROP  Table JAttachment
	END
GO

CREATE TABLE JAttachment
(
	   guidID varchar(36) default newid() not null,		--ID
       parentGuid varchar(36) not null,					--父表Guid
       FileName varchar(200),							--附件文件名(原始文件名)    
       EncryptFileName varchar(200) ,					--附件文件名(物理文件名（存放服务器上文件名）包含相对路径)   
       UploadTime  DateTime default(getdate()),			--上传时间
       UploadPerson varchar(20),						--上传人
       kind varchar(1),									--文件类型(kind=0时表示为图形文件，为其他的表示为普通附件)
       FileDir varchar(500),							--文件目录
       del int default 0 not null,						--删除标示(0:未删除，1：已删除)
       constraint PK_JAttachment primary key (guidID)	--guid主键
)
GO