using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using WebFrame;
using WebFrame.Data;

namespace KORWeb.DDL
{
    /// <summary>
    /// 说明：Tb_Task_Bug
    /// 编码：肖生辉
    /// 时间：2016/8/18 16:23:22
    /// </summary>
    [Serializable]
    public class Tb_Task_BugDD : DataEntityBase
    {
        //实体属性
        public String GuidID { get; set; }
	    public String ParentGuid { get; set; }
	    public int? BugA { get; set; }
	    public int? BugB { get; set; }
	    public int? BugC { get; set; }
	    public String Remark { get; set; }
	    public DateTime? AddTime { get; set; }
	    public String AddUserID { get; set; }
	    public String AddUserNet { get; set; }
	    public int? Kind { get; set; }
	    public String RelateFile { get; set; }
	    public String RelaTrueName { get; set; }
    }
}