using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using WebFrame;
using WebFrame.Data;

namespace KORWeb.DDL
{
    /// <summary>
    /// 说明：实体类
    /// 编码：jsj
    /// 时间：2013-8-2 14:53:16
    /// </summary>
    [Serializable]
    public class JUserDD : DataEntityBase
    {
        //实体属性
        public int? Num { get; set; }
	    public String UserID { get; set; }
	    public String PassWord { get; set; }
	    public String UserName { get; set; }
	    public DateTime? LastLogin { get; set; }
	    public int? LoginCount { get; set; }
        public int? Status { get; set; }
        public String AuthorityID { get; set; }
        public String AuthorityGroup { get; set; }
        public String WbCardID { get; set; }
        public String DepartID { get; set; }
    }
}