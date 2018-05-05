using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using KORWeb.BUL;
using System.Data;
using WebFrame.Util;
using WebFrame.Data;

namespace OAWebSite2016.SysManager.WebUI.ProjectManager
{
    public partial class TB_Task_SubmitTestResult : System.Web.UI.Page
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
            int succ1 = 0;

            int bugA = 0;
            int bugB = 0;
            int bugC = 0;
            bool checkdata = true;

            //表示测试未通过，验证数据的合理性
            if (this.TestResult.SelectedValue == "0")
            {
                int.TryParse(this.BugA.Text, out bugA);
                int.TryParse(this.BugB.Text, out bugB);
                int.TryParse(this.BugC.Text, out bugC);

                if (bugA < 0 || bugB < 0 || bugC < 0 || (bugA + bugB + bugC) <= 0)
                {
                    checkdata = false;
                    UTools.Alert("提示：测试未通过，请至少输入一个BUG数量！");
                }
            }

            if (checkdata)
            {
                WebFrame.Data.JConnect.GetConnect().BeginTrans();
                try
                {
                    String guidid = Request.QueryString["GuidID"];
                    Dictionary<string, object> dic1 = new Dictionary<string, object>();

                    Tb_TaskBU bu1 = new Tb_TaskBU();

                    //1--更新数据
                    List<SearchField> condition = new List<SearchField>();
                    condition.Add(new SearchField("Guidid", guidid));
                    String result = String.Empty;
                    if (this.TestResult.SelectedValue == "1")
                    {
                        dic1["Status"] = "3";
                        result = "测试通过";
                        succ1 = 1;
                    }
                    else
                    {
                        dic1["Status"] = "1";
                        result = "测试未通过";
                    }

                    bu1.EditData(condition, dic1);

                    //2--创建日志
                    String relatefile=String.Empty;
                    String relatruename=String.Empty;

                    Tb_Task_LogBU bu2 = new Tb_Task_LogBU();
                    succ = bu2.NewLog(guidid, result, this.Remark.Text, "1", this.file1,
                        ref relatefile,ref relatruename);
                   

                    //3--登记Bug记录
                    if (this.TestResult.SelectedValue == "0")
                    {
                        Tb_Task_BugBU bu3 = new Tb_Task_BugBU();
                        succ1 = bu3.NewBug(guidid, bugA, bugB, bugC, 0, this.Remark.Text, relatefile, relatruename);
                    }

                    WebFrame.Data.JConnect.GetConnect().CommitTrans();
                }
                catch (Exception err)
                {
                    WebFrame.Data.JConnect.GetConnect().RollBackTrans();
                    succ = 0;
                    succ1 = 0;
                    WebFrame.Util.JTool.WriteErrorLog(err.ToString());
                }

                if (succ == 1 && succ1==1)   //submit succ
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
               
            }
            base.OnPreRenderComplete(e);
        }
    }
}
