using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using KORWeb.BUL;
using WebFrame.Util;

namespace OAWebSite2016.SysManager.WebUI.ProjectManager
{
    public partial class TB_Task_SubmitBUG : System.Web.UI.Page
    {
        protected override void OnInit(EventArgs e)
        {
            this.btnSubmit.ServerClick += new EventHandler(btnSubmit_ServerClick);
            base.OnInit(e);
        }

        //提交工单信息
        void btnSubmit_ServerClick(object sender, EventArgs e)
        {
            int bugA = 0;
            int bugB = 0;
            int bugC = 0;

            int.TryParse(this.BugA.Text, out bugA);
            int.TryParse(this.BugB.Text, out bugB);
            int.TryParse(this.BugC.Text, out bugC);

            int succ1 = 0;
            if (bugA < 0 || bugB < 0 || bugC < 0 || (bugA + bugB + bugC) <= 0)
            {
                UTools.Alert("提示：请至少输入一个BUG数量！");
            }
            else
            {
                try
                {
                    String guidid = Request.QueryString["GuidID"];
                    Dictionary<string, object> dic1 = new Dictionary<string, object>();

                    Tb_Task_BugBU bu3 = new Tb_Task_BugBU();
                    succ1 = bu3.NewBug(guidid, bugA, bugB, bugC, 1, this.Remark.Text, this.file1);
                }
                catch (Exception err)
                {
                    succ1 = 0;
                    WebFrame.Util.JTool.WriteErrorLog(err.ToString());
                }

                if (succ1 == 1)   //submit succ
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
