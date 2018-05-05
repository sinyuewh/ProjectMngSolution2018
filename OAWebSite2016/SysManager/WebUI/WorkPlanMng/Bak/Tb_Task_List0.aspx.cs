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
    public partial class Tb_Task_List0 : System.Web.UI.Page
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
            base.OnInit(e);
        }


        void parentGuid_SelectedIndexChanged(object sender, EventArgs e)
        {
            this.SetProjectManager();
        }

               
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        protected override void OnPreRenderComplete(EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                Tb_ProjectBU.SetProjectListByStatus(this.parentGuid, "0");

                this.SetProjectManager();       //设置当前项目的项目管理员
                this.Repeater1.DataBind();    
            }
            base.OnPreRenderComplete(e);
        }


        //设置项目的管理员
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
