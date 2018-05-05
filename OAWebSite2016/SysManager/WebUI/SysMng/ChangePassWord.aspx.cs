using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OAWebSite2016.SysManager.WebUI.SysMng
{
    public partial class ChangePassWord : System.Web.UI.Page
    {
        protected override void OnInit(EventArgs e)
        {
            this.btnSubmit.ServerClick += new EventHandler(btnSubmit_ServerClick);
            base.OnInit(e);
        }


        void btnSubmit_ServerClick(object sender, EventArgs e)
        {
           string error=(new KORWeb.BUL.JUserBU()).ChangeOldPassWord(this.oldPass.Text, this.pass1.Text);
           if (String.IsNullOrEmpty(error))
           {
               KORWeb.BUL.UTools.Alert("提示：更新密码操作成功！");
           }
           else
           {
               KORWeb.BUL.UTools.Alert(error);
           }
        }

        protected void Page_Load(object sender, EventArgs e)
        {

        }
    }
}
