using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebFrame.Data;
using KORWeb.BUL;

namespace OAWebSite2016.SysManager.WebUI.ProjectLogMng
{
    public partial class ProjectMoneyIndex : System.Web.UI.Page
    {
        /// <summary>
        /// 是否为选中的项目的管理员
        /// </summary>
        public bool IsProjectManager
        {
            get
            {
                if (ViewState["IsProjectManager"] == null)
                {
                    return false;
                }
                else
                {
                    return (bool)ViewState["IsProjectManager"];
                }
            }
            set
            {
                ViewState["IsProjectManager"] = value;
            }
        }

        protected override void OnInit(EventArgs e)
        {
            this.butSearchProject.ServerClick += new EventHandler(butSearchProject_ServerClick);
            this.Repeater1.ItemCommand += new RepeaterCommandEventHandler(Repeater1_ItemCommand);
            this.butSearch2.ServerClick += new EventHandler(butSearch2_ServerClick);
            this.Status.SelectedIndexChanged += new EventHandler(Status_SelectedIndexChanged);
            base.OnInit(e);
        }


        //更改项目的状态
        void Status_SelectedIndexChanged(object sender, EventArgs e)
        {
            this.SearchData();
        }

        void butSearch2_ServerClick(object sender, EventArgs e)
        {
            this.rep2.DataBind();
        }

        //选中的项目信息
        void Repeater1_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            String prj1 = e.CommandArgument.ToString();
            this.parentGuid.Text = prj1;
            this.SearchProjectLogData();
        }

        void butSearchProject_ServerClick(object sender, EventArgs e)
        {
            this.SearchData();
        }

        protected void Page_Load(object sender, EventArgs e)
        {

        }


        //处理不同用户的条件
        protected override void OnPreRenderComplete(EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                //首次加载数据
                this.SearchData();
            }
            base.OnPreRenderComplete(e);
        }


        //查询项目的数据
        private void SearchData()
        {
            if (WebFrame.FrameLib.UserID == "admin")
            {
                this.data0.ParaItems.RemoveAt(5);
                this.rep_list2.DataBind();
            }
            this.Repeater1.DataSource = this.data0.GetListData();
            this.Repeater1.DataBind();

            //默认设置第一个日志选中
            if (this.Repeater1.Items.Count > 0)
            {
                this.parentGuid.Text = (this.Repeater1.Items[0].FindControl("link1") as LinkButton).CommandArgument.ToString();
            }
            else
            {
                this.parentGuid.Text = "-1";
            }
            this.SearchProjectLogData();
        }

        //查询项目日志的数据
        private void SearchProjectLogData()
        {
            var prj1 = this.parentGuid.Text;
            this.rep2.DataBind();
            this.selinfo.Visible = true;

            //得到项目的其他信息
            KORWeb.BUL.Tb_ProjectBU bu1 = new Tb_ProjectBU();
            List<SearchField> condition = new List<SearchField>();
            condition.Add(new SearchField("prjNum", prj1));
            Dictionary<String, object> dic = bu1.GetFirstDictionary(condition, "*");
            if (dic != null && dic.Count > 0)
            {
                this.selproject.Text = dic["prjName"].ToString();
                this.IsProjectManager = bu1.IsCanEditProject(dic["GuidID"].ToString(), WebFrame.FrameLib.UserID);
            }
        }
    }
}
