using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OAWebSite2016.SysManager.WebUI.CheckMng
{
    public partial class CheckList1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                //假如没有浏览所有数据的权限，则只能浏览自己的数据
                if (WebFrame.Comm.JAuthorityBU.HasSecurity("Tb_KH_Month_READ") == false)
                {
                    this.UserID.Text = WebFrame.FrameLib.UserID;
                }
            }
        }
    }
}
