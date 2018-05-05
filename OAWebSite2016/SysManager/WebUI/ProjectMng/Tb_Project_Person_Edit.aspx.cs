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
using System.Collections.Generic;
using WebFrame.Util;

namespace OAWebSite2016.SysManager.WebUI.ProjectMng
{
    public partial class Tb_Project_Person_Edit : System.Web.UI.Page
    {
        protected override void OnInit(EventArgs e)
        {
            this.btnSubmit.ServerClick += new EventHandler(btnSubmit_ServerClick);
            base.OnInit(e);
        }

        //submit data
        void btnSubmit_ServerClick(object sender, EventArgs e)
        {
            this.SaveData();
        }


        protected void Page_Load(object sender, EventArgs e)
        {

        }


        protected override void OnPreRenderComplete(EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                this.bean1.SetControlValues();

                int t1 = KORWeb.BUL.Tb_ProjectBU.GetProjectClassByUserID(this.parentGuid.Text, WebFrame.FrameLib.UserID);

                if (t1 >= 3)
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
                    dic1["num"] = this.num.Text;
                    dic1["GuidID"] = this.GuidID.Text;
                    dic1["PrjRole"] = this.PrjRole.SelectedValue;

                    dic1["UserID"] = this.UserID.SelectedValue;
                    dic1["UserName"] = this.UserID.SelectedItem.Text;

                    dic1["Weight"] = this.Weight.SelectedValue;

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
