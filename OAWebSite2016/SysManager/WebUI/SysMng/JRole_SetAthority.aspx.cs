using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebFrame.Util;

namespace OAWebSite2016.SysManager.WebUI.SysMng
{
    public partial class JRole_SetAthority : System.Web.UI.Page
    {
        protected override void OnInit(EventArgs e)
        {
            this.but1.Click += new EventHandler(but1_Click);
            base.OnInit(e);
        }

        void but1_Click(object sender, EventArgs e)
        {
            String seldata = this.selectdata.Value;
            String roleid = Request["RoleID"];
            if (String.IsNullOrEmpty(seldata) == false
                && String.IsNullOrEmpty(roleid) == false)
            {
                List<String> list1=new List<string>();
                String[] arr1=seldata.Split(',');
                foreach(String m in arr1)
                {
                    list1.Add(m);
                }

                WebFrame.Comm.JAuthorityBU bu1=new WebFrame.Comm.JAuthorityBU();
                bool succ=bu1.SetRoleAuthorityUnit(roleid,list1);
                
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
