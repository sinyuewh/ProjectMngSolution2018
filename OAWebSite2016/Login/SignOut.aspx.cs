using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using KORWeb.BUL;
using WebFrame.Util;
using WebFrame;

namespace KORWeb.WebSite.SysManager
{
    public partial class SignOut : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                String kind = FrameLib.AuthorityGroup ;
                System.Web.Security.FormsAuthentication.SignOut();
                Session.Abandon();

                //kind=0 表示的是管理后台用户

                //移除保存用户名的Cookie
                //JCookie.RemoveCookie("Admin_LastLoginUserID");
                Response.Redirect("/default.aspx", true);

            }
        }
    }
}