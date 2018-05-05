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
using KORWeb.BUL;
using WebFrame.Util;
using System.Collections.Generic;

namespace OAWebSite2016.SysManager.WebUI.WorkPlanMng
{
    public partial class Tb_Task_Detail1 : System.Web.UI.Page
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
            //设置父编码的值

            Control con1 = this.bean1.CheckControls(out error);       //后台进行数据验证
            if (con1 != null)
            {
                UTools.Alert(error);
            }
            else
            {
                int succ = bean1.SaveDataToDb();
                if (succ == 1)
                {
                    String js1 = "layer.alert('操作成功!',function(index){;";
                    js1 = js1 + " var index = parent.layer.getFrameIndex(window.name);";
                    js1 = js1 + " parent.$('#butSearch').click();";
                    js1 = js1 + " parent.layer.close(index);});";
                    JAjax.ExecuteJS(js1);
                }
                else
                {
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
                this.bean1.SetControlValues();
                if (this.begDate.Text != String.Empty)
                {
                    this.begDate.Text = DateTime.Parse(this.begDate.Text).ToString("yyyy-MM-dd");
                }

                if (this.endDate.Text != String.Empty)
                {
                    this.endDate.Text = DateTime.Parse(this.endDate.Text).ToString("yyyy-MM-dd");
                }

                //设置提交按钮的出现条件
                if (this.Status.Text == "0" && this.AddUser.Text ==WebFrame.FrameLib.UserID)
                {
                    this.sec0.Visible = true;
                }
                else
                {
                    this.sec0.Visible = false;
                }
            }
            base.OnPreRenderComplete(e);
        }
    }
}
