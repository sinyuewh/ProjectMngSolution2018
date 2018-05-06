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

namespace OAWebSite2016.SysManager.WebUI.ProjectMng
{
    public partial class Tb_Project_Person : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                int t1 = KORWeb.BUL.Tb_ProjectBU.GetProjectClassByUserID(Request.QueryString["parentGuid"], WebFrame.FrameLib.UserID);
                
                if (t1 >= 3)
                {
                    this.IsAdmin.Text = "1";
                }
                else
                {
                    this.IsAdmin.Text = "0";
                }
            }
        }
    }
}
