using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using WebFrame;
using WebFrame.Data;

namespace KORWeb.DDL
{
    /// <summary>
    /// 说明：Tb_WorkReminder
    /// 编码：金寿吉
    /// 时间：2016/10/17 10:04:07
    /// </summary>
    [Serializable]
    public class Tb_WorkReminderDD : DataEntityBase
    {
        //实体属性
        public String LogID { get; set; }
	    public String AuthorID { get; set; }
	    public DateTime? BegDate { get; set; }
	    public String LogContent { get; set; }
	    public DateTime? RegTime { get; set; }
	    public String JB { get; set; }
	    public bool? IsDone { get; set; }
    }
}