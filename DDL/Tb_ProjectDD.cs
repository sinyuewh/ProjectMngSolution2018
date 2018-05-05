using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using WebFrame;
using WebFrame.Data;

namespace KORWeb.DDL
{
    /// <summary>
    /// 说明：Tb_Project
    /// 编码：超级用户
    /// 时间：2016/8/8 14:46:48
    /// </summary>
    [Serializable]
    public class Tb_ProjectDD : DataEntityBase
    {
        //实体属性
        public String PrjNum { get; set; }
	    public String PrjName { get; set; }
	    public DateTime? BegDate { get; set; }
	    public DateTime? EndDate { get; set; }
	    public double? PrjMoney { get; set; }
	    public int? Status { get; set; }
	    public String ClientName { get; set; }
	    public String PrjKeys { get; set; }
	    public String Content { get; set; }
	    public String Contenttext { get; set; }
	    public String GuidID { get; set; }
	    public DateTime? AddTime { get; set; }
	    public String AddUser { get; set; }
	    public DateTime? LastTime { get; set; }
	    public String ModifyUser { get; set; }
	    public String ManageID { get; set; }
	    public int? Weight { get; set; }
	    public DateTime? FinishDate { get; set; }
    }
}