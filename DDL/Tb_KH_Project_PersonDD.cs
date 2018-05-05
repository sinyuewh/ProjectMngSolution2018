using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using WebFrame;
using WebFrame.Data;

namespace KORWeb.DDL
{
    /// <summary>
    /// 说明：Tb_KH_Project_Person
    /// 编码：超级用户
    /// 时间：2016/9/4 22:32:07
    /// </summary>
    [Serializable]
    public class Tb_KH_Project_PersonDD : DataEntityBase
    {
        //实体属性
        public int? DataID { get; set; }
	    public String ParentID { get; set; }
	    public String UserID { get; set; }
	    public String UserName { get; set; }
	    public int? WorkLoad { get; set; }
	    public int? FactWorkLoad { get; set; }
	    public double? Bonus { get; set; }
	    public String Remark { get; set; }
    }
}