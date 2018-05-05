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
    public class JItemDetailDD : DataEntityBase
    {
        //实体属性
        public int? ID { get; set; }
	    public int? Num { get; set; }
	    public String Itemname { get; set; }
	    public String Itemtext { get; set; }
	    public String ItemValue { get; set; }
    }
}