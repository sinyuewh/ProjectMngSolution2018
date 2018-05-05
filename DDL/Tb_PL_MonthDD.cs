using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using WebFrame;
using WebFrame.Data;

namespace KORWeb.DDL
{
    /// <summary>
    /// 说明：Tb_PL_Month
    /// 编码：超级用户
    /// 时间：2016/10/27 16:48:36
    /// </summary>
    [Serializable]
    public class Tb_PL_MonthDD : DataEntityBase
    {
        //实体属性
        public int? CheckDataID { get; set; }
	    public int? Byear { get; set; }
	    public int? Bmonth { get; set; }
	    public String UserID { get; set; }
	    public String UserName { get; set; }
	    public int? CheckScore { get; set; }
	    public int? AddScore { get; set; }
	    public int? TotalScore { get; set; }
	    public int? TotalWork { get; set; }
	    public int? FactWork { get; set; }
	    public double? WorkRate { get; set; }
	    public String CheckResult { get; set; }
	    public String Remark { get; set; }
    }
}