using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using WebFrame;
using WebFrame.Data;

namespace KORWeb.DDL
{
    /// <summary>
    /// 说明：JLog
    /// 编码：
    /// 时间：2016/12/8 11:55:46
    /// </summary>
    [Serializable]
    public class JLogDD : DataEntityBase
    {
        //实体属性
        public int? GuidID { get; set; }
        public String ParentGuid { get; set; }
        public DateTime? UploadTime { get; set; }
        public String UploadPerson { get; set; }
        public String Content { get; set; }
    }
}
