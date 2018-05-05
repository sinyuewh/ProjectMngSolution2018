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
    public class JModelDD : DataEntityBase
    {
        //实体属性
        public int? Num { get; set; }
        public String ModelGroup { get; set; }
	    public String ModelID { get; set; }
	    public String ModelName { get; set; }
	    public String ModelText { get; set; }
	    public String ModelICo { get; set; }
	    public String ModelUrl { get; set; }
	    public int? MenuID { get; set; }
	    public String AuthorityUnitID { get; set; }
	    public String Remark { get; set; }
    }
}