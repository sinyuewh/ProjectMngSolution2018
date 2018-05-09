using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OAWebSite2016.SysManager.WebUI.ProjectMng.ProblemLog
{
    public partial class ProblemLogEdit : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                this.data1.GetListData();
            }
        }
    }
}
