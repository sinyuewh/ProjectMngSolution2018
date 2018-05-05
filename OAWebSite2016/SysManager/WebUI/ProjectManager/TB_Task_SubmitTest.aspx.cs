using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using KORWeb.BUL;
using System.Data;
using WebFrame.Data;
using WebFrame.Util;

namespace OAWebSite2016.SysManager.WebUI.ProjectManager
{
    public partial class TB_Task_SubmitTest : System.Web.UI.Page
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
                dic1["finishDate"] = DateTime.Now;
                dic1["TestMan"] = this.TestMan.SelectedValue;
                dic1["TestUrl"] = this.TestUrl.Text;
                dic1["Status"] = "2";

                bu1.EditData(condition, dic1);

                //2--创建日志
                Tb_Task_LogBU bu2 = new Tb_Task_LogBU();
                succ = bu2.NewLog(guidid, "提交工单", this.Remark.Text, "2", this.file1);
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
                String guidid = Request.QueryString["GuidID"];
                Tb_TaskBU bu1 = new Tb_TaskBU();
                DataRow dr1=bu1.GetFirstDataRow(guidid, "TaskKind");
                int succ = 0;
                if (dr1 != null)
                {
                    String taskkind = dr1[0].ToString();
                    if (taskkind == "1")  //处理非开发工单
                    {
                        WebFrame.Data.JConnect.GetConnect().BeginTrans();

                        try
                        {
                            Dictionary<string, object> dic1 = new Dictionary<string, object>();

                            //1--更新数据
                            List<SearchField> condition = new List<SearchField>();
                            condition.Add(new SearchField("Guidid", guidid));
                            String result = String.Empty;
                            dic1["Status"] = "3";
                            dic1["finishDate"] = DateTime.Now;
                            result = "提交审核";


                            bu1.EditData(condition, dic1);

                            //2--创建日志
                            String relatefile = String.Empty;
                            String relatruename = String.Empty;

                            Tb_Task_LogBU bu2 = new Tb_Task_LogBU();
                            succ = bu2.NewLog(guidid, result, this.Remark.Text, "2", this.file1,
                                ref relatefile, ref relatruename);

                            WebFrame.Data.JConnect.GetConnect().CommitTrans();
                        }
                        catch (Exception err)
                        {
                            WebFrame.Data.JConnect.GetConnect().RollBackTrans();
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
                }
            }
        }



        protected override void OnPreRenderComplete(EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                String guidid = Request.QueryString["GuidID"];
                Tb_TaskBU bu1 = new Tb_TaskBU();
                DataRow dr1 = bu1.GetFirstDataRow(guidid, "TestUrl,TestMan");
                if (dr1 != null)
                {
                    this.TestUrl.Text = dr1["TestUrl"].ToString();
                    String testman = dr1["TestMan"].ToString();
                    if (this.TestMan.Items.FindByValue(testman) != null)
                    {
                        this.TestMan.SelectedValue = testman;
                    }
                }
            }
            base.OnPreRenderComplete(e);
        }
    }
}
