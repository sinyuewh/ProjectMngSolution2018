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
    public partial class Tb_Task_Detail_SubmitKH : System.Web.UI.Page
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
                Dictionary<String, object> dic1 = bean1.GetControlValues();
                dic1["Status"] = "2";

                int succ = bean1.SaveDataToDb(dic1);
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
                if (this.begdate1.Text == String.Empty)
                {
                    this.begdate1.Text = this.begDate.Text;
                }
                if (this.begdate1.Text != String.Empty)
                {
                    this.begdate1.Text = DateTime.Parse(this.begdate1.Text).ToString("yyyy-MM-dd");
                }

                if (this.finishDate.Text == String.Empty)
                {
                    this.finishDate.Text = this.endDate.Text;
                }
                if (this.finishDate.Text != String.Empty)
                {
                    this.finishDate.Text = DateTime.Parse(this.finishDate.Text).ToString("yyyy-MM-dd");
                }

                if (this.LastWorkLoad.Text == String.Empty || this.LastWorkLoad.Text =="0")
                {
                    this.LastWorkLoad.Text = this.Workload.Text;
                }

                //设置提交按钮的出现条件
                if (this.Status.Text == "1" && this.AddUser.Text ==WebFrame.FrameLib.UserID)
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
