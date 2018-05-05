using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebFrame.Util;
using KORWeb.BUL;

namespace OAWebSite2016.SysManager.WebUI.ProjectLogMng
{
    public partial class Tb_Project_Log_Detail : System.Web.UI.Page
    {
        protected override void OnInit(EventArgs e)
        {
            this.btnSubmit.ServerClick += new EventHandler(btnSubmit_ServerClick);
            base.OnInit(e);
        }

        //提交数据的代码
        void btnSubmit_ServerClick(object sender, EventArgs e)
        {
            String error = String.Empty;

            Control con1 = bean1.CheckControls(out error);  //后台进行数据验证
            if (con1 != null)
            {
                UTools.Alert(error);
            }
            else
            {
                int succ = bean1.SaveDataToDb();
                if (succ == 1)   //submit succ
                {
                    String js1 = "layer.alert('操作成功!',function(index){;";
                    js1 = js1 + " var index = parent.layer.getFrameIndex(window.name);";

                    js1 = js1 + " parent.$('#ctl00_ContentPlaceHolder1_butSearch2').click();";
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
            
        }

        protected override void OnPreRenderComplete(EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                this.bean1.SetControlValues();       //填充数据

                if (this.PlanTime.Text != String.Empty)
                {
                    this.PlanTime.Text = DateTime.Parse(this.PlanTime.Text).ToString("yyyy-MM-dd");
                }

                if (this.FinishTime.Text != String.Empty)
                {
                    this.FinishTime.Text = DateTime.Parse(this.FinishTime.Text).ToString("yyyy-MM-dd");
                }

                //系统产生的日志，不允许修改
                if (this.AddUserID.Text == "admin")
                {
                    this.sec0.Visible = false;
                }
                else
                {
                    if (this.Stitle.Text != String.Empty)
                    {
                        this.Stitle.ReadOnly = true;
                    }

                    if (this.PlanTime.Text != String.Empty)
                    {
                        this.PlanTime.ReadOnly = true;
                        this.PlanTime.Attributes.Remove("onclick");
                    }

                    if (this.FinishTime.Text != String.Empty)
                    {
                        this.FinishTime.ReadOnly = true;
                        this.FinishTime.Attributes.Remove("onclick");
                    }

                    bool isCanEdit = KORWeb.BUL.Tb_Project_LogBU.IsCanEdit(this.GuidID.Text);
                    if(isCanEdit==false)
                    {
                        this.sec0.Visible =false;
                    }
                }

            }
            base.OnPreRenderComplete(e);
        }
    }
}
