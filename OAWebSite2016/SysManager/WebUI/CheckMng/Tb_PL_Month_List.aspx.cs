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
using KORWeb.BUL;

namespace OAWebSite2016.SysManager.WebUI.CheckMng
{
    public partial class Tb_PL_Month_List : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                this.byear.Text = DateTime.Now.Year + "";
                this.bmonth.Text = DateTime.Now.Month + "";

                if (WebFrame.Comm.JAuthorityBU.HasSecurity("Tb_PL_Month_READ") == false)
                {
                    JUserBU bu1 = new JUserBU();
                    String s1 = bu1.GetShouquanUserList(WebFrame.FrameLib.UserID, 4);
                    if (s1 == "-1")
                    {
                        this.UserID.Text = WebFrame.FrameLib.UserID;
                    }
                    else
                    {
                        this.UserID.Text = s1 + "," + WebFrame.FrameLib.UserID;
                    }
                }
                else
                {
                    this.UserID.Text = "";
                }

                this.Repeater1.DataBind();
            }
        }
    }
}
