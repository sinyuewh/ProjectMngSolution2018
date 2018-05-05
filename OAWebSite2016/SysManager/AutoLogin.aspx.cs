using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OAWebSite2016.SysManager
{
    public partial class AutoLogin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            KORWeb.BUL.UTools.ClearCache();
            String str1 = Request["time1"];
            String userid1 = Request["userid"];
            if (String.IsNullOrEmpty(WebFrame.FrameLib.UserID))
            {
                Response.Write("no");
            }
            else
            {
                Response.Write(userid1);
            }
            Response.End();
        }
    }
}
