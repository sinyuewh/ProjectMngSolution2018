using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using KORWeb.BUL;
using WebFrame.Data;
using WebFrame;

namespace OAWebSite2016.SysManager.WebUI.WorkPlanMng
{
    public partial class Tb_Task_List5 : System.Web.UI.Page
    {
        /// <summary>
        /// 表示项目管理员
        /// </summary>
        public bool IsManager
        {
            get
            {
                if (ViewState["IsManager"] == null)
                {
                    return false;
                }
                else
                {
                    return (bool)ViewState["IsManager"];
                }
            }
            set
            {
                ViewState["IsManager"] = value;
            }
        }


        protected override void OnInit(EventArgs e)
        {
            this.parentGuid.SelectedIndexChanged += new EventHandler(parentGuid_SelectedIndexChanged);
            this.MyTask.SelectedIndexChanged += new EventHandler(MyTask_SelectedIndexChanged);
            base.OnInit(e);
        }

        void MyTask_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (this.MyTask.SelectedValue == "0")
            {
                this.ExecuteManID.Text = FrameLib.UserID;
            }
            else
            {
                this.ExecuteManID.Text = "";
            }

            this.Repeater1.DataBind();
        }


        void parentGuid_SelectedIndexChanged(object sender, EventArgs e)
        {
            this.SetProjectManager();

            if (this.IsManager == false)
            {
                this.MyTask.SelectedValue = "0";
                this.ExecuteManID.Text = FrameLib.UserID;
            }
            else
            {
                this.MyTask.SelectedValue = "1";
                this.ExecuteManID.Text = "";
            }

            this.Repeater1.DataBind();
        }


        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected override void OnPreRenderComplete(EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                Tb_ProjectBU.SetProjectListByStatus(this.parentGuid, "9");

                this.SetProjectManager();       //设置当前项目的项目管理员

                if (this.IsManager == false)
                {
                    this.MyTask.SelectedValue = "0";
                    this.ExecuteManID.Text = FrameLib.UserID;
                }
                else
                {
                    this.MyTask.SelectedValue = "1";
                    this.ExecuteManID.Text = "";
                }


               this.Repeater1.DataBind();
            }
            base.OnPreRenderComplete(e);
        }


        private void SetProjectManager()
        {
            String projectNum = this.parentGuid.SelectedValue;
            Tb_ProjectBU bu1 = new Tb_ProjectBU();
            List<SearchField> condition = new List<SearchField>();
            condition.Add(new SearchField("prjNum", projectNum));
            Dictionary<String, object> dic1 = bu1.GetFirstDictionary(condition, "GuidID");
            if (dic1 != null && dic1.Count > 0)
            {
                String projectID = dic1["GuidID"].ToString();
                this.IsManager = bu1.IsCanEditProject(projectID, FrameLib.UserID);
            }
        }
    }
}
