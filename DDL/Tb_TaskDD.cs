using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using WebFrame;
using WebFrame.Data;

namespace KORWeb.DDL
{
    /// <summary>
    /// 说明：Tb_Task
    /// 编码：王松
    /// 时间：2016/8/11 17:28:13
    /// </summary>
    [Serializable]
    public class Tb_TaskDD : DataEntityBase
    {
        //实体属性
        public String BigKind { get; set; }
	    public String ProjectGuidID { get; set; }
	    public DateTime? BegDate { get; set; }
	    public DateTime? EndDate { get; set; }
	    public double? Workload { get; set; }
	    public String TaskTitle { get; set; }
	    public String Content { get; set; }
	    public String Manager { get; set; }
	    public String ExecuteMan { get; set; }
	    public String TestMan { get; set; }
	    public String Status { get; set; }
	    public int? GuidID { get; set; }
	    public DateTime? AddTime { get; set; }
	    public String AddUser { get; set; }
	    public DateTime? FinishData { get; set; }
	    public int? TrueWorkLoad { get; set; }
	    public String RelaFile { get; set; }
    }
}