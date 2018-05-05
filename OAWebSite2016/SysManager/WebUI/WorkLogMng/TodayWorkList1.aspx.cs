using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OAWebSite2016.SysManager.WebUI.WorkLogMng
{
    public partial class TodayWorkList : System.Web.UI.Page
    {
        protected override void OnInit(EventArgs e)
        {
            this.but1.ServerClick += new EventHandler(but1_ServerClick);
            base.OnInit(e);
        }

        //Submit 提交今日工作
        void but1_ServerClick(object sender, EventArgs e)
        {
            List<KORWeb.DDL.Tb_WorkLogDD> list1 = new List<KORWeb.DDL.Tb_WorkLogDD>();
            foreach(RepeaterItem item1 in this.Repeater1.Items)
            {
                KORWeb.DDL.Tb_WorkLogDD dd1 = new KORWeb.DDL.Tb_WorkLogDD();

                dd1.ParentGuid = (item1.FindControl("parentGuid") as Label).Text;
                dd1.PlanID = (item1.FindControl("PlanID") as Label).Text;
                dd1.PlanNum = (item1.FindControl("PlanNum") as Label).Text;
                dd1.AddUserID = WebFrame.FrameLib.UserID;
                dd1.AddUserName = WebFrame.FrameLib.UserName ;
                dd1.BegDate = DateTime.Today;
                dd1.LogContent = (item1.FindControl("LogContent") as TextBox).Text;
                dd1.AddTime = DateTime.Now;
                dd1.WorkLoad = double.Parse((item1.FindControl("WorkLoad") as TextBox).Text);

                //设置数据更新的条件
                list1.Add(dd1);
            }

            KORWeb.BUL.Tb_WorkLogBU bu1 = new KORWeb.BUL.Tb_WorkLogBU();
            bool succ = bu1.UpdateTodayLog(list1);
            if (succ==false)
            {
                KORWeb.BUL.UTools.Alert("错误：提交今日工作数据失败，请重试！");                
            }
        }


        protected void Page_Load(object sender, EventArgs e)
        {

        }
    }
}
