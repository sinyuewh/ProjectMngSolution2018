using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using KORWeb.BUL;

namespace OAWebSite2016.SysManager.WebUI.ProjectMng
{
    public partial class Tb_Project_Log : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
           
        }

        protected override void OnPreRender(EventArgs e)
        {
             if (!Page.IsPostBack)
            {
                //判断当前用户是否为项目经理或admin
                //bool isEdit = false;
                //Tb_ProjectBU bu1 = new Tb_ProjectBU();
                //isEdit =bu1.IsCanEditProject(Request.QueryString["parentGuid"],WebFrame.FrameLib.UserID);
                //this.sec1.Visible = isEdit;
                //this.sec1.Visible = true;
            }
            base.OnPreRender(e);
        }
    }
}
