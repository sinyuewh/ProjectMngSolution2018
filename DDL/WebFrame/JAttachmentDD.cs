using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using WebFrame.Data;

namespace KORWeb.DDL
{
    [Serializable]
    public class JAttachmentDD : DataEntityBase
    {
        //实体属性
        public String GUIDID { get; set; }
        public String PARENTGUID { get; set; }
        public String FILENAME { get; set; }
        public String ENCRYPTFILENAME { get; set; }
        public DateTime? UPLOADTIME { get; set; }
        public String UPLOADPERSON { get; set; }

        public String KIND { get; set; }
        public String FILEDIR { get; set; }
        public int? DEL { get; set; }
    }
}
