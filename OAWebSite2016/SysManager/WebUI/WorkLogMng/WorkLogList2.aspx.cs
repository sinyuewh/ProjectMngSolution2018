using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using KORWeb.BUL;
using WebFrame;

namespace OAWebSite2016.SysManager.WebUI.WorkLogMng
{
    public partial class WorkLogList2 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                if (WebFrame.Comm.JSecurity.HasSecurity("Tb_WorkLog_READ") == false)
                {
                    JUserBU bu1 = new JUserBU();
                    this.AuthorID.Text = bu1.GetShouquanUserList(FrameLib.UserID, 2);             //表示他人的数据
                }
                else
                {
                    this.AuthorID.Text = "";
                }
            }
        }
    }
}
