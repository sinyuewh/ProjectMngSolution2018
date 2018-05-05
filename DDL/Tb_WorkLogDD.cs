using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using WebFrame;
using WebFrame.Data;

namespace KORWeb.DDL
{
    /// <summary>
    /// 说明：Tb_WorkLog
    /// 编码：苏纽兵
    /// 时间：2016/8/19 16:11:48
    /// </summary>
    [Serializable]
    public class Tb_WorkLogDD : DataEntityBase
    {
        //实体属性
        public String LogID { get; set; }
	    public String AuthorID { get; set; }
	    public String LogTitle { get; set; }
	    

        public String ParentGuid { get; set; }
        public String PlanID { get; set; }
        public String PlanNum { get; set; }
        public String AddUserID { get; set; }
        public String AddUserName { get; set; }
        public DateTime BegDate { get; set; }
        public String LogContent { get; set; }
        public DateTime? AddTime { get; set; }
        public double? WorkLoad { get; set; }
        
    }
}