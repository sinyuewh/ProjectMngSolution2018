using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OAWebSite2016.SysManager.WebUI.WorkMng
{
    public partial class TB_Task_List4 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }


        protected override void OnPreRenderComplete(EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                ListItem item0 = new ListItem("--不限--", "");
                this.ExecuteMan.Items.Insert(0, item0);
                this.ExecuteMan.SelectedValue = "";
                this.Repeater1.DataBind();
            }
            base.OnPreRenderComplete(e);
        }
    }
}
