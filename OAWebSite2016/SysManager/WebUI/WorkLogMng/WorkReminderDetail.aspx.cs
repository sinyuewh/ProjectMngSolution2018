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
using WebFrame;
using KORWeb.BUL;
using System.Collections.Generic;
using WebFrame.Util;

namespace OAWebSite2016.SysManager.WebUI.WorkLogMng
{
    public partial class WorkReminderDetail : System.Web.UI.Page
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
                this.bean1.SetControlValues();       //填充数据
                if (this.begDate.Text != String.Empty)
                {
                    this.begDate.Text = DateTime.Parse(this.begDate.Text).ToString("yyyy-MM-dd");
                }
                else
                {
                    this.begDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
                }

            }
            base.OnPreRenderComplete(e);
        }
    }
}
