using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using KORWeb.BUL;

namespace OAWebSite2016.SysManager.WebUI.ProjectMng
{
    public partial class Tb_Task_Log : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
           
        }

        protected override void OnPreRender(EventArgs e)
        {
             if (!Page.IsPostBack)
            {
                
            }
            base.OnPreRender(e);
        }
    }
}
