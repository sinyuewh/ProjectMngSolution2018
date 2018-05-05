using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebFrame.Util;

namespace OAWebSite2016.SysManager.WebUI.SysMng
{
    public partial class JRole_SetUsers : System.Web.UI.Page
    {
        protected override void OnInit(EventArgs e)
        {
            this.but1.Click += new EventHandler(but1_Click);
            base.OnInit(e);
        }

        void but1_Click(object sender, EventArgs e)
        {
            String userid=this.seluserid.Value;
            String roleid = Request["RoleID"];
            if (String.IsNullOrEmpty(userid) == false
                && String.IsNullOrEmpty(roleid) == false)
            {
                WebFrame.Comm.JRoleUsersBU bu1 = new WebFrame.Comm.JRoleUsersBU();
                bu1.SetRoleUserID(roleid, userid, "0");
            }
            
            String js1 = "layer.alert('操作成功!',function(index){;";
            js1 = js1 + " var index = parent.layer.getFrameIndex(window.name);";
            js1 = js1 + " parent.$('#butSearch').click();";
            js1 = js1 + " parent.layer.close(index);});";
            JAjax.ExecuteJS(js1);
        }
        protected void Page_Load(object sender, EventArgs e)
        {

        }
    }
}
