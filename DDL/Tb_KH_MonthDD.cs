using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using WebFrame;
using WebFrame.Data;

namespace KORWeb.DDL
{
    /// <summary>
    /// 说明：Tb_KH_Month
    /// 编码：金寿吉
    /// 时间：2016/8/27 11:04:35
    /// </summary>
    [Serializable]
    public class Tb_KH_MonthDD : DataEntityBase
    {
        //实体属性
        public int? DataID { get; set; }
	    public int? Byear { get; set; }
	    public int? Bmonth { get; set; }
	    public String UserID { get; set; }
	    public String UserName { get; set; }
	    public int? FullLoad { get; set; }
	    public int? WorkLoad { get; set; }
	    public int? WorkLoad1 { get; set; }
	    public int? WorkLoad2 { get; set; }
	    public int? WorkLoad3 { get; set; }
	    public double? Rate { get; set; }
	    public double? AddMoney { get; set; }
	    public String Remark { get; set; }
    }
}