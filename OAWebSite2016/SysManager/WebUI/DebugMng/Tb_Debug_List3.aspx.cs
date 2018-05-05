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
using WebFrame;
using KORWeb.BUL;
using WebFrame.Data;
using System.Collections.Generic;

namespace OAWebSite2016.SysManager.WebUI.WorkPlanMng
{
    public partial class Tb_Debug_List3 : System.Web.UI.Page
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

            //不是管理员，默认看自己的BUG
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
                Tb_ProjectBU.SetProjectListByStatusForBug(this.parentGuid, "3");

                this.SetProjectManager();       //设置当前项目的项目管理员

                //不是管理员，默认看自己的BUG
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
                this.IsManager = bu1.IsCanEditProjectForBug(projectID, FrameLib.UserID);
            }
        }
    }
}
