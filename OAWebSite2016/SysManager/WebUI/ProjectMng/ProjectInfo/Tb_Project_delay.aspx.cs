using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using WebFrame.Util;
using KORWeb.BUL;

namespace OAWebSite2016.SysManager.WebUI.ProjectMng
{
    public partial class Tb_Project_delay : System.Web.UI.Page
    {
        protected override void OnInit(EventArgs e)
        {
            this.btnSubmit.ServerClick += new EventHandler(btnSubmit_ServerClick);
            base.OnInit(e);
        }

        //提交附件处理
        void btnSubmit_ServerClick(object sender, EventArgs e)
        {
            bool succ = false;
            String prjNum = Request.QueryString["parentGuid"];
            DateTime t1 = DateTime.Parse(this.endDate.Text);
            String remark1 = this.contenttext.Text;
            KORWeb.BUL.Tb_ProjectBU bu1 = new Tb_ProjectBU();
            succ = bu1.DelayProjectData(prjNum, t1, remark1);

            if (succ)   //submit succ
            {
                String js1 = "layer.alert('操作成功!',function(index){;";
                js1 = js1 + " var index = parent.layer.getFrameIndex(window.name);";
                js1 = js1 + " parent.$('#butSearch').click();";
                js1 = js1 + " parent.layer.close(index);});";
                JAjax.ExecuteJS(js1);
            }
            else
            {
                UTools.Alert("操作失败，请重试!");
            }
        }


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                String parentGuid = Request.QueryString["parentGuid"];
                int t1 = KORWeb.BUL.Tb_ProjectBU.GetProjectClassByUserID(parentGuid, WebFrame.FrameLib.UserID);

                if (t1 >= 3)
                {
                    this.sec0.Visible = true;
                }
                else
                {
                    this.sec0.Visible = false;
                }
            }
        }
    }
}
