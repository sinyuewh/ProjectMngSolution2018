using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using KORWeb.BUL;
using WebFrame.Util;

namespace OAWebSite2016.SysManager.WebUI.ProjectMng
{
    public partial class Tb_Project_Detail : System.Web.UI.Page
    {
        protected override void OnInit(EventArgs e)
        {
            this.btnSubmit.ServerClick+=new EventHandler(btnSubmit_ServerClick);
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
                    //throw bean1.MyException;
                    UTools.Alert("操作失败，请重试!");
                }
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                this.bean1.SetControlValues();       //填充数据

                if (this.begDate.Text != String.Empty)
                {
                    this.begDate.Text = DateTime.Parse(this.begDate.Text).ToString("yyyy-MM-dd");
                }

                if (this.endDate.Text != String.Empty)
                {
                    this.endDate.Text = DateTime.Parse(this.endDate.Text).ToString("yyyy-MM-dd");
                }

                //得到项目的用户级别
                int t1 = KORWeb.BUL.Tb_ProjectBU.GetProjectClassByUserID(this.guidID.Text , WebFrame.FrameLib.UserID);
                
                //状态为0，才可以需改数据
                if (this.Status.Text == "0" && t1>=3)
                {
                    this.btnSubmit.Visible=true;
                    this.btnClose.Visible = true;
                }
                else
                {
                    this.btnSubmit.Visible = false;
                    this.btnClose.Visible = false;
                }
            }
        }

        protected override void OnPreRenderComplete(EventArgs e)
        {
            
            base.OnPreRenderComplete(e);
        }
    }
}
