using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using WebFrame.Util;
using KORWeb.BUL;
using System;

namespace OAWebSite2016.Plat_ZgDw.WebUI.HYhgl
{
    public partial class ChangePassWord : System.Web.UI.Page
    {
        protected override void OnInit(EventArgs e)
        {
            this.but1.Click += new EventHandler(but1_Click);
            base.OnInit(e);
        }


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {

            }
        }

        //submit data
        void but1_Click(object sender, EventArgs e)
        {
            String error = String.Empty;
            Control con1 = JControl.CheckControls(new Control[] { this.pass1, this.pass2, this.oldpass }, out error);
            if (con1 != null)
            {
                UTools.AlertAndFocusControl(error, con1.ClientID);
            }
            else
            {
                JUserBU bu1 = new JUserBU();
                error = bu1.ChangeOldPassWord(this.oldpass.Text, this.pass1.Text);
                if (String.IsNullOrEmpty(error))
                {
                    UTools.Alert("提示：密码修改成功，下次登录生效！");
                }
                else
                {
                    UTools.Alert(error);
                }
            }
        }
    }
}
