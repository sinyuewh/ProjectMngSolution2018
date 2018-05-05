using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using WebFrame;
using KORWeb.BUL;

namespace OAWebSite2016.SysManager.WebUI.WorkLogMng
{
    public partial class WorkReminderList1 : System.Web.UI.Page
    {
        protected override void OnLoad(EventArgs e)
        {
            this.Repeater1.ItemDataBound += new RepeaterItemEventHandler(Repeater1_ItemDataBound);
            base.OnLoad(e);
        }

        void Repeater1_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
           
        }

        void datatype_SelectedIndexChanged(object sender, EventArgs e)
        {
           this.Repeater1.DataBind();
        }
        

        protected void Page_Load(object sender, EventArgs e)
        {

        }
    }
}
