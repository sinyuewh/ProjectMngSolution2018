using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using WebFrame;
using WebFrame.Data;

namespace KORWeb.DDL
{
    /// <summary>
    /// 说明：Tb_WorkLogReaders
    /// 编码：苏纽兵
    /// 时间：2016/8/19 16:11:48
    /// </summary>
    [Serializable]
    public class Tb_WorkLogReadersDD : DataEntityBase
    {
        //实体属性
        public int? DataID { get; set; }
	    public String ParentID { get; set; }
	    public String ReaderID { get; set; }
    }
}