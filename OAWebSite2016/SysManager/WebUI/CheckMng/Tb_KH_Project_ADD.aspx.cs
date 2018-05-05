using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using KORWeb.BUL;
using WebFrame.Data;
using WebFrame;
using System.Data;

namespace OAWebSite2016.SysManager.WebUI.CheckMng
{
    public partial class Tb_KH_Project_ADD : System.Web.UI.Page
    {
        protected override void OnInit(EventArgs e)
        {
            this.byear.SelectedIndexChanged += new EventHandler(byear_SelectedIndexChanged);
            this.btnSubmit.ServerClick += new EventHandler(btnSubmit_ServerClick);
            base.OnInit(e);
        }

        //设置选择的年份
        void byear_SelectedIndexChanged(object sender, EventArgs e)
        {
            this.ProjectGuidID.Items.Clear();
            this.BindProject(int.Parse(this.byear.SelectedValue));
           
        }

        //提交按钮事件
        void btnSubmit_ServerClick(object sender, EventArgs e)
        {
            if (this.ProjectGuidID.SelectedValue != "")
            {
                Tb_ProjectBU bu1 = new Tb_ProjectBU();

            }
            else
            {
                UTools.Alert("请选择一个合适的项目!");
            }
        }


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                int year1 = DateTime.Now.Year;
                ListItem item1 = new ListItem(year1 + "年", year1 + "");
                this.byear.Items.Add(item1);

                year1--;
                ListItem item2 = new ListItem(year1 + "年", year1 + "");
                this.byear.Items.Add(item2);

                this.BindProject(int.Parse(this.byear.SelectedValue));
            }
        }


        /// <summary>
        /// 根据年份，绑定项目
        ///  (format(FinishDate, 'yyyy') = 2016) AND (Status = 2)
        /// </summary>
        /// <param name="year"></param>
        private void BindProject(int year)
        {
            Tb_ProjectBU bu1 = new Tb_ProjectBU();
            List<SearchField> condition = new List<SearchField>();
            condition.Add(new SearchField("Status", "2", SearchFieldType.NumericType));
            condition.Add(new SearchField("format(FinishDate, 'yyyy')", year + "", 
                SearchFieldType.NumericType));

            DataTable dt1 = bu1.GetListData(condition, -1, -1, "finishdate", "GuidID,prjName");
            foreach (DataRow dr1 in dt1.Rows)
            {
                ListItem item1 = new ListItem(dr1["prjName"].ToString(), dr1["GuidID"].ToString());
                this.ProjectGuidID.Items.Add(item1);
            }

            this.ProjectGuidID.Items.Insert(0, new ListItem("--请选择--", ""));
        }
    }
}
