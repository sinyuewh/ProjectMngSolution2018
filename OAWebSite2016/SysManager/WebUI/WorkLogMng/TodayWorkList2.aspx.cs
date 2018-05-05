using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OAWebSite2016.SysManager.WebUI.WorkLogMng
{
    public partial class TodayWorkList2 : System.Web.UI.Page
    {
        protected override void OnInit(EventArgs e)
        {
            this.Repeater1.ItemCommand += new RepeaterCommandEventHandler(Repeater1_ItemCommand);
            this.Repeater1.ItemDataBound += new RepeaterItemEventHandler(Repeater1_ItemDataBound);
            base.OnInit(e);
        }

        void Repeater1_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            
        }

        void Repeater1_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            String planid = e.CommandArgument.ToString();
            Response.Write(planid);
        }


        protected void Page_Load(object sender, EventArgs e)
        {

        }
    }
}
