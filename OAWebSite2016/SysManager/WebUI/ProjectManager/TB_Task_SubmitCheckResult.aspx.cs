using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using KORWeb.BUL;
using WebFrame.Util;
using System.Data;
using WebFrame.Data;

namespace OAWebSite2016.SysManager.WebUI.ProjectManager
{
    public partial class TB_Task_SubmitCheckResult : System.Web.UI.Page
    {
        protected override void OnInit(EventArgs e)
        {
            this.btnSubmit.ServerClick += new EventHandler(btnSubmit_ServerClick);
            base.OnInit(e);
        }

        //提交工单信息
        void btnSubmit_ServerClick(object sender, EventArgs e)
        {
            int succ = 0;
            WebFrame.Data.JConnect.GetConnect().BeginTrans();
            try
            {
                String guidid = Request.QueryString["GuidID"];
                Dictionary<string, object> dic1 = new Dictionary<string, object>();

                Tb_TaskBU bu1 = new Tb_TaskBU();

                //1--更新数据
                List<SearchField> condition = new List<SearchField>();
                condition.Add(new SearchField("Guidid", guidid));
                String t1 = String.Empty;
                if (this.CheckResult.SelectedValue == "1")
                {
                    dic1["LastWorkLoad"] = this.LastWorkload.Text;
                    dic1["Status"] = "4";
                    t1 = "工单通过审核";
                }
                else
                {
                    dic1["Status"] = "1";
                    t1 = "工单未通过审核";
                }

                bu1.EditData(condition, dic1);

                //2--创建日志
                Tb_Task_LogBU bu2 = new Tb_Task_LogBU();
                succ = bu2.NewLog(guidid, t1, this.Remark.Text, "0", this.file1);
                WebFrame.Data.JConnect.GetConnect().CommitTrans();
            }
            catch (Exception err)
            {
                WebFrame.Data.JConnect.GetConnect().RollBackTrans();
                succ = 0;
                WebFrame.Util.JTool.WriteErrorLog(err.ToString());
            }

            if (succ == 1)   //submit succ
            {
                String js1 = "layer.alert('操作成功!',function(index){;";
                js1 = js1 + " var index = parent.layer.getFrameIndex(window.name);";

                js1 = js1 + " parent.$('#butSearch').click();";
                js1 = js1 + " parent.layer.close(index);});";
                JAjax.ExecuteJS(js1);
            }
            else
            {
                //throw bean1.MyException;
                UTools.Alert("操作失败，请重试!");
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {

            }
        }



        protected override void OnPreRenderComplete(EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                String guidid = Request.QueryString["GuidID"];
                Tb_TaskBU bu1 = new Tb_TaskBU();
                DataRow dr1 = bu1.GetFirstDataRow(guidid, "Workload");
                if (dr1 != null)
                {
                    this.LastWorkload.Text = dr1["Workload"].ToString();
                }
            }
            base.OnPreRenderComplete(e);
        }
    }
}
