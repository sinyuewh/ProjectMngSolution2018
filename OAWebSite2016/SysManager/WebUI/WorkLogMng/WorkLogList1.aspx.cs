using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace OAWebSite2016.SysManager.WebUI.WorkLogMng
{
    public partial class WorkLogList1 : System.Web.UI.Page
    {
        protected override void OnInit(EventArgs e)
        {
            this.but1.ServerClick += new EventHandler(but1_ServerClick);
            base.OnInit(e);
        }

        //将数据导出到Excel
        void but1_ServerClick(object sender, EventArgs e)
        {
            DataTable dt1 = this.data1.GetListData();
            dt1.Columns.Add("begDate1");
            dt1.Columns.Add("num");
            int i=1;
            foreach (DataRow dr1 in dt1.Rows)
            {
                dr1["begDate1"] = ((DateTime)dr1["begDate"]).ToString("yyyy年MM月dd日");
                dr1["num"] = i+"";
                i++;
            }
            WebFrame.Util.JTool.ImportDataSourceToExcel(dt1, "num:序号,begDate1:日期,LogContent:日志内容");
 
            //WebFrame.Util.JTool.ImportDataSourceToExcel(dt1, "(begdate,'yyyy/mm/dd'):日志时间,LogContent:日志内容");
        }


        protected void Page_Load(object sender, EventArgs e)
        {

        }
    }
}
