using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using WebFrame;
using WebFrame.Data;

namespace KORWeb.DDL
{
    /// <summary>
    /// 说明：Tb_Project_Log
    /// 编码：超级用户
    /// 时间：2016/8/8 22:57:51
    /// </summary>
    [Serializable]
    public class Tb_Project_LogDD : DataEntityBase
    {
        //实体属性
        public String GuidID { get; set; }
	    public String ParentGuid { get; set; }
	    public String Stitle { get; set; }
	    public String Content { get; set; }
	    public DateTime? AddTime { get; set; }
	    public String AddUserID { get; set; }
	    public String AddUserNet { get; set; }
    }
}