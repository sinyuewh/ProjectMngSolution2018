using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebFrame.Util;
using KORWeb.BUL;
using WebFrame;

namespace OAWebSite2016.SysManager.WebUI.ProjectMng
{
    public partial class Tb_Project_Log_Detail : System.Web.UI.Page
    {
        protected override void OnInit(EventArgs e)
        {
            this.btnSubmit.ServerClick += new EventHandler(btnSubmit_ServerClick);
            base.OnInit(e);
        }

        void btnSubmit_ServerClick(object sender, EventArgs e)
        {
            this.SaveData();
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

                //设置编辑的权限
                this.sec0.Visible = (new Tb_ProjectBU()).IsCanEditProject(this.parentGuid.Text, FrameLib.UserID);
            }
            base.OnPreRenderComplete(e);
        }

        private void SaveData()
        {
            String error = String.Empty;
            bool succ = false;
            Control con1 = this.bean1.CheckControls(out error);  //后台进行数据验证
            if (con1 != null)
            {
                UTools.Alert(error);
            }
            else
            {
                try
                {
                    Dictionary<String, object> dic1 = new Dictionary<string, object>();
                    dic1["GuidID"] = this.GuidID.Text;
                    dic1["Stitle"] = this.Stitle.Text;
                    dic1["Content"] = this.Content.Text;
                    dic1["AddTime"] = DateTime.Now;

                    this.bean1.SaveDataToDb(dic1);
                    if (this.bean1.MyException != null)
                    {
                        throw this.bean1.MyException;
                    }
                    succ = true;
                }
                catch (Exception err)
                {
                    WebFrame.Util.JTool.WriteErrorLog(err.ToString());
                    succ = false;
                }

                if (succ)   //submit succ
                {
                    String js1 = "layer.alert('操作成功!',function(index){;";
                    js1 = js1 + " var index = parent.layer.getFrameIndex(window.name);";
                    js1 = js1 + " parent.$('#butSearch').click();";
                    //js1 = js1 + " parent.$('#ctl00$ContentPlaceHolder1$butPerson').click();";
                    js1 = js1 + " parent.layer.close(index);});";
                    JAjax.ExecuteJS(js1);
                }
                else
                {
                    UTools.Alert("操作失败，请重试!");
                }
            }
        }
    }
}
