using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using WebFrame;
using WebFrame.Data;

namespace KORWeb.DDL
{
    /// <summary>
    /// 说明：Tb_KaoHeZhiBiao
    /// 编码：
    /// 时间：2016/10/26 19:19:27
    /// </summary>
    [Serializable]
    public class Tb_KaoHeZhiBiaoDD : DataEntityBase
    {
        //实体属性
        public int? Num { get; set; }
	    public String KHID { get; set; }
	    public String KhRemark { get; set; }
	    public Object KhScore { get; set; }
	    public DateTime? Createtime { get; set; }
	    public String Remark { get; set; }
    }
}