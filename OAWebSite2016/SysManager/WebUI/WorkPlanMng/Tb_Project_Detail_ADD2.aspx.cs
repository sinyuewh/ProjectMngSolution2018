using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebFrame.Util;

namespace OAWebSite2016.SysManager.WebUI.WorkPlanMng
{
    public partial class Tb_Project_Detail_ADD2 : System.Web.UI.Page
    {
        protected override void OnInit(EventArgs e)
        {
            this.btnSubmit.ServerClick += new EventHandler(btnSubmit_ServerClick);
            base.OnInit(e);
        }

        void btnSubmit_ServerClick(object sender, EventArgs e)
        {
            //判断项目编号
            if (String.IsNullOrEmpty(this.selecProject.SelectedValue))
            {
                KORWeb.BUL.UTools.Alert("错误：请选择一个合适的项目！");
                return;
            }

           
            //判断项目的Excel文件
            if (this.file1.HasFile == false)
            {
                KORWeb.BUL.UTools.Alert("错误：请选择一个合适的总体计划Excel文件！");
                return;
            }

            String fname = String.Empty;
            KORWeb.BUL.Tb_PlanDetailBU bu1 = new KORWeb.BUL.Tb_PlanDetailBU();
            List<KORWeb.DDL.Tb_PlanDetailDD> list1 = bu1.GetMonthPlanDetailListByExcel(this.file1, ref fname);
            if (list1.Count == 0)
            {
                KORWeb.BUL.UTools.Alert("错误：请选择一个合适的总体计划Excel文件！");
                return;
            }

            //对数据进行处理
            KORWeb.BUL.Tb_PlanBU bu = new KORWeb.BUL.Tb_PlanBU();
            bool succ = bu.ImportExcelToMonthPlan(this.selecProject.SelectedValue, int.Parse(this.PlanYear.SelectedValue),
                int.Parse(this.PlanMonth.SelectedValue), this.Remark.Text, this.file1.FileName, fname, list1);
            if (succ)
            {
                String js1 = "layer.alert('操作成功!',function(index){;";
                js1 = js1 + " var index = parent.layer.getFrameIndex(window.name);";
                js1 = js1 + " parent.$('#butSearch').click();";
                js1 = js1 + " parent.layer.close(index);});";
                JAjax.ExecuteJS(js1);
            }
            else
            {
                KORWeb.BUL.UTools.Alert("错误：操作失败，请重试！");
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                int year1 = DateTime.Now.Year;
                for (int i = year1 - 1; i <= year1 + 1;i++ )
                {
                    this.PlanYear.Items.Add(new ListItem(i+"",i+""));
                }
                this.PlanYear.SelectedValue = year1 + "";

                //设置月
                for (int i = 1; i <= 12; i++)
                {
                    this.PlanMonth.Items.Add(new ListItem(i + "", i + ""));
                }
                this.PlanMonth.SelectedValue = DateTime.Now.Month + "";

                //设置可用的项目
                KORWeb.BUL.Tb_ProjectBU bu1 = new KORWeb.BUL.Tb_ProjectBU();
                Dictionary<String, String> dic1 = bu1.GetUserManagerProjectForMonthPlan(WebFrame.FrameLib.UserID);
                if (dic1.Count > 0)
                {
                    foreach (KeyValuePair<String, String> item in dic1)
                    {
                        ListItem item1 = new ListItem(item.Value, item.Key);
                        this.selecProject.Items.Add(item1);
                    }
                }
            }
        }
    }
}
