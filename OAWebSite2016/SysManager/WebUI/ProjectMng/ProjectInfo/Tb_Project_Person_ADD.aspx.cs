using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebFrame.Util;
using KORWeb.BUL;

namespace OAWebSite2016.SysManager.WebUI.ProjectMng
{
    public partial class Tb_Project_Person_ADD : System.Web.UI.Page
    {
        protected override void OnInit(EventArgs e)
        {
            this.btnSubmit.ServerClick += new EventHandler(btnSubmit_ServerClick);
            base.OnInit(e);
        }

        void btnSubmit_ServerClick(object sender, EventArgs e)
        {
            this.SaveData();
        }


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                this.UserID.Attributes["ReadOnly"] = "true";
                
            }
        }

        protected override void OnPreRenderComplete(EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                this.parentGuid.Text = Request.QueryString["parentGuid"];
                this.guidID.Text = WebFrame.Util.JString.GetUnique32ID();

               // this.PersonID.Items.Insert(0, new ListItem("--请选择--", ""));

                

                int t1 = KORWeb.BUL.Tb_ProjectBU.GetProjectClassByUserID(Request.QueryString["parentGuid"], WebFrame.FrameLib.UserID);

                if (t1 >= 3)
                {
                    this.sec0.Visible = true;
                }
                else
                {
                    this.sec0.Visible = false;
                }
            }
            base.OnPreRenderComplete(e);
        }

        private void SaveData()
        {
            String error = String.Empty;
            bool succ = false;
            Control con1 = this.bean1.CheckControls(out error);  //后台进行数据验证
            if (con1 != null)
            {
                UTools.Alert(error);
            }
            else
            {
                
            }
        }
    }
}
