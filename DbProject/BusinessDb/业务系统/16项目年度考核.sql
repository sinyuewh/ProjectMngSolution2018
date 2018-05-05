 /*
   byear	考核年度
   ProjectGuidID 项目ID	
   prjNum	项目编号,					
   prjName	项目名称,
   prjManager 项目经理,
   
   begDate	date 项目开始日期,									
   endDate	date 项目计划结束日期,
   FactEndDate date 项目实际日期,
   YanQiDay int 延期天数,
   YanQiRate double 延期比例,
   
   KaoHeResult varchar(10) 考核结果
   HuiDuan double 项目回款
   ZhiChu double  项目支出		
   KaoHeRate double	考核率
   KaoHeMoney double 项目提成
 */
 
 CREATE TABLE Tb_ProjectYearKaoHe
(
   byear	int not null,
   ProjectGuidID varchar(50) not null, 
   
   prjNum	varchar(50) not null,					
   prjName	varchar(200) not null,
   prjManager varchar(200),			
   
   begDate	date not null,									
   endDate	date not null,
   FactEndDate date not null,
   YanQiDay int not null,
   YanQiRate double not null,
   
   KaoHeResult varchar(10) not null,
   HuiDuan double not null,
   ZhiChu double not null,		
   KaoHeRate double not null,
   KaoHeMoney double not null,	
   
   GuidID varchar(50) not null,   
   AddTime Date,				
   AddUser varchar(50),														
   ManageID varchar(50),
   
   constraint PK_Tb_ProjectYearKaoHe primary key (GuidID)
)


drop table Tb_ProjectYearKaoHe